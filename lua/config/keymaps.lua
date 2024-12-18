-- <leader> key
vim.g.mapleader = " "

-- open config
vim.cmd("nmap <leader>c :e ~/.config/nvim/init.lua<cr>")

-- save
vim.cmd("nmap <leader>s :w<cr>")

-- motion keys (left, down, up, right)
-- vim.keymap.set({ "n", "v" }, "j", "h")
-- vim.keymap.set({ "n", "v" }, "k", "j")
-- vim.keymap.set({ "n", "v" }, "l", "k")
-- vim.keymap.set({ "n", "v" }, ";", "l")

-- repeat previous f, t, F or T movement
vim.keymap.set("n", "'", ";")

-- paste without overwriting
vim.keymap.set("v", "p", "P")

-- redo
vim.keymap.set("n", "U", "<C-r>")

-- clear search highlighting
vim.keymap.set("n", "<Esc>", ":nohlsearch<cr>")

vim.keymap.set("n", "Q", ":qa!<cr>")

-- skip folds (down, up)
-- vim.cmd("nmap k gj")
-- vim.cmd("nmap l gk")

-- sync system clipboard
vim.opt.clipboard = "unnamedplus"

-- search ignoring case
vim.opt.ignorecase = true

-- disable "ignorecase" option if the search pattern contains upper case characters
vim.opt.smartcase = true
