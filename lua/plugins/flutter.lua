local preview_stack_trace = function()
  local line = vim.api.nvim_get_current_line()
  local pattern = "package:[^/]+/([^:]+):(%d+):(%d+)"
  local filepath, line_nr, column_nr = string.match(line, pattern)
  filepath = "/lib/" .. filepath
  if filepath and line_nr and column_nr then
    vim.cmd(":wincmd k")
    vim.cmd("e " .. filepath)
    vim.api.nvim_win_set_cursor(0, { tonumber(line_nr), tonumber(column_nr) })
    vim.cmd(":wincmd j")
  end
end

return {
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    opts = {
      -- flutter_path = "/Users/tosei/workspace/flutter",
      fvm = true, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
      widget_guides = {
        enabled = true,
      },
      ui = {
        -- the border type to use for all floating windows, the same options/formats
        -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
        border = "rounded",
        -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
        -- please note that this option is eventually going to be deprecated and users will need to
        -- depend on plugins like `nvim-notify` instead.
        notification_style = "nvim-notify",
      },
      decorations = {
        statusline = {
          -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
          -- this will show the current version of the flutter app from the pubspec.yaml file
          app_version = true,
          -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
          -- this will show the currently running device if an application was started with a specific
          -- device
          device = true,
        },
      },
      outline = {
        open_cmd = "30vnew", -- command to use to open the outline buffer
        auto_open = false, -- if true this will open the outline automatically when it is first populated
      },
      debugger = {
        enabled = true,
        run_via_dap = false,
        exception_breakpoints = {
          {
            filter = "raised",
            label = "Exceptions",
            condition = "!(url:startsWith('package:flutter/') || url:startsWith('package:flutter_test/') || url:startsWith('package:dartpad_sample/') || url:startsWith('package:flutter_localizations/'))",
          },
        },
        register_configurations = function(_)
          local dap = require("dap")
          -- vim.notify(dap.configurations.dart)
          if not dap.configurations.dart then
            dap.adapters.dart = {
              type = "executable",
              command = "flutter",
              args = { "debug_adapter" },
            }
            dap.configurations.dart = {
              {
                -- flutter
                type = "dart",
                request = "launch",
                name = "Launch Flutter Program",
                -- The nvim-dap plugin populates this variable with the filename of the current buffer
                program = "lib/main.dart",
                -- program = "${file}",
                -- The nvim-dap plugin populates this variable with the editor's current working directory
                cwd = "${workspaceFolder}",
                -- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
                toolArgs = { "-d", "macos" },
              },
            }
          end
          require("dap.ext.vscode").load_launchjs()
        end,
      },
      dev_log = {
        enabled = true,
        notify_errors = true,
        open_cmd = "e", -- command to use to open the log buffer
        -- open_cmd = "tabedit", -- command to use to open the log buffer
      },
    },
    config = function(_, opts)
      vim.g.lsp_zero_extend_lspconfig = 0
      local lsp = require("lsp-zero").preset({})
      local dart_lsp = lsp.build_options("dartls", {})
      opts.lsp = {
        on_attach = function()
          vim.cmd("highlight! link FlutterWidgetGuides Comment")
        end,
        capabilities = dart_lsp.capabilities,
        color = { -- show the derived colours for dart variables
          enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
          background = false, -- highlight the background
          foreground = false, -- highlight the foreground
          virtual_text = true, -- show the highlight using virtual text
          virtual_text_str = "■", -- the virtual text character to highlight
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt", -- "always"
          enableSnippets = true,
          enableSdkFormatter = true,
          analysisExcludedFolders = {
            vim.fn.expand("$HOME/.pub-cache"),
            vim.fn.expand("$HOME/fvm"),
          },
          lineLength = 100,
        },
      }
      require("flutter-tools").setup(opts)
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "__FLUTTER_DEV_LOG__",
        callback = function()
          vim.keymap.set("n", "p", preview_stack_trace, { silent = true, noremap = true, buffer = true })
        end,
      })
    end,
  },
}
