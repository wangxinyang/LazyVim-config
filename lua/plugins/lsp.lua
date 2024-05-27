return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "gopls",
        "codelldb",
        -- "biome",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {},
        taplo = {
          keys = {
            {
              "K",
              function()
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = "Show Crate Documentation",
            },
          },
        },
        tailwindcss = {
          -- filetypes_include = { "rs" },
          filetypes = {
            "css",
            "scss",
            "sass",
            "postcss",
            "html",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "svelte",
            "vue",
            "rust",
          },
          init_options = {
            -- There you can set languages to be considered as different ones by tailwind lsp I guess same as includeLanguages in VSCod
            userLanguages = {
              rust = "html",
            },
          },
        },
      },
      inlay_hints = {
        enabled = true,
      },
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
    },
  },
}
