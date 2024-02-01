return {
	'prettier/vim-prettier',
	build = 'yarn install --frozen-lockfile --production',
	config = function ()
		vim.g['prettier#autoformat'] = 1
		vim.g['prettier#autoformat_require_pragma'] = 0

		vim.g['prettier#quickfix_enabled'] = 0

		vim.cmd [[ autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.json,*.md PrettierAsync ]]

		vim.g['prettier#config#print_width'] = 70

		vim.g['prettier#config#tab_width'] = 2

		vim.g['prettier#config#use_tabs'] = true
	end
}
