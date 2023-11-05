local config = function()
    local theme = require("lualine.themes.gruvbox")

    -- set bg transparency in all modes
    theme.normal.c.bg = nil
    theme.insert.c.bg = nil
    theme.visual.c.bg = nil
    theme.replace.c.bg = nil
    theme.command.c.bg = nil

    require("lualine").setup({
        options = {
            theme = theme,
            globalstatus = true,
            component_separators = { left = '╲', right = '╱' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = { 'NvimTree', 'Outline' },
            },
            ignore_focus = {},
            always_divide_middle = true,
        },
        tabline = {
            lualine_a = { "mode" },
            lualine_b = { "buffers" },
            lualine_y = { "progress" },
            lualine_z = { 'location' }
        },
        sections = {
            lualine_a = {},
            lualine_b = {
                'branch',
                {
                    'filename',
                    file_status = true,     -- Displays file status (readonly status, modified status)
                    newfile_status = false, -- Display new file status (new file means no write after created)
                    path = 0,               -- 0: Just the filename
                    -- 1: Relative path
                    -- 2: Absolute path
                    -- 3: Absolute path, with tilde as the home directory
                    -- 4: Filename and parent dir, with tilde as the home directory

                    shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                    -- for other components. (terrible name, any suggestions?)
                    symbols = {
                        modified = '[+]',      -- Text to show when the file is modified.
                        readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                        unnamed = '[No Name]', -- Text to show for unnamed buffers.
                        newfile = '[New]',     -- Text to show for newly created file before first write
                    }
                }
            },
            lualine_c = { "diff" },
            lualine_x = { "encoding", "fileformat" },
            lualine_y = { 'diagnostics',
                {
                    'filetype',
                    colored = true,            -- Displays filetype icon in color if set to true
                    icon_only = false,         -- Display only an icon for filetype
                    icon = { align = 'left' }, -- Display filetype icon on the right hand side
                    -- icon =    {'X', align='right'}
                    -- Icon string ^ in table is ignored in filetype component
                }
            },
            lualine_z = {}
        },
        inactive_sections = {},
    })
end

return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = config,
}
