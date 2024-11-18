-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- opt.scrolloff = 4
opt.relativenumber = true
opt.shiftwidth = 4
opt.foldenable = true
opt.foldmethod = "indent"
opt.foldlevel = 99
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldenable = false
opt.winbar = "%=%m %f"
opt.tabstop = 4 -- insert 2 spaces for a tab
opt.softtabstop = 4
opt.pumblend = 0
