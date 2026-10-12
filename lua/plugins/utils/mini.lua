vim.pack.add({ { src = "https://github.com/echasnovski/mini.nvim", name = "mini" } })

require("mini.pairs").setup() -- Bracket pairs and stuff
require("mini.ai").setup() -- Around and In extension for visual mode
require("mini.trailspace").setup() -- Shows useless spaces
require("mini.surround").setup() -- Suround selections with characters

require("mini.move").setup({ -- move selection in visual mode
	mappings = {
		down = "J",
		up = "K",
	},
})

require("mini.icons").setup() -- Icon provider
MiniIcons.mock_nvim_web_devicons()

require("mini.pick").setup()
vim.keymap.set("n", "<C-p>", "<cmd>:Pick files<cr>")
vim.keymap.set("n", "fg", "<cmd>:Pick grep_live<cr>")
