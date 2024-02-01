return {
	"epwalsh/obsidian.nvim",
	version = "*",  -- recommended, use latest release instead of latest commit
	lazy = false,
	config = function ()
		require("obsidian").setup({
			dir = "~/vaults/work",

			detect_cwd = false,
			daily_notes = {
				folder = "home/daily",
				date_format = "%Y-%m-%d",
				alias_format = "%B %-d, %Y",
				template = 'daily.md'
			},

			completion = {
				nvim_cmp = true,
				min_chars = 2,
				new_notes_location = "notes_subdir",
				prepend_note_id = true
			},

			mappings = {
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
			},

			note_id_func = function(title)
				local suffix = ""
				if title ~= nil then
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return tostring(os.time()) .. "-" .. suffix
			end,

			disable_frontmatter = false,

			note_frontmatter_func = function(note)
				local out = { id = note.id, aliases = note.aliases, tags = note.tags }
				if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
					for k, v in pairs(note.metadata) do
						out[k] = v
					end
				end
				return out
			end,

			templates = {
				subdir = "meta/templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
				substitutions = {
					yesterday = function()
						return os.date("%Y-%m-%d", os.time() - 86400)
					end,
					today = function()
						return os.date("%Y-%m-%d", os.time())
					end,
					tomorow = function()
						return os.date("%Y-%m-%d", os.time() + 86400)
					end
				}
			},

			backlinks = {
				height = 10,
				wrap = true,
			},

			follow_url_func = function(url)
				vim.fn.jobstart({"xdg-open", url})  -- linux
			end,

			use_advanced_uri = false,
			open_app_foreground = false,
			finder = "telescope.nvim",
			sort_by = "modified",
			sort_reversed = true,
			open_notes_in = "current",
			syntax = {
				enable = true,  -- set to false to disable
				chars = {
					todo = "󰄱",  -- change to "☐" if you don't have a patched font
					done = "",  -- change to "✔" if you don't have a patched font
				}
			},
			yaml_parser = "native"
		})
	end
}

