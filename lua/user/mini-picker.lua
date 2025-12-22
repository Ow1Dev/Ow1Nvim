local M = {
  'nvim-mini/mini.pick',
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  version = false,
}

function M.config()
  local wk = require("which-key")
  wk.add({
    { "<C-p>", "<cmd>:Pick files<cr>", desc = "Open file picker" },
  })

  local mini = require("mini.pick")
  mini.setup()
end


return M
