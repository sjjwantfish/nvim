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

local function add_type(start_line, end_line)
  vim.ui.input({ prompt = "Type: " }, function(input)
    if not input then
      return
    end
    for i = start_line, end_line do
      local line = vim.fn.getline(i)
      line = line:gsub(" =", ": " .. input .. " =")
      vim.fn.setline(i, line)
    end
  end)
end

vim.api.nvim_create_user_command("CustomPanel", function()
  local mode = vim.fn.mode()
  local ls = vim.fn.line(".")
  local le = ls
  if mode == "v" or mode == "V" then
    local cs
    local ce
    _, ls, cs = unpack(vim.fn.getpos("v"))
    _, le, ce = unpack(vim.fn.getpos("."))

    if ls > le or (ls == le and cs > ce) then
      ls, cs, le, ce = le, ce, ls, cs
    end
  end
  vim.ui.select({
    {
      label = "Add var type",
      idx = 1,
    },
  }, {
    prompt = "CustomPanel Func",
    format_item = function(item)
      return item.label
    end,
  }, function(item)
    if not item then
      return
    end
    if item.idx == 1 then
      add_type(ls, le)
    end
  end)
end, { nargs = "?", complete = "dir" })
keymap("n", "<leader>vp", "<cmd>CustomPanel<cr>", opts)
keymap("v", "<leader>vp", "<cmd>CustomPanel<cr>", opts)

vim.api.nvim_create_user_command("TSQuery", function(s)
  if s.args == nil then
    return
  end
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local lang = vim.treesitter.language.get_lang(ft)
  local parser = vim.treesitter.get_parser(bufnr, lang)
  local tree = parser:parse()[1]
  local query = vim.treesitter.query.parse(lang, s.args)
  for capture, node in query:iter_captures(tree:root(), bufnr) do
    -- local start_row, start_col, _, _ = node:range()
    -- if start_row > cursor_line or (start_row == cursor_line and start_col > cursor_col) then
    --   -- move_cursor(capture, node, offsets, query)
    --   -- return
    -- end
    print(capture)
    print(vim.inspect(node))
  end
end, { nargs = "?", complete = "dir" })

-- camelCase to snake_case
local function camelToSnake(str)
  return str
    :gsub("(%u)", function(c)
      return "_" .. c:lower()
    end)
    :gsub("^_", "")
end

vim.api.nvim_create_user_command("CamelToSnake", function()
  local visual_mode = vim.fn.mode() == "v" or vim.fn.mode() == "V"
  local word

  if not visual_mode then
    vim.cmd("normal viw")
  end

  local _, ls, cs = unpack(vim.fn.getpos("v"))
  local _, le, ce = unpack(vim.fn.getpos("."))

  if ls > le or (ls == le and cs > ce) then
    ls, cs, le, ce = le, ce, ls, cs
  end
  word = vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})[1]
  local converted = camelToSnake(word)
  vim.api.nvim_buf_set_text(0, ls - 1, cs - 1, le - 1, ce, { converted })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end, { nargs = "?", complete = "dir" })

vim.api.nvim_set_keymap("n", "<leader>vc", "<cmd>CamelToSnake<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>vc", "<cmd>CamelToSnake<CR>", { noremap = true, silent = true })
