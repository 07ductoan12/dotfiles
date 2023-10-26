return {
  "voldikss/vim-floaterm",
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  config = function()
    vim.g["floaterm_position"] = 'topright'
    vim.g["floaterm_width"] = 0.7
    vim.g["floaterm_height"] = 0.7
    vim.g["floaterm_title"] = 'Terminal ($1/$2)'
    vim.g["floaterm_wintype"] = 'float'
    vim.g["floaterm_rootmarkers"] = '.project'
  end
}
