local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local cmd_options = { noremap = true, silent = true }

-- Nerd Tree
keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
keymap.set('n', '<leader>f', ':NvimTreeFocus<CR>', opts)

-- Pane and Window Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts) -- Navigate Left
keymap.set("n", "<C-j>", "<C-w>j", opts) -- Navigate Down
keymap.set("n", "<C-k>", "<C-w>k", opts) -- Navigate Up
keymap.set("n", "<C-l>", "<C-w>l", opts) -- Navigate Right

-- Window Management
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts)          -- Split Vertically
keymap.set("n", "<leader>sh", ":ssplit<CR>", opts)          -- Split Horizontally
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- Toggle Minimize

-- Indeting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Comments
vim.api.nvim_set_keymap("n", "C-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "C-_>", "gcc", { noremap = false })

-- Buffer
keymap.set("n", "]b", ":bnext<CR>", cmd_options)
keymap.set("n", "[b", ":bprevious<CR>", cmd_options)

-- resize buf
keymap.set('n', '<A-h>', "<CMD>:SmartResizeLeft<CR>", opts)
keymap.set('n', '<A-j>', "<CMD>:SmartResizeDown<CR>", opts)
keymap.set('n', '<A-k>', "<CMD>:SmartResizeUp<CR>", opts)
keymap.set('n', '<A-l>', "<CMD>:SmartResizeRight<CR>", opts)


-- git
keymap.set("n", "<leader>lg", "<Cmd>:LazyGit<CR>", cmd_options)
keymap.set('n', '<leader>hs', '<Cmd>:Gitsigns stage_hunk<CR>', cmd_options)
keymap.set('v', '<leader>hs', '<Cmd>:Gitsigns stage_hunk<CR>', cmd_options)
keymap.set('n', '<leader>hr', '<Cmd>:Gitsigns reset_hunk<CR>', cmd_options)
keymap.set('v', '<leader>hr', '<Cmd>:Gitsigns reset_hunk<CR>', cmd_options)
keymap.set('n', '<leader>hS', '<Cmd>:Gitsigns stage_buffer<CR>', cmd_options)
keymap.set('n', '<leader>hu', '<Cmd>:Gitsigns undo_stage_hunk<CR>', cmd_options)
keymap.set('n', '<leader>hR', '<Cmd>:Gitsigns reset_buffer<CR>', cmd_options)
keymap.set('n', '<leader>hp', '<Cmd>:Gitsigns preview_hunk<CR>', cmd_options)
keymap.set('n', '<leader>lb', '<Cmd>:Gitsigns toggle_current_line_blame<CR>', cmd_options)

-- Floaterm
keymap.set('n', '<A-p>', '<CMD>:FloatermNext<CR>')
keymap.set('t', '<A-p>', '<CMD>:FloatermNext<CR>')
keymap.set('n', '<A-n>', '<CMD>:FloatermPrev<CR>')
keymap.set('t', '<A-n>', '<CMD>:FloatermPrev<CR>')
keymap.set('n', '<A-i>', '<CMD>:FloatermToggle<CR>')
keymap.set('t', '<A-i>', '<CMD>:FloatermToggle<CR>')
keymap.set('n', '<A-k>', '<CMD>:FloatermKill<CR>')
keymap.set('t', '<A-k>', '<CMD>:FloatermKill<CR>')
keymap.set('n', '<A-t>', '<CMD>:FloatermNew<CR>')
keymap.set('t', '<A-t>', '<CMD>:FloatermNew<CR>')
keymap.set('n', '<leader>cc', '<CMD>:FloatermNew --autoclose=0 g++ % -o %<.exe && ./%<.exe <CR>')
keymap.set('n', '<C-p>', '<CMD>:FloatermNew --autoclose=0 python3 %<.py <CR>')
keymap.set('n', '<A-c>', ':bd<CR>', opts)
keymap.set('t', '<A-c>', ':bd<CR>', opts)

-- fold
keymap.set('n', 'zR', require('ufo').openAllFolds)
keymap.set('n', 'zM', require('ufo').closeAllFolds)
keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of coc.nvim and nvim lsp
        vim.fn.CocActionAsync('definitionHover') -- coc.nvim
        vim.lsp.buf.hover()
    end
end)
