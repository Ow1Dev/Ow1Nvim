function Keymap(mode, key, binding, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, key, binding, options)
end

Keymap("n", "q:", ":") -- remove nonsense command

Keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>") -- Diagnostics for Linter
Keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>") -- Diagnostics for Linter

Keymap('n', '<leader>e', '<cmd>:Explore<cr>')
Keymap('n', '<leader>h', '<cmd>nohlsearch<cr>')
