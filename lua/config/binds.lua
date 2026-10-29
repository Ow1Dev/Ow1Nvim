function Keymap(mode, key, binding, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, key, binding, options)
end

-- Remove nonsense command
Keymap("n", "q:", ":")

Keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>") -- Diagnostics for Linter
Keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>") -- Diagnostics for Linter

Keymap("n", "<leader>e", "<cmd>:Explore<cr>")
Keymap("n", "<leader>h", "<cmd>nohlsearch<cr>")

-- Escape terminal with c-d
Keymap("t", "<C-D>", "<C-\\><C-n>")

-- Better rezise of buffer
Keymap("n", "<C-w>J", "<C-w>+")
Keymap("n", "<C-w>K", "<C-w>-")
Keymap("n", "<C-w>L", "<C-w>>")
Keymap("n", "<C-w>H", "<C-w><")
