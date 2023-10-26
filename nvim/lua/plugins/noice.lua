return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
	},
  lazy = false,
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			config = function()
				require("notify").setup({
    background_colour = "#000000",
    fps = 30,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
    },
    level = 2,
    minimum_width = 50,
    render = "default",
    stages = "fade_in_slide_out",
    timeout = 5000,
    top_down = true,
    on_open = function(win)
        vim.api.nvim_win_set_option(win, "winblend", 30)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
})
			end,
		},
	},
}
