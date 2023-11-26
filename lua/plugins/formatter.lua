return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" } })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black", "autoflake" },
        -- go = { "golines", "gofumpt" },
        -- Use a sub-list to run only the first available formatter
        -- javascript = { { "prettierd", "prettier" } },
      },
      formatters = {
        isort = {
          inherit = true,
          prepend_args = { "--profile", "black", "--line-length=80" },
        },
        black = {
          inherit = true,
          prepend_args = { "--fast" },
        },
        autoflake = {
          inherit = true,
          prepend_args = {
            "--recursive",
            "--in-place",
            "--remove-all-unused-imports",
            "--remove-unused-variables",
            "--expand-star-imports",
            "--exclude",
            "__init__.py",
            "--remove-duplicate-keys",
          },
        },
        golines = {
          inherit = true,
          prepend_args = {
            "--base-formatter=gofumpt",
            "--max-len=100",
          },
        },
      },
    },
  },
}
