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
      timeout = vim.o.timeoutlen,
      default_mappings = true,
      mappings = {
        i = {
          j = {
            k = "<Esc>",
            j = "<Esc>",
          },
        },
      }
    }
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
