local opts = {
  ensure_installed = {
    "bashls",
    "pyright",
    "tsserver",
    "clangd",
    "emmet_ls",
    "pyright",
    "ltex",
    "jsonls",
    "marksman",
    "html",
    "cssls",
    "lua_ls",
    "texlab",
    "yamlls",
    "dockerls",
    "sqlls",
    "efm",
    "emmet_language_server"
  },
  -- auto-install configured servers (with lspconfig)
  automatic_installation = true, -- not the same as ensure_installed
}

return {
  "williamboman/mason-lspconfig.nvim",
  opts = opts,
  event = "BufReadPre",
  dependencies = "williamboman/mason.nvim"
}
