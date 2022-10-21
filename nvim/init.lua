local opt = vim.opt
local cmd = vim.cmd

-- General usability options
opt.syntax = "on"
cmd.filetype("plugin indent on")

opt.showmatch = true

opt.ignorecase = true
opt.smartcase = true

opt.clipboard = "unnamedplus"

opt.wildmode = { "longest", "full" }

opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.list = true
opt.listchars = { tab = "▸ ", lead = "·", trail = "·", extends = "»", precedes = "«" }

-- Auto commands
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Plugins
require("plugins")

-- Color scheme
opt.termguicolors = true
cmd.colorscheme("fairyfloss")

-- Custom keybindings
local silent = { silent = true, noremap = true }
local map = vim.api.nvim_set_keymap

-- Window movement
map("n", "<c-h>", "<c-w>h", silent)
map("n", "<c-j>", "<c-w>j", silent)
map("n", "<c-k>", "<c-w>k", silent)
map("n", "<c-l>", "<c-w>l", silent)

-- Custom commands
cmd.command("-nargs=* Tf terminal terraform <args>")
