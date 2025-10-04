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
  keymap(bufnr, "n", "gI", "<cmd>lua require('snacks').picker.lsp_implementations()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua require('snacks').picker.lsp_references()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

M.on_attach = function(_, bufnr)
  lsp_keymaps(bufnr)
end

function M.config()
  local wk = require "which-key"
  wk.add {
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    {
      "<leader>lf",
      "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      desc = "Format",
    },
    { "<leader>lh", "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>", desc = "Hints" },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
    { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
    { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
  }

  wk.add {
    { "<leader>la", group = "LSP" },
    { "<leader>laa", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", mode = "v" },
  }
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
