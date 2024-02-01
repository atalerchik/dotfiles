local opt = vim.opt

-- Enable mouse
vim.o.mouse = 'a'

-- Set encoding
vim.o.encoding = 'utf-8'

-- Enable line numbers
opt.relativenumber = true
vim.wo.number = true

-- Disable swap file
vim.o.swapfile = false

-- Set scrolloff
vim.o.scrolloff = 7

-- Set tabstop, softtabstop, shiftwidth, and expandtab
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Enable autoindent
vim.o.autoindent = true
vim.o.smartindent = true

-- Set fileformat
vim.o.fileformat = 'unix'

-- Set numberwidth
vim.o.numberwidth = 2

-- Enable filetype-specific indent files
vim.cmd('filetype indent on')

-- Netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 3

-- Line wrap 
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true


-- Vim markdown (vim-markdown-set-header-folding-level)
vim.g.vim_markdown_folding_level = 6


opt.expandtab = false;

-- disable netrw at the very start of init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Apperance
opt.cursorline = true
opt.termguicolors = true
