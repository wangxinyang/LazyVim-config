return {
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

  {
    event = "VeryLazy",
    "Exafunction/codeium.vim",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<C-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<C-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<C-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
  },
}
