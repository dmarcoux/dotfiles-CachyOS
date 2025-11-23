-- Based on lazy.nvim documentation at https://lazy.folke.io/installation
--
-------------------- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-------------------- Load my Neovim configuration
require("config.options")
require("config.autocommands")
-- TODO require("config.autogroups")
-- TODO require("config.lsp")

-------------------- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- Configure any other settings here. For details, see https://lazy.folke.io/configuration
  install = {
    -- Install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- Colorscheme that will be used when installing plugins.
    colorscheme = { "habamax" },
  },
})
