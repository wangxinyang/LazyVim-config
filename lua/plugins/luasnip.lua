return {
  {
    "L3MON4D3/LuaSnip",
    commit = "79f647218847b1cd204fede7dd89025e43fd00c3",
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets/friendly-snippets" } })
    end,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
  },
}
