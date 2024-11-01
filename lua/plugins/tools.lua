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
}
