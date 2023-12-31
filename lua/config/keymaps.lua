--local discipline = require("craftzdog.discipline")
--discipline.cowboy()

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  local modes = type(mode) == "string" and { mode } or mode

  ---@param m string
  modes = vim.tbl_filter(function(m)
    return not (keys.have and keys:have(lhs, m))
  end, modes)

  -- do not create the keymap if a lazy keys handler exists
  if #modes > 0 then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      ---@diagnostic disable-next-line: no-unknown
      opts.remap = nil
    end
    vim.keymap.set(modes, lhs, rhs, opts)
  end
end

-- 复用 opt 参数
local opt = { noremap = true, silent = true }

map({ "n", "v", "o" }, "H", "^", opt)
map({ "n", "v", "o" }, "L", "$", opt)

-- move Lines
map("n", "<S-DOWN>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<S-UP>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<S-DOWN>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<S-UP>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<S-DOWN>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<S-UP>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- search
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
-- map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
-- map("n", "<", "v<g")
-- map("n", ">", "v>g")

-- 取消 s 默认功能
map("n", "s", "", opt)

--windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- leader + hjkl  窗口之间跳转
map("n", "<leader>h", "<C-w>h", opt)
map("n", "<leader>j", "<C-w>j", opt)
map("n", "<leader>k", "<C-w>k", opt)
map("n", "<leader>l", "<C-w>l", opt)

-- bufferline 左右Tab切换
-- map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
-- map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)

-- 左右比例控制
--map("n", "<C-h>", ":vertical resize -2<CR>", opt)
--map("n", "<C-l>", ":vertical resize +2<CR>", opt)
map("n", "s,", ":vertical resize -20<CR>", opt)
map("n", "s.", ":vertical resize +20<CR>", opt)
-- 上下比例
map("n", "sj", ":resize +10<CR>", opt)
map("n", "sk", ":resize -10<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)
-- 上下滚动浏览
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)
-- 退出
-- map("n", "q", ":q<CR>", opt)
map("n", "qq", ":q!<CR>", opt)
map("n", "Q", ":qa!<CR>", opt)

-- diagnostic
map("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
map("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
map("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)

-- Terminal相关
map("n", "<leader>t", ":sp | terminal<CR>", opt)
map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)

-- 关闭
-- map("n", "<C-w>", ":Bdelete!<CR>", opt)
-- map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
-- map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
-- map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)

-- Trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opt)

-- Tagbar
map("n", "<leader>xb", "<cmd>TagbarToggle<cr>", opt)

-- Increment/decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Select all
map("n", "<C-a>", "gg<S-v>G", opt)

-- go to definition
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
map("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
map("n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)

-- golang quick keymap
map("n", "<leader>gaj", "<cmd>GoTagAdd json<CR>", { desc = "Golang Tag Add json" })
map("n", "<leader>gay", "<cmd>GoTagAdd yaml<CR>", { desc = "Golang Tag Add yaml" })
map("n", "<leader>gae", "<cmd>GoIfErr<CR>", { desc = "Golang Add errr snippet" })
map("n", "<leader>gat", "<cmd>GoTestAdd<CR>", { desc = "Golang Add one function test" })
map("n", "<leader>gas", "<cmd>GoTestsAll<CR>", { desc = "Golang Add all function tests" })

-- debug
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dr", "<cmd>DapContinue<CR>", { desc = "Run or continue the debugger" })
map("n", "<f7>", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
map("n", "<f8>", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
map("n", "<f9>", "<cmd>DapStepOut<CR>", { desc = "Step Out" })
map("n", "<f10>", "<cmd>DapContinue<CR>", { desc = "Step Continue" })
map("n", "<f11>", "<cmd>DapTerminate<CR>", { desc = "Debug Terminate" })
map("n", "<leader>gos", function()
  local widgets = require("dap.ui.widgets")
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = "Open debugger sidebar" })

-- debug go
map("n", "<leader>gdt", function()
  require("dap-go").debug_test()
end, { desc = "Debug go test" })
map("n", "<leader>gdl", function()
  require("dap-go").debug_last_test()
end, { desc = "Debug last go test" })

--自动更新crates
map("n", "<leader>ru", function()
  require("crates").upgrade_all_crates()
end, { desc = "Update crates" })
