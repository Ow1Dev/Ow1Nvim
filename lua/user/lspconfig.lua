local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
  },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua require('snacks').picker.lsp_declarations()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua require('snacks').picker.lsp_definitions()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua require('snacks').picker.lsp_implementations()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua require('snacks').picker.lsp_references()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
end

function M.config()
  local blink_cmp = require("blink.cmp")
  local default_capabilities = blink_cmp.get_lsp_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

  -- Configure and enable LSP servers
  for _, server in ipairs({ "lua_ls", "nixd" }) do
    vim.lsp.config[server] = {
      capabilities = default_capabilities,
      on_attach = M.on_attach,
      root_dir = vim.fs.root(0, { ".git" }),
    }
    vim.lsp.enable(server)
  end
end

return M
