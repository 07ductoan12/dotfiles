local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
  require("neoconf").setup({})
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local lspconfig = require("lspconfig")
  local utils = require('lspconfig.util')
  local navic = require("nvim-navic")

  for type, icon in pairs(diagnostic_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  local capabilities = cmp_nvim_lsp.default_capabilities()

  -- lua
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = { -- custom settings for lua
      Lua = {
        -- make the language server recognize "vim" global
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          -- make language server aware of runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
  })

  -- json
  lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "json", "jsonc" },
  })

  local function set_python_path(path)
    local clients = vim.lsp.get_active_clients {
      bufnr = vim.api.nvim_get_current_buf(),
      name = 'pyright',
    }
    for _, client in ipairs(clients) do
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
      client.notify('workspace/didChangeConfiguration', { settings = nil })
    end
  end

  local function organize_imports()
    local params = {
      command = 'pyright.organizeimports',
      arguments = { vim.uri_from_bufnr(0) },
    }
    vim.lsp.buf.execute_command(params)
  end

  -- python
  require 'lspconfig'.pyright.setup {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require("nvim-navic").attach(client, bufnr)
    end,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true
        }
      }
    },
    command = {
      PyrightOrganizeImports = {
        organize_imports,
        description = 'Organize Imports',
      },
      PyrightSetPythonPath = {
        set_python_path,
        description = 'Reconfigure pyright with the provided python path',
        nargs = 1,
        complete = 'file',
      },
    },
    single_file_support = true
  }
  local function switch_source_header(bufnr)
    bufnr = utils.validate_bufnr(bufnr)
    local clangd_client = utils.get_active_client_by_name(bufnr, 'clangd')
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    if clangd_client then
      clangd_client.request('textDocument/switchSourceHeader', params, function(err, result)
        if err then
          error(tostring(err))
        end
        if not result then
          print 'Corresponding file cannot be determined'
          return
        end
        vim.api.nvim_command('edit ' .. vim.uri_to_fname(result))
      end, bufnr)
    else
      print 'method textDocument/switchSourceHeader is not supported by any servers active on the current buffer'
    end
  end

  require 'lspconfig'.clangd.setup {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require("nvim-navic").attach(client, bufnr)
    end,
    commands = {
      ClangdSwitchSourceHeader = {
        function()
          switch_source_header(0)
        end,
        description = 'Switch between source/header',
      },
    },
    single_file_support = true
  }

  -- typescript
  lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
      "typescript",
    },
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
  })

  -- bash
  lspconfig.bashls.setup {
    cmd = { 'bash-language-server', 'start' },
    settings = {
      bashIde = {
        globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
      },
    },
    filetypes = { 'sh' },
    root_dir = utils.find_git_ancestor,
    single_file_support = true,
  }

  -- html, typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
  lspconfig.emmet_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
      "html",
      "typescriptreact",
      "javascriptreact",
      "javascript",
      "css",
      "sass",
      "scss",
      "less",
      "svelte",
      "vue",
    },
  })

  lspconfig.yamlls.setup {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yaml.docker-compose' },
    root_dir = utils.find_git_ancestor,
    single_file_support = true,
    settings = {
      redhat = { telemetry = { enabled = false } },
    },
  }

  -- docker
  lspconfig.dockerls.setup {
    cmd                 = { "docker-langserver", "--stdio" },
    filetypes           = { "dockerfile" },
    capabilities        = capabilities,
    single_file_support = true,
    root_dir            = utils.root_pattern 'Dockerfile',
    on_attach           = function(client, bufnr)
      on_attach(client, bufnr)
      require("nvim-navic").attach(client, bufnr)
    end,
  }


  local luacheck = require("efmls-configs.linters.luacheck")
  local stylua = require("efmls-configs.formatters.stylua")
  local flake8 = require("efmls-configs.linters.flake8")
  local black = require("efmls-configs.formatters.black")
  local eslint_d = require("efmls-configs.linters.eslint_d")
  local prettierd = require("efmls-configs.formatters.prettier_d")
  local fixjson = require("efmls-configs.formatters.fixjson")
  local shellcheck = require("efmls-configs.linters.shellcheck")
  local shfmt = require("efmls-configs.formatters.shfmt")
  local alex = require("efmls-configs.linters.alex")
  local hadolint = require("efmls-configs.linters.hadolint")
  local solhint = require("efmls-configs.linters.solhint")

  -- configure efm server
  lspconfig.efm.setup({
    filetypes = {
      "lua",
      "python",
      "json",
      "jsonc",
      "sh",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "svelte",
      "vue",
      "markdown",
      "docker",
      "solidity",
    },
    init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
      hover = true,
      documentSymbol = true,
      codeAction = true,
      completion = true,
    },
    settings = {
      languages = {
        lua = { luacheck, stylua },
        python = { flake8, black },
        typescript = { eslint_d, prettierd },
        json = { eslint_d, fixjson },
        jsonc = { eslint_d, fixjson },
        sh = { shellcheck, shfmt },
        javascript = { eslint_d, prettierd },
        javascriptreact = { eslint_d, prettierd },
        typescriptreact = { eslint_d, prettierd },
        svelte = { eslint_d, prettierd },
        vue = { eslint_d, prettierd },
        markdown = { alex, prettierd },
        docker = { hadolint, prettierd },
        solidity = { solhint },
      },
    },
  })
end

return {
  "neovim/nvim-lspconfig",
  config = config,
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim",
    "creativenull/efmls-configs-nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
  },
}
