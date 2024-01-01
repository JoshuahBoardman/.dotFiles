local opts = { noremap = true, }

local keymap = vim.api.nvim_set_keymap

-- remap leader key 
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal Mappings --

-- window nav remaps
 keymap("n", "<C-h>", "<C-w>h", opts)
 keymap("n", "<C-j>", "<C-w>j", opts)
 keymap("n", "<C-k>", "<C-w>k", opts)
 keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>e", ":Lex <cr>", opts)

-- Insert Mappings --

keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Copy To Clipboard -- 
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
