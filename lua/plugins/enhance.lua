return {
  {
    enabled = false,
    "folke/flash.nvim",
  },

  {
    event = "VeryLazy",
    "numToStr/Comment.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      toggler = {
        ---Line-comment toggle keymap
        line = "lc",
        ---Block-comment toggle keymap
        block = "gbc",
      },
    },
  },
  -- Incremental rename
  -- <leader>cr rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
}
