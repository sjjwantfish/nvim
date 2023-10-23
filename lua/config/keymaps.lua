-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("n", "W", "<cmd>w<cr>", opts)
keymap("n", "Q", "<cmd>q<cr>", opts)
keymap("n", "<c-q>", "<cmd>quitall<cr>", opts)
keymap("i", "<a-l>", "<esc>la", opts)
keymap("i", "<a-h>", "<esc>ha", opts)

vim.api.nvim_create_user_command("CheckDuplicates", function()
  local dups = require("which-key.keys").duplicates
  if vim.tbl_count(dups) > 0 then
    vim.cmd('echoerr "Duplicate mapping detected"')
  end
end, { nargs = "?", complete = "dir" })

vim.api.nvim_create_user_command("SwitchEncoding", function()
  vim.ui.select({
    "utf8",
    "gbk",
  }, {
    prompt = "FileEncoding",
  }, function(item)
    if item then
      local cmd = "e ++enc=" .. item
      -- local cmd = "set fileencoding=" .. item
      vim.cmd(cmd)
      vim.notify("Set file encoding = " .. item)
    end
  end)
end, { nargs = "?", complete = "dir" })
keymap("n", "<leader>ue", "<cmd>SwitchEncoding<cr>", opts)

-- keymap("n", "za", "zA", opts)
keymap("n", "gw", "*N", opts)

vim.api.nvim_create_user_command("MySelect", function()
  vim.ui.select({
    { "name1" },
    { "name2" },
    { "name3" },
  }, {
    prompt = "Authenticate Type",
    format_item = function(item)
      -- print(item[1])
      return item[1]
    end,
  }, function(item)
    if item then
      print(item[1])
      -- item.callback()
    end
  end)
end, { nargs = "?", complete = "dir" })

vim.api.nvim_create_user_command("MyPaste", function()
  local data = {
    "a",
    "b",
    "c",
  }
  for _, value in ipairs(data) do
    vim.api.nvim_paste(value .. "\n", true, -1)
  end
end, { nargs = "?", complete = "dir" })
