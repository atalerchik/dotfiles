return {
	'ThePrimeagen/git-worktree.nvim',
	cond = function()
		-- Check if the current directory is a git repository
		return vim.fn.isdirectory('.git') ~= 0 or vim.fn.system('git rev-parse --is-inside-work-tree') == 'true\n'
	end,
	config = function ()
		require('git-worktree').setup()
	end
}
