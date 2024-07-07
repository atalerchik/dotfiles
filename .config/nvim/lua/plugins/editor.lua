return {
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {}
	},
	{
		'theprimeagen/harpoon',
		config = function ()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>a", mark.add_file)
			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

			vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
			vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
			vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
			vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
		end
	},
	{
		'numToStr/Comment.nvim',
		dependencies = {
			'JoosepAlviste/nvim-ts-context-commentstring',
		},
		config = function()
			require('ts_context_commentstring').setup {
				enable_autocmd = false,
			}
			require('Comment').setup {
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			}
		end,
	},

	-- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		keys = {
			{
				"<leader>rn",
				function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				desc = "Incremental rename",
				mode = "n",
				noremap = true,
				expr = true,
			},
		},
		config = true,
	},

	-- Refactoring tool
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor({
						show_success_message = true,
					})
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},
}
