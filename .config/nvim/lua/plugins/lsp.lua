return {
	-- tools
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, {
                "stylua",
                "selene",
                "luacheck",
                "shellcheck",
                "shfmt",
                "tailwindcss-language-server",
                "typescript-language-server",
                "css-lsp",
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
					-- See `:help vim.diagnostic.*` for documentation on any of the below functions
					vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
					vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
					vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
					vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

					-- Use LspAttach autocommand to only map the following keys
					-- after the language server attaches to the current buffer
					vim.api.nvim_create_autocmd('LspAttach', {
						group = vim.api.nvim_create_augroup('UserLspConfig', {}),
						callback = function(ev)
							-- Enable completion triggered by <c-x><c-o>
							vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

							-- Buffer local mappings.
							-- See `:help vim.lsp.*` for documentation on any of the below functions
							local opts = { buffer = ev.buf }
							vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
							vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
							vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
							vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
							vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
							vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
							vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
							vim.keymap.set('n', '<space>wl', function()
								print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
							end, opts)
							vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
							vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
							vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
							vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
							vim.keymap.set('n', '<space>f', function()
								vim.lsp.buf.format { async = true }
							end, opts)
						end,})
            local servers = {
				cssls = {},
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},
				tsserver = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					single_file_support = false,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				html = {},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},
				lua_ls = {
					-- enabled = false,
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
			}


            for server, config in pairs(servers) do
                lspconfig[server].setup(config)
            end
        end,
    },
}
