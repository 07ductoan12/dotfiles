return {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
    lazy = false,
    config = function()
        require("telescope").load_extension("dap")
    end,
}
