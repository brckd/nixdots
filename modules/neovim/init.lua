local o = vim.opt

-- Loader optimizations
vim.loader.enable()

-- Keybinds
local map = vim.api.nvim_set_keymap
local opts = {silent = true, noremap = true}

map("n", "<C-f>", ":Telescope find_files <CR>", opts)

-- Indents
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2

-- System clipboard
o.relativenumber = true
o.number = true
