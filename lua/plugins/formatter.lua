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
        python = { "isort", "black", "autoflake" },
        go = { "golines", "gofumpt", "goimports" },
        -- javascript = { { "eslint", stop_after_first = true } },
        -- vue = { { "eslint", stop_after_first = true } },
        javascript = { "eslint_d" },
        vue = { "eslint_d" },
        ts = { "eslint_d" },
        sql = { "sql_formatter" },
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
        prettier = {
          inherit = true,
          -- args = { "--single-quote", "--trailing-comma=es5", "--print-width=100" },
        },
      },
    },
  },
}
