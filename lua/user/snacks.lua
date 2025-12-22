local M = {
  "folke/snacks.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  priority = 1000,
  lazy = false,
  opts = {
    explorer = {
      enabled = true,
    },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          git_status = false,
          git_untracked = false,
        },
      },
    },
  },
}

function M.config()
  local wk = require("which-key")
  wk.add({
    { "<C-p>", "<cmd>lua require('snacks').picker.files()<cr>", desc = "Open file picker" },
    { "<leader>e", "<cmd>lua require('snacks').explorer.open()<cr>", desc = "Open explorer" },
  })
end

return M

