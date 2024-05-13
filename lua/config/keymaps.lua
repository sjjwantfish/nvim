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

-- keymap("n", "za", "zA", opts)
keymap("n", "gw", "*N", opts)

local function execute_and_print_cmd()
  -- local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  -- local lines = vim.fn.getline(start_pos[2], end_pos[2])
  -- local selected_text = table.concat(lines, "\n")

  local selected_text = vim.api.nvim_get_current_line()
  if selected_text ~= "" then
    local command = "zsh -i -c '" .. selected_text .. "'"
    vim.notify(command)
    local handle = io.popen(command)
    local command_output = handle:read("*a")
    handle:close()
    local contents = vim.split(command_output, "\n")
    if contents[#contents] == "" then
      table.remove(contents, #contents)
    end
    vim.fn.setpos(".", end_pos)

    -- vim.api.nvim_put({ "{>>>>>>>>>>>>>>>>>>>>>>>>>>" }, "l", true, false)
    vim.fn.setreg("+", contents)
    vim.api.nvim_put(contents, "l", true, false)
    -- vim.api.nvim_put({"}<<<<<<<<<<<<<<<<<<<<<<<"}, 'l', true , false)
  else
    vim.notify("no text selected")
  end
end

vim.api.nvim_create_user_command("RunCommand", function()
  execute_and_print_cmd()
end, { nargs = "?", complete = "dir" })

vim.api.nvim_create_user_command("SplitLine", function(s)
  local position = vim.fn.getpos(".")

  local line = vim.api.nvim_get_current_line()
  local lines = vim.fn.split(line, s.args)

  if #lines > 0 then
    vim.api.nvim_set_current_line("")
  end

  vim.api.nvim_buf_set_lines(0, position[2] - 1, position[2] + #lines - 1, false, lines)
end, { nargs = "?", complete = "dir" })
