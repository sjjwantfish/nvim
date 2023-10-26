local function config_dapui()
  local dap, dapui = require("dap"), require("dapui")
  local debug_open = function()
    dapui.open()
  end
  dap.listeners.after.event_initialized["dapui_config"] = function()
    debug_open()
  end
end

-- python
local function get_python_path()
  local output = io.popen("which python")
  if output ~= nil then
    local pp = output:read("*a")
    output:close()
    -- remove '\n'
    return string.sub(pp, 0, -2)
  end
  return os.getenv("HOME") .. "/miniconda3/bin/python"
end

return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      config_dapui()
    end,
    keys = {
      { "<leader>kk", "<cmd>DapToggleBreakpoint<cr>", desc = "Dap Toggle Breakpoint" },
      { "<leader>kc", "<cmd>DapContinue<cr>", desc = "DapContinue" },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local dap_python = require("dap-python")
      dap_python.test_runner = "pytest"
      dap_python.setup(get_python_path())
    end,
    keys = {
      { "<leader>tm", "<cmd>lua require('dap-python').test_method()<cr>", desc = "Dap test method(python)" },
      { "<leader>tc", "<cmd>lua require('dap-python').test_class()<cr>", desc = "Dap test class(python)" },
    },
  },
  {
    "leoluz/nvim-dap-go",
    opts = {
      dap_configurations = {
        {
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
      },
      delve = {
        path = "dlv",
        initialize_timeout_sec = 20,
        port = "${port}",
        args = {},
        build_flags = "",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    keys = {
      { "<leader>kt", "<cmd>lua require('dapui').toggle()<cr>", desc = "DapUI Toggle" },
    },
    opts = {
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = "scopes", size = 0.35 },
            { id = "stacks", size = 0.35 },
            { id = "watches", size = 0.15 },
            { id = "breakpoints", size = 0.15 },
          },
          size = 40, -- 40 columns
          position = "right",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 10,
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      highlight_new_as_changed = true,
    },
  },
}
