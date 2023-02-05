-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Is terrible with nix and is redundant if treesitter grammar includes indent
-- vim.opt.smartindent = true

-- Line wrapping
vim.opt.wrap = false

-- Save undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Enable mouse mode
vim.o.mouse = "a"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- pwd is always the directory of the file
vim.o.autochdir = true

-- Consistent splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable break indent
vim.o.breakindent = true

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
