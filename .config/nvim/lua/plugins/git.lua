return {
	{
		'lewis6991/gitsigns.nvim',
		cond = function()
			return vim.fn.isdirectory('.git') ~= 0 or vim.fn.system('git rev-parse --is-inside-work-tree') == 'true\n'
		end,
		config = function ()
			require('gitsigns').setup()

			-- preview hunk
			vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>')
			-- toggle blame line
			vim.keymap.set('n', '<leader>gt', ':Gitsigns toggle_current_line_blame<CR>', {})
		end
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",

			"nvim-telescope/telescope.nvim",
		},
		config = true
	},
	{
		'ThePrimeagen/git-worktree.nvim',
		cond = function()
			-- Check if the current directory is a git repository
			return vim.fn.isdirectory('.git') ~= 0 or vim.fn.system('git rev-parse --is-inside-work-tree') == 'true\n'
		end,
		config = function ()
			require('git-worktree').setup()
		end
	}
}

