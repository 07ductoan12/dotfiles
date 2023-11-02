return {
    -- Scroll bar
    "petertriho/nvim-scrollbar",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("scrollbar").setup({
            handle = {
                color = "#bf616a",
            },
        })
    end,
}
