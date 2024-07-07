return {
	"tpope/vim-surround",
	-- {
	-- 	"VonHeikemen/lsp-zero.nvim",
	-- 	branch = "v2.x",
	-- },
	-- Visual enhancements and themes
	"xiyaowong/transparent.nvim",
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
			},
		},
	}
}
