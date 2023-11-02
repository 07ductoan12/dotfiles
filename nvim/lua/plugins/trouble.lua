return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup({
            mode = "workspace_diagnostics",
            "document_diagnostics",
            "quickfix",
            "lsp_references",
            "loclist",
        })
    end,
}
