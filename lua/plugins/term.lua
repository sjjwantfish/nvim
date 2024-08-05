local function get_activate_conda_env()
  local output = vim.fn.systemlist("conda info")
  for _, line in ipairs(output) do
    if string.find(line, "active environment", 1, true) then
      line = line:gsub("%s", "")
      local environment = line:gsub("%s", ""):match("activeenvironment:(%S+)")
      return environment
    end
  end
end

local function on_term_create(term)
  local env = get_activate_conda_env()
  if env and env ~= "base" then
    term:send("conda activate " .. env)
  end
end

local term

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      on_create = function(term)
        on_term_create(term)
      end,
      -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
      -- direction = "vertical",
      direction = "float",
      float_opts = {
        border = "curved",
      },
      winbar = {
        enabled = true,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end,
      },
    },
    keys = {
      {
        "<c-/>",
        mode = { "n", "i" },
        function()
          if not term then
            local Terminal = require("toggleterm.terminal").Terminal
            term = Terminal:new()
          end
          term:toggle()
        end,
        desc = "New Terminal",
      },
    },
  },
}
