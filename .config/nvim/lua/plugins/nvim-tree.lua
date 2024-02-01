return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	keys = {
		{
			"<leader>pv",
			function()
				require("nvim-tree.api").tree.toggle{file_path = true}
			end,
			desc = "Find Plugin File",
		}
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup ({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				adaptive_size = true,
				side = "left",
			},
			renderer = {
				group_empty = true,
				highlight_git = true,
				highlight_opened_files = "all",
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					}
				}
			},
			filters = {
				-- dotfiles = true,
				custom = { ".git" },
			},
		})
	end,
}
