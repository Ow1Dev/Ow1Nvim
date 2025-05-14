local M = {
  "folke/snacks.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  priority = 1000,
  lazy = false,
  opts = {
      dim = { enabled = true },
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      zen = { enabled = true },
      -- notifier = { enabled = true, timeout = 3000, style = "compact" },
      notifier = { enabled = false },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      -- styles = {
      --   notification = {
      --     style = "compact"
      --   }
      -- }
    },
}

function M.config()
  local Snacks = require("snacks")
  local wk = require "which-key"
  wk.add {
    { "<C-p>", Snacks.picker.files, { desc = "Find Files" }},
    { "<C-e>", function() Snacks.picker.recent() end, desc = "Recent" },
  }

  wk.add {
    { "<leader>f", group = "Find" },
    { "<leader>fg", Snacks.picker.grep, desc = "Grep" },
    { "<leader>fb", Snacks.picker.buffers, desc = "Buffers" },
  }

  wk.add {
    { "<leader>s", group = "Search" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
  }

end

return M
