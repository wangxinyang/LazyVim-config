return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      -- 过滤不需要的message
      opts.routes = {
        {
          filter = { event = "notify", max_height = 3, max_length = 150 },
        },
        {
          filter = { event = "notify", find = "No information available" },
          opts = { skip = true },
        },
      }

      --TODO: 暂时保留
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }
      -- 合并消息，避免弹出很多的message窗口
      opts.views = {
        notify = {
          merge = true,
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.messages = {
        enable = false,
      }
      opts.presets.lsp_doc_border = true
      opts.presets.bottom_search = false
      opts.presets.long_message_to_split = true
      opts.presets.command_palette = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      title = "tosei",
      timeout = 1000,
      max_width = 100,
      render = "wrapped-compact",
      stages = "static",
      top_down = false,
      fps = 60,
    },
    --[[ config = function()
      local notify = require("notify")
      vim.notify = notify
      notify.setup({
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { border = "none" })
        end,
        background_colour = "#202020",
        fps = 60,
        level = 2,
        minimum_width = 50,
        render = "compact",
        stages = "fade_in_slide_out",
        timeout = 3000,
        top_down = true,
      })
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", ",;", function()
        require("telescope").extensions.notify.notify({
          layout_strategy = "vertical",
          layout_config = {
            width = 0.9,
            height = 0.9,
            -- preview_height = 0.1,
          },
          wrap_results = true,
          previewer = false,
        })
      end, opts)
      vim.keymap.set("n", "<LEADER>c;", notify.dismiss, opts)
    end, ]]
  },

  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "buffer",
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- globalstatus = false,
        theme = "solarized_dark",
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
████████╗ ██████╗ ███████╗███████╗██╗
╚══██╔══╝██╔═══██╗██╔════╝██╔════╝██║
   ██║   ██║   ██║███ ████╗█████╗  ██║
   ██║   ██║   ██║╚════██║██╔══╝  ██║
   ██║   ╚██████╔╝███████║███████╗██║
   ╚═╝    ╚═════╝ ╚══════╝╚══════╝╚═╝
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            -- '.git',
            -- '.DS_Store',
            -- 'thumbs.db',
          },
          never_show = {},
        },
      },
    },
  },
}
