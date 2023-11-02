return {
    "folke/trouble.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
