local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "folke/neodev.nvim",
    "saghen/blink.cmp",
  },
}

function M.config()
  local blink_cmp = require("blink.cmp")
  local default_capabilities = blink_cmp.get_lsp_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

  -- Configure and enable LSP servers
  for _, server in ipairs({ "lua_ls" }) do
    vim.lsp.config[server] = {
      capabilities = default_capabilities,
      root_dir = vim.fs.root(0, { ".git" }),
    }
    vim.lsp.enable(server)
  end
end

return M
