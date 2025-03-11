return {
  { "nvim-lua/plenary.nvim", lazy = false },
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
      timeout = vim.o.timeoutlen,
      default_mappings = true,
      mappings = {
        i = {
          j = {
            k = "<Esc>",
          },
        },
      },
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
            "terraform",
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
    "josephburgess/nvumi",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      virtual_text = "newline", -- or "inline"
      prefix = " 🚀 ", -- prefix shown before the output
      date_format = "iso", -- or: "uk", "us", "long"
      keys = {
        run = "<CR>", -- run/refresh calculations
        reset = "R", -- reset buffer
        yank = "<leader>y", -- yank output of current line
        yank_all = "<leader>Y", -- yank all outputs
      },
      -- see below for more on custom conversions/functions
      custom_conversions = {},
      custom_functions = {},
    },
  },
}
