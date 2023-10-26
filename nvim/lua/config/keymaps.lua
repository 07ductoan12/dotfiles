local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Nerd Tree
keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
keymap.set('n', '<leader>f', ':NvimTreeFocus<CR>', opts)

-- Pane and Window Navigation
keymap.set("n","<C-h>", "<C-w>h",  opts) -- Navigate Left
keymap.set("n","<C-j>", "<C-w>j",  opts) -- Navigate Down
keymap.set("n","<C-k>", "<C-w>k",  opts) -- Navigate Up
keymap.set("n","<C-l>", "<C-w>l", opts) -- Navigate Right

-- Window Management
keymap.set("n", "<leader>sv",":vsplit<CR>", opts) -- Split Vertically
keymap.set("n", "<leader>sh",":ssplit<CR>", opts) -- Split Horizontally
keymap.set("n", "<leader>sm",":MaximizerToggle<CR>", opts) -- Toggle Minimize

-- Indeting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Comments
vim.api.nvim_set_keymap("n", "C-_>", "gcc", {noremap = false})
vim.api.nvim_set_keymap("v", "C-_>", "gcc", {noremap = false})
