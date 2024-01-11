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
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    opts = {},
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
      }
    end,
  },
}
