local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local action_state = require("telescope.actions.state")

local java = require("lsp.languages.java")

local _jdtls, jdtls = pcall(require, "jdtls")
local _handlers, handlers = pcall(require, "lsp.handlers")

if not _jdtls or not _handlers then
    return
end

local function on_init(client)
    if client.config.settings then
        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
end

local share_dir = "/home/toan/d/workspaces/java/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = share_dir .. project_name

-- Set proper Java executable
local java_cmd = "java"
local mason_registry = require("mason-registry")

local bundles = {
    mason_registry.get_package("java-debug-adapter"):get_install_path()
    .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
}
vim.list_extend(
    bundles,
    vim.split(
        vim.fn.glob(mason_registry.get_package("java-test"):get_install_path() .. "/extension/server/*.jar"),
        "\n"
    )
)

local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()

local config = {
    cmd = {
        java_cmd,
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms512m",
        "-Xmx2048m",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar",
        "-configuration",
        jdtls_path .. "/config_linux",
        "-data",
        workspace_dir,
    },
    flags = {
        debounce_text_changes = 150,
        allow_incremental_sync = true,
    },
    --root_dir = require("jdtls.setup").find_root({"build.gradle", "pom.xml", ".git"}),
    -- Using .project file (Eclipse workspace) as reference for setting root dir
    root_dir = jdtls.setup.find_root({ ".project", "pom.xml", ".git" }),

    on_init = on_init,
    init_options = {
        bundles = bundles,
    },
    capabilities = handlers.capabilities,
    on_attach = java.lsp.on_attach,
    settings = {
        java = {
            signatureHelp = {
                enabled = true,
            },
            saveActions = {
                organizeImports = true,
            },
            completion = {
                maxResults = 20,
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
            },
        },
    },
}

local M = {}

M.start = function()
    require("jdtls.ui").pick_one_async = function(items, prompt, label_fn, cb)
        local opts = {}
        pickers.new(opts, {
            prompt_title = prompt,
            finder = finders.new_table({
                results = items,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = label_fn(entry),
                        ordinal = label_fn(entry),
                    }
                end,
            }),
            sorter = sorters.get_generic_fuzzy_sorter(),
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()

                    actions.close(prompt_bufnr)

                    cb(selection.value)
                end)

                return true
            end,
        }):find()
    end
    jdtls.start_or_attach(config)
end

return M
