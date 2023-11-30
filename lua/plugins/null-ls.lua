return {
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = false,
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      local print = {
        name = "print",
        filetypes = {},
        generator = {
          fn = function(params)
            return {
              {
                title = "print_selected",
                action = function()
                  vim.cmd("vsp print_params")
                  vim.api.nvim_paste(vim.inspect(params), true, -1)
                  -- print selected text in visual mode
                  if params.lsp_params then
                    if params.lsp_params.range then
                      local _start = params.lsp_params.range.start
                      local _end = params.lsp_params.range["end"]
                      local text = vim.api.nvim_buf_get_text(
                        params.bufnr,
                        _start.line,
                        _start.character,
                        _end.line,
                        _end.character,
                        {}
                      )
                      vim.cmd("vsp selected_text")
                      for _, line in ipairs(text) do
                        vim.api.nvim_paste(line, true, -1)
                      end
                    end
                  end
                end,
              },
            }
          end,
        },
        method = nls.methods.CODE_ACTION,
      }

      return {
        sources = {
          print,
          -- -- lua
          -- nls.builtins.formatting.stylua,
          -- -- python
          -- -- nls.builtins.diagnostics.flake8,
          -- nls.builtins.diagnostics.pylint.with({
          --   diagnostics_postprocess = function(diagnostic)
          --     diagnostic.code = diagnostic.message_id
          --   end,
          --   extra_args = {
          --     "-d=C0112,C0114,C0115,C0116,W0621,E0401,C0103",
          --     "--max-line-length=80",
          --   },
          -- }),
          -- nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
          -- nls.builtins.formatting.isort.with({ extra_args = { "--profile", "black", "--line-length=80" } }),
          -- nls.builtins.formatting.autoflake.with({
          --   extra_args = {
          --     "--recursive",
          --     "--in-place",
          --     "--remove-all-unused-imports",
          --     "--remove-unused-variables",
          --     "--expand-star-imports",
          --     "--exclude",
          --     "__init__.py",
          --     "--remove-duplicate-keys",
          --   },
          -- }),
          -- -- javascript javascriptreact typescript typescriptreact vue
          -- -- nls.builtins.formatting.eslint_d,
          -- -- nls.builtins.formatting.prettier,
          -- -- nls.builtins.diagnostics.eslint_d,
          -- nls.builtins.code_actions.gitsigns,
          -- nls.builtins.code_actions.refactoring,
          -- -- golang
          -- nls.builtins.code_actions.gomodifytags,
          -- -- nls.builtins.diagnostics.codespell,
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.gitsigns,
          nls.builtins.code_actions.refactoring,
        },
      }
    end,
  },
}
