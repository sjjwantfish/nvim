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
      on_open = function(term)
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
        local env = get_activate_conda_env()
        if env then
          term:send("conda activate " .. env)
        end
      end,
      -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
      direction = "vertical",
      float_opts = {
        -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      },
    },
  },
}
