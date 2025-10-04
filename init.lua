local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load user configuration
require("user")

-- Setup lazy.nvim
require("lazy").setup({
  -- Add your plugins here
  -- Example:
  -- { "folke/tokyonight.nvim" },
}, {
  -- Lazy.nvim options
  checker = { enabled = false },
  change_detection = { enabled = false },
})

