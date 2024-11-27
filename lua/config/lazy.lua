local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
if not vim.g.vscode then
  require("lazy").setup({
    spec = {
      -- add LazyVim and import its plugins
      { "LazyVim/LazyVim", import = "lazyvim.plugins" },
      -- `dashboard.nvim` is now the default LazyVim starter plugin.
      -- To keep using `alpha.nvim`, please enable the `lazyvim.plugins.extras.ui.alpha` extra.
      -- Or to hide this message, remove the alpha spec from your config.
      { import = "lazyvim.plugins.extras.ui.alpha" },
      -- import any extras modules here
      { import = "lazyvim.plugins.extras.coding.codeium" },
      { import = "lazyvim.plugins.extras.test.core" },
      { import = "lazyvim.plugins.extras.dap.core" },
      { import = "lazyvim.plugins.extras.lang.rust" },
      { import = "lazyvim.plugins.extras.lang.java" },
      { import = "lazyvim.plugins.extras.lang.json" },
      { import = "lazyvim.plugins.extras.lang.typescript" },
      { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
      { import = "lazyvim.plugins.extras.formatting.prettier" },
      { import = "lazyvim.plugins.extras.lang.go" },
      { import = "lazyvim.plugins.extras.linting.eslint" },
      { import = "lazyvim.plugins.extras.lang.typescript" },
      { import = "lazyvim.plugins.extras.lang.json" },
      { import = "lazyvim.plugins.extras.lang.tailwind" },
      { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
      -- import/override with your plugins
      { import = "plugins" },
    },
    defaults = {
      -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
      -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
      lazy = false,
      -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
      -- have outdated releases, which may break your Neovim install.
      version = false, -- always use the latest git commit
      -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = { enabled = false }, -- automatically check for plugin updates
    performance = {
      rtp = {
        -- disable some rtp plugins
        disabled_plugins = {
          "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  })
else
  require("config.options")
  require("config.keymaps")
  require("lazy").setup({
    -- Surround plugin
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end,
    },
    {
      "vscode-neovim/vscode-multi-cursor.nvim",
      event = "VeryLazy",
      cond = not not vim.g.vscode,
      opts = {},
    },
    {
      "vscode-neovim/vscode-multi-cursor.nvim",
      event = "VeryLazy",
      cond = not not vim.g.vscode,
      opts = {},
    },
  })
end
