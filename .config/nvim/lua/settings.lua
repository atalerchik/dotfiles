local opt = vim.opt

-- Set encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"

-- vim.opt.backup = false
-- vim.opt.showcmd = true
-- vim.opt.cmdheight = 0
-- vim.opt.laststatus = 0
vim.opt.inccommand = "split"
vim.opt.backspace = { "start", "eol", "indent" }

vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.mouse = ""

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
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.breakindent = true


-- Set numberwidth
vim.o.numberwidth = 2

-- Enable filetype-specific indent files
vim.cmd("filetype indent on")

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

opt.expandtab = false
vim.opt.smarttab = true

-- disable netrw at the very start of init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Apperance
opt.cursorline = true
opt.termguicolors = true
vim.o.hidden = true
vim.o.updatetime = 300
vim.o.timeoutlen = 500

-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = "yes"

-- Always keep 8 lines above/below cursor unless at start/end of file
vim.opt.scrolloff = 10

vim.o.conceallevel = 2
vim.api.nvim_set_hl(2, "HelpBar", { link = "Normal" })
vim.api.nvim_set_hl(2, "HelpStar", { link = "Normal" })
