local keymap = vim.keymap
local opts = { noremap = true, silent = true }

return {
    -- Search engine
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
        require("telescope").setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--no-ignore",
                    "--smart-case",
                    "--hidden",
                },
                file_ignore_patterns = { ".git/", ".settings/", ".metadata/", "target/", "node_modules/", ".class$" },
                mappings = {
                    i = {
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
                    },
                },
                layout_strategy = "horizontal",
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                -- path_display = { "absolute" },
                color_devicons = true,
                use_less = true,
                -- set_env = { ["COLORTERM"] = "truecolor" },
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            },
            pickers = {
                find_files = {
                    theme = "dropdown",
                    previewer = false,
                    hidden = true,
                },
                live_grep = {
                    theme = "dropdown",
                    previewer = false,
                },
                buffers = {
                    theme = "dropdown",
                    previewer = false,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })
    end,
    keys = {
        keymap.set('n', '<leader>fk', ":Telescope keymaps<CR>", opts),
        keymap.set('n', '<leader>fh', ":Telescope help_tags<CR>", opts),
        keymap.set('n', '<leader>ff', ":Telescope find_files<CR>", opts),
        keymap.set('n', '<leader>fg', ":Telescope live_grep<CR>", opts),
        keymap.set('n', '<leader>fb', ":Telescope buffers<CR>", opts),
        keymap.set('n', '<leader>fa', ":Telescope <CR>", opts),
    }
}
