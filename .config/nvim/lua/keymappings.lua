-- Make Space <leader> key
vim.g.mapleader = " "

local keymap = vim.keymap;

-- quickfix items
keymap.set('n', '<leader>h', '<cmd>cnext<CR>zz')
keymap.set('n', '<leader>;', '<cmd>cprev<CR>zz')

keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- move lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- center screen 
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- safe past from buffer
keymap.set("x", "<leader>p", [["_dP]])

-- copy in system registry
keymap.set({"n", "v"}, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

-- safe delete
keymap.set({"n", "v"}, "<leader>d", [["_d]])

keymap.set('n', '<space>e', vim.diagnostic.open_float)
keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Map 'jk' to <esc> in insert mode
vim.api.nvim_set_keymap('i', 'jk', '<esc>', {})

-- Obsidian 
keymap.set('n', '<leader>ot', ':ObsidianToday<CR>')
keymap.set('n', '<leader>oy', ':ObsidianYesterday<CR>')
keymap.set('n', '<leader>obl', ':ObsidianBacklinks<CR>')

-- Maker dir for this file
keymap.set('n', '<leader>md', ':!mkdir -p %:h<CR>', { noremap = true, silent = true })

-- Add javascript console loge for current word or section
keymap.set('n', '<leader>cl', 'yiwoconsole.log("", <C-r>o);<ESC>', { noremap = true, silent = true })
keymap.set('v', '<leader>cl', 'yOconsole.log("", <C-r>"");<ESC>', { noremap = true, silent = true })

keymap.set('v', '<leader>wf', 'Sfunction () {<CR><C-r>"<CR>}<ESC>', { noremap = true, silent = true })

keymap.set('n', '<leader>zz', ':ZenMode<cr>', { noremap = true, silent = true })

-- Clear highlights
keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- Create ADR
keymap.set('n', '<leader>adr', ':e ~/projects/atlas/adr-documentation/ADR-<C-R>=strftime("%Y%m%d%H%M%S")<CR>.md<CR>', { noremap = true, silent = true})

