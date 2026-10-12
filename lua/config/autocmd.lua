local cursorline_group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = cursorline_group,
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave" }, {
	group = cursorline_group,
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
