local M = {
  "folke/snacks.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  priority = 1000,
  lazy = false,
  opts = {
      explorer = { enabled = true },
      picker = { enabled = true },
  },
}

function M.config()
  local snacks = require("snacks")
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  keymap("n", "<C-p>", snacks.picker.files, opts)
  keymap("n", "<leader>e", snacks.explorer.open, opts)
end

return M
