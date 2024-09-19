local function add_type(start_line, end_line)
  vim.ui.input({ prompt = "Type: " }, function(input)
    if not input then
      return
    end
    input = input:gsub(" ", "")
    for i = start_line, end_line do
      local line = vim.fn.getline(i)
      line = line:gsub(" =", ": " .. input .. " =")
      vim.fn.setline(i, line)
    end
  end)
end

return {
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      local custom = {
        name = "custom",
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

      local python_func = {
        name = "python",
        filetypes = { "python" },
        generator = {
          fn = function(params)
            return {
              {
                title = "Add var type",
                action = function()
                  local _start = params.lsp_params.range.start
                  local _end = params.lsp_params.range["end"]
                  add_type(_start.line + 1, _end.line + 1)
                end,
              },
            }
          end,
        },
        method = nls.methods.CODE_ACTION,
      }
      return {
        sources = {
          python_func,
          custom,
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.gitsigns,
          nls.builtins.code_actions.refactoring,
        },
      }
    end,
  },
}
