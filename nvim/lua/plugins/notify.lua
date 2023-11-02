return {
    "rcarriga/nvim-notify",
    lazy = false,
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
            require("telescope").load_extension("notify")
        })

        vim.notify = function(msg, log_level, _opts)
            if msg:match("exit code") then return end
            if log_level == vim.log.levels.ERROR then
                vim.api.nvim_err_writeln(msg)
            else
                vim.api.nvim_echo({ { msg } }, true, {})
            end
        end
    end,
}
