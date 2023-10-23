-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- opt.scrolloff = 4
opt.relativenumber = false
opt.shiftwidth = 4
opt.foldenable = true
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.winbar = "%=%m %f"
opt.tabstop = 4 -- insert 2 spaces for a tab
opt.softtabstop = 4
opt.pumblend = 0
