return {
  { "nvim-lua/plenary.nvim", lazy = false },
  { "LintaoAmons/scratch.nvim" },
  {
    "rafcamlet/nvim-luapad",
    opts = {
      error_indicator = false,
      eval_on_change = false,
    },
  },
  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jk" }, -- a table with mappings to use
      timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      clear_empty_lines = false, -- clear line after escaping if there is only whitespace
      keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
      -- example(recommended)
      -- keys = function()
      --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
      -- end,
    },
  },
  {
    "FotiadisM/tabset.nvim",
    opts = {
      defaults = {
        tabwidth = 4,
        expandtab = true,
      },
      languages = {
        {
          filetypes = {
            "vue",
            "css",
            "scss",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "sh",
            "lua",
            "sxhkd",
            "yuck",
            "yaml",
          },
          config = {
            tabwidth = 2,
          },
        },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  { "Ttibsi/pre-commit.nvim" },
  {
    "cshuaimin/ssr.nvim",
    opts = {
      border = "rounded",
      min_width = 50,
      min_height = 5,
      max_width = 120,
      max_height = 25,
      adjust_window = true,
      keymaps = {
        close = "q",
        next_match = "n",
        prev_match = "N",
        replace_confirm = "<cr>",
        replace_all = "<leader><cr>",
      },
    },
    keys = {
      { "<leader>sp", mode = { "n", "x" }, "<cmd>lua require('ssr').open()<cr>", desc = "Open ssr" },
    },
  },
}
