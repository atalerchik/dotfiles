return {
	'tpope/vim-surround',
	'williamboman/mason-lspconfig.nvim',
	'L3MON4D3/LuaSnip',
	'hrsh7th/nvim-cmp',
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
	},
	'hrsh7th/cmp-nvim-lsp',
	-- Git
	{
		'tpope/vim-fugitive',
		cmd = 'G', -- Load when the 'G' command is used
	},
	-- Visual enhancements and themes
	'xiyaowong/transparent.nvim',
	{
		'ellisonleao/gruvbox.nvim',
		config = function ()
			vim.cmd [[colorscheme gruvbox]]
		end
	},
}
