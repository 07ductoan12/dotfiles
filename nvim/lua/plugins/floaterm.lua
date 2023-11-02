return {
    "voldikss/vim-floaterm",
    lazy = false,
    config = function()
        vim.g["floaterm_position"] = 'topright'
        vim.g["floaterm_width"] = 0.5
        vim.g["floaterm_height"] = 0.5
        vim.g["floaterm_title"] = 'Terminal ($1/$2)'
        vim.g["floaterm_wintype"] = 'float'
        vim.g["floaterm_rootmarkers"] = '.project'
    end
}
