vim.pack.add({
	{ src = "https://github.com/AlexvZyl/nordic.nvim", name = "catppuccin" },
	{ src = "https://github.com/tadaa/vimade", name = "vimade" },
})

require("nordic").setup({
	transparent = {
		bg = true,
	},
})

require("vimade").setup({
	recipe = { "minimalist", { animate = true } },
	fadelevel = 0.8,
})
