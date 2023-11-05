local opt = vim.opt
local setg = vim.g
local utils = require "util.utils"

-- Tab / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = "120"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 10
opt.completeopt = "menuone,noinsert,noselect"

-- Behaviour
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.iskeyword:append("-")
opt.mouse:append("a")
opt.clipboard:append("unnamedplus")
opt.modifiable = true
-- opt.guicursor ="n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
setg.loaded_netrw = 1
setg.loaded_netrwPlugin = 1
opt.encoding = "UTF-8"
vim.cmd("autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o")
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

vim.opt.shortmess:append "c"

vim.cmd [[set fcs=eob:\ ]]
vim.cmd [[filetype plugin indent on]]

utils.set_indent_sizes { go = 4, python = 4, rust = 4, cpp = 4, c = 4, make = 4, lua = 4, java = 4, json = 4, xml = 4 }
