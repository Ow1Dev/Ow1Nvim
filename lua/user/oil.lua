M = {
  'stevearc/oil.nvim',
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  lazy = false,
}

function M.config()
  local wk = require("which-key")
  wk.add({
    { "-", "<CMD>Oil --float<CR>", desc = "Open file picker" },
  })
  require("oil").setup {
    float = {
      max_height = 20,
      max_width = 60,
      border = "rounded",
    },
  }
end

return M
