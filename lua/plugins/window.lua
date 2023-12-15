return {
  {
    "nyngwang/NeoZoom.lua",
    opts = {
      exclude_buftypes = { "terminal" },
      exclude_filetypes = { "lspinfo", "mason", "lazy", "NvimTree" },
      -- winopts = {
      --   offset = {
      --     -- NOTE: omit `top`/`left` to center the floating window vertically/horizontally.
      --     -- top = 0,
      --     -- left = 0.17,
      --     width = 150,
      --     height = 0.85,
      --   },
      --   -- NOTE: check :help nvim_open_win() for possible border values.
      --   border = "thicc", -- this is a preset, try it :)
      -- },
      presets = {
        {
          -- NOTE: regex pattern can be used here!
          filetypes = { "dapui_.*", "dap-repl" },
          winopts = {
            offset = { top = 0.02, left = 0.26, width = 0.74, height = 0.25 },
          },
        },
        {
          filetypes = { "markdown" },
          callbacks = {
            function()
              vim.wo.wrap = true
            end,
          },
        },
      },
    },
    keys = {
      { "<leader>wt", "<cmd>NeoZoomToggle<cr>", desc = "NeoZoomToggle" },
    },
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    opts = {
      highlight = {
        -- bg  "#16161E",
        fg = "#8bd7fd",
      },
      interval = 30,
      no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest" },
      symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      cursor_follows_swapped_bufs = true,
      resize_mode = {
        quit_key = "<ESC>",
        silent = true,
        hooks = {
          on_enter = function()
            vim.notify("Entering resize mode")
          end,
          on_leave = function()
            vim.notify("Exiting resize mode, bye")
          end,
        },
      },
    },
    keys = {
      {
        "<leader>wrs",
        mode = { "n" },
        "<cmd>lua require('smart-splits').start_resize_mode()<cr>",
        desc = "Start resize mode",
      },
      -- moving between splits
      { "<C-h>", mode = { "n" }, "<cmd>lua require('smart-splits').move_cursor_left()<cr>" },
      { "<C-j>", mode = { "n" }, "<cmd>lua require('smart-splits').move_cursor_down()<cr>" },
      { "<C-k>", mode = { "n" }, "<cmd>lua require('smart-splits').move_cursor_up()<cr>" },
      { "<C-l>", mode = { "n" }, "<cmd>lua require('smart-splits').move_cursor_right()<cr>" },
      -- swapping buffers between windows
      {
        "<leader>wsh",
        mode = { "n" },
        "<cmd>lua require('smart-splits').swap_buf_left()<cr>",
        desc = "Swap buffer to left",
      },
      {
        "<leader>wsj",
        mode = { "n" },
        "<cmd>lua require('smart-splits').swap_buf_down()<cr>",
        desc = "Swap buffer to bottom",
      },
      {
        "<leader>wsk",
        mode = { "n" },
        "<cmd>lua require('smart-splits').swap_buf_up()<cr>",
        desc = "Swap buffer to top",
      },
      {
        "<leader>wsl",
        mode = { "n" },
        "<cmd>lua require('smart-splits').swap_buf_right()<cr>",
        desc = "Swap buffer to right",
      },
    },
  },
}
