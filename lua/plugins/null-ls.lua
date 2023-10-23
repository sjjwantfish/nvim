return {
  {
    -- "jose-elias-alvarez/null-ls.nvim",
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = false,
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          -- lua
          nls.builtins.formatting.stylua,
          -- python
          -- nls.builtins.diagnostics.flake8,
          nls.builtins.diagnostics.pylint.with({
            diagnostics_postprocess = function(diagnostic)
              diagnostic.code = diagnostic.message_id
            end,
            extra_args = {
              "-d=C0112,C0114,C0115,C0116,W0621,E0401,C0103",
              "--max-line-length=80",
            },
          }),
          nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
          nls.builtins.formatting.isort.with({ extra_args = { "--profile", "black", "--line-length=80" } }),
          nls.builtins.formatting.autoflake.with({
            extra_args = {
              "--recursive",
              "--in-place",
              "--remove-all-unused-imports",
              "--remove-unused-variables",
              "--expand-star-imports",
              "--exclude",
              "__init__.py",
              "--remove-duplicate-keys",
            },
          }),
          -- javascript javascriptreact typescript typescriptreact vue
          -- nls.builtins.formatting.eslint_d,
          -- nls.builtins.formatting.prettier,
          -- nls.builtins.diagnostics.eslint_d,
          nls.builtins.code_actions.gitsigns,
          nls.builtins.code_actions.refactoring,
          -- golang
          nls.builtins.code_actions.gomodifytags,
          -- nls.builtins.diagnostics.codespell,
        },
      }
    end,
  },
}
