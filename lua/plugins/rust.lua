local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

-- 检查是否使用 Leptos
local function is_using_leptos()
  local cargo_toml_path = util.path.join(vim.loop.cwd(), "Cargo.toml")
  if vim.fn.filereadable(cargo_toml_path) == 1 then
    for line in io.lines(cargo_toml_path) do
      if line:match("leptos") then
        return true
      end
    end
  end
  return false
end

return {
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            -- Add clippy lints for Rust.
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            rustfmt = is_using_leptos() and {
              overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
            } or nil,

            -- format rust代码的时候需要注释掉下面的代码，使用leptos的时候打开
            -- rustfmt = {
            -- overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
            -- },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  },
}
