return {
	"epwalsh/obsidian.nvim",
	tag = "v3.6.1",
  requires = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
	config = function ()
		require("obsidian").setup({
			dir = "~/vaults/work",

			daily_notes = {
				folder = "home/daily",
				date_format = "%Y-%m-%d",
				alias_format = "%B %-d, %Y",
				template = 'daily.md'
			},

			completion = {
				nvim_cmp = true,
				min_chars = 2,
				prepend_note_id = true
			},

			new_notes_location = "notes_subdir",

			mappings = {
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				["<leader>ch"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
			},

			note_id_func = function(title)
				local suffix = ""
				if title ~= nil then
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					-- If title is nil, just add 4 random uppercase letters to the suffix.
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return tostring(os.time()) .. "-" .. suffix
			end,

			disable_frontmatter = false,

			  -- Optional, customize how wiki links are formatted.
				---@param opts {path: string, label: string, id: string|?}
				---@return string
				wiki_link_func = function(opts)
					if opts.id == nil then
						return string.format("[[%s]]", opts.label)
					elseif opts.label ~= opts.id then
						return string.format("[[%s|%s]]", opts.id, opts.label)
					else
						return string.format("[[%s]]", opts.id)
					end
				end,

				-- Optional, customize how markdown links are formatted.
				---@param opts {path: string, label: string, id: string|?}
				---@return string
				markdown_link_func = function(opts)
					return string.format("[%s](%s)", opts.label, opts.path)
				end,

				-- Either 'wiki' or 'markdown'.
				preferred_link_style = "wiki",

				-- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
				---@return string
				image_name_func = function()
					-- Prefix image names with timestamp.
					return string.format("%s-", os.time())
				end,

				  note_frontmatter_func = function(note)
    -- Add the title of the note as an alias.
    if note.title then
      note:add_alias(note.title)
    end

    local out = { id = note.id, aliases = note.aliases, tags = note.tags }

    -- `note.metadata` contains any manually added fields in the frontmatter.
    -- So here we just make sure those fields are kept in the frontmatter.
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
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

			follow_url_func = function(url)
				vim.fn.jobstart({"xdg-open", url})  -- linux
			end,

			use_advanced_uri = false,

  -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
  open_app_foreground = false,

  picker = {
    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
    name = "telescope.nvim",
    -- Optional, configure key mappings for the picker. These are the defaults.
    -- Not all pickers support all mappings.
    mappings = {
      -- Create a new note from your query.
      new = "<C-x>",
      -- Insert a link to the selected note.
      insert_link = "<C-l>",
    },
  },

  -- Optional, sort search results by "path", "modified", "accessed", or "created".
  -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
  -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
  sort_by = "modified",
  sort_reversed = true,

  -- Optional, determines how certain commands open notes. The valid options are:
  -- 1. "current" (the default) - to always open in the current window
  -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
  -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
  open_notes_in = "current",


			-- Optional, configure additional syntax highlighting / extmarks.
			-- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
			ui = {
				enable = true,  -- set to false to disable all additional syntax features
				update_debounce = 200,  -- update delay after a text change (in milliseconds)
				-- Define how various check-boxes are displayed
				checkboxes = {
					-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
					[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					["x"] = { char = "", hl_group = "ObsidianDone" },
					[">"] = { char = "", hl_group = "ObsidianRightArrow" },
					["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
					-- Replace the above with this if you don't have a patched font:
					-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
					-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

					-- You can also add more custom ones...
				},
				-- Use bullet marks for non-checkbox lists.
				bullets = { char = "•", hl_group = "ObsidianBullet" },
				external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				-- Replace the above with this if you don't have a patched font:
				-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				reference_text = { hl_group = "ObsidianRefText" },
				highlight_text = { hl_group = "ObsidianHighlightText" },
				tags = { hl_group = "ObsidianTag" },
				hl_groups = {
					-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
					ObsidianTodo = { bold = true, fg = "#f78c6c" },
					ObsidianDone = { bold = true, fg = "#89ddff" },
					ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
					ObsidianTilde = { bold = true, fg = "#ff5370" },
					ObsidianBullet = { bold = true, fg = "#89ddff" },
					ObsidianRefText = { underline = true, fg = "#c792ea" },
					ObsidianExtLinkIcon = { fg = "#c792ea" },
					ObsidianTag = { italic = true, fg = "#89ddff" },
					ObsidianHighlightText = { bg = "#75662e" },
				},
			},

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

