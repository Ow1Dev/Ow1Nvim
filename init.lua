vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Scrolloff
local scrolloff = math.floor(vim.o.lines / 2) - 3
vim.opt.scrolloff = scrolloff

require("plugins.init")
require("config.binds")
require("config.autocmd")

vim.cmd.colorscheme("nordic")

-- Allows neovim to access the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Line numbers
vim.opt.cursorline = true
vim.wo.relativenumber = true
vim.wo.number = true

-- Windows
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.o.winborder = "rounded"
vim.o.pumheight = 10 -- max height of completion menu
vim.o.pumborder = vim.o.winborder

-- Sane tab management
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

-- Undo management
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Better Highlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true

-- Nowrap
vim.opt.wrap = false

-- Indent
vim.o.autoindent = true

-- Ignore case and some flash nvim stuff
vim.o.ignorecase = true
vim.o.smartcase = true
