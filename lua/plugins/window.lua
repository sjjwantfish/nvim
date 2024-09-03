return {
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
