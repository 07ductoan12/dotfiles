local config = function()
    local whichkey = require "which-key"

    local conf = {
        window = {
            border = "single",   -- none, single, double, shadow
            position = "bottom", -- bottom, top
        },
    }

    local opts = {
        mode = "n",     -- Normal mode
        prefix = "<leader>",
        silent = true,  -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true,  -- use `nowait` when creating keymaps
    }

    local mappings = {
        ["<leader>"] = {
            name = "Util",
            w = { "<cmd>update!<CR>", "Save" },
            q = { "<cmd>q!<CR>", "Quit" },
            Q = { "<cmd>qall!<cr>", "[BUFFER] Quit all without saving" },
            c = { "<Cmd>bd!<Cr>", "Close current buffer" },
            x = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
            Z = { "<cmd>wall<cr>", "[BUFFER] Save all" },

        },
        ["c"] = {
            name = "[Code navigation]",
            l = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "[LSP] Go to declaration" },
            d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "[LSP] Go to definition" },
            t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "[LSP] Go to type definition" },
            i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "[LSP] Go to implementation" },
            s = { "<cmd>lua require'jdtls'.super_implementation()<cr>", "[JDLTS] Go to super implementation" },
            r = { "<cmd>lua vim.lsp.buf.references()<cr>", "[LSP] Go to references" },
            v = { "<cmd>Lspsaga hover_doc<cr>", "[LSP] Hover" },
            c = { "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", "[LSP] Show incoming calls" },
            h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "[LSP] Signature help" },
            x = { "<cmd>lua require'telescope.builtin'.treesitter{ symbols = {'method', 'function'}}<cr>",
                "[TELESCOPE] Get current buffer functions",
            },
        },
        [";;"] = { "<cmd>noh<cr>", "Clean search highlights" },
        ["<leader>f"] = {
            name = "[TELESCOPE]",
            e = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "[TELESCOPE] Find File" },
            n = { "<cmd>Telescope grep_string<cr>", "[TELESCOPE] Find files using grep in file names" },
            g = { "<cmd>Telescope live_grep<cr>", "[TELESCOPE] Find File by live grep (search content inside file)" },
            b = { "<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers" },
            m = { "<cmd>Telescope marks<cr>", "[TELESCOPE] Marks" },
            h = { "<cmd>Telescope oldfiles<cr>", "[TELESCOPE] Recent files" },
            d = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "[TELESCOPE] Current buffer fuzzy find" },
            t = { "<cmd>TodoTelescope<cr>", "[TELESCOPE] TODO list" },
            c = { "<cmd>Telescope command_history<cr>", "[TELESCOPE] Search command history" },
            x = { "<cmd>Telescope neoclip<cr>", "[TELESCOPE] Search in clipboard manager" },
            p = { "<cmd>Telescope projects<cr>", "[TELESCOPE] Search projects" },
            s = { "<cmd>Telescope lsp_document_symbols<cr>", "[TELESCOPE LSP] Find symbols" },
            r = { "<cmd>Telescope lsp_references<cr>", "[TELESCOPE LSP] Find references" },
        },
        -- Folds
        ["|"] = { "zM", "[FOLDS] Collapse all folds" },
        ["--"] = { "zR", "[FOLDS] Expand all folds" },
        ["<a-s-down>"] = { "zr", "[FOLDS] Increase fold level" },
        ["<a-s-up>"] = { "zm", "[FOLDS] Decrease fold level" },

        ["rf"] = {
            name = "[Code refactor]",
            e = { "<cmd>Lspsaga code_action<cr>", "[LSP] Code actions" },
            f = { "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>",
                "[CONFORM] Format code" },
            n = { "<cmd>Lspsaga rename<cr>", "[LSP] Rename" },
            o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "[JDLTS] Organize imports" },
        },

        ["<leader>v"] = {
            name = "[Views]",
            p = { "<cmd>TroubleTopgle<cr>", "[TROUBLE] Toggle" },
            s = { "<cmd>AerialToggle<cr>", "[AERIAL] Toggle" },
            t = { "<cmd>ToggleTerm<cr>", "[TOGGLETERM] Open new terminal" },
            u = { "<cmd>UndotreeToggle<cr>", "[UNDOTREE]Toggle undotree" },
        },

        -- Display modes
        ["<leader>m"] = {
            name = "[Display modes]",
            z = { "<cmd>ZenMode<cr>", "[MODE] Toggle zen mode" },
        },

    }

    whichkey.setup(conf)
    whichkey.register(mappings, opts)
end
return {
    "folke/which-key.nvim",
    lazy = false,
    opts = {},
    config = config,
}
