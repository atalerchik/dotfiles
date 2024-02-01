return {
	'lewis6991/gitsigns.nvim',
	cond = function()
		-- Check if the current directory is a git repository
		return vim.fn.isdirectory('.git') ~= 0 or vim.fn.system('git rev-parse --is-inside-work-tree') == 'true\n'
	end,
	config = function ()
		require('gitsigns').setup()
	end
}

