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
        "emmet_language_server",
        "jdtls",
        "docker_compose_language_service",
        "jdtls",
        "lemminx"
    },
    -- auto-install configured servers (with lspconfig)
    automatic_installation = true, -- not the same as ensure_installed
}

return {
    "williamboman/mason-lspconfig.nvim",
    opts = opts,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "williamboman/mason.nvim"
}
