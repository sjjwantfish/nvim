return {
  -- database
  { "tpope/vim-dadbod" },
  {
    "kristijanhusak/vim-dadbod-ui",
    keys = {
      { "<leader>ub", "<cmd>DBUIToggle<cr>", desc = "DB UI" },
      { "<leader>r", mode = { "n", "v" }, "<Plug>(DBUI_ExecuteQuery)", desc = "DBUI Execute Query" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_table_helpers = {
        mysql = {
          Structure = "SHOW CREATE TABLE {table};",
          ListByUpdate = "SELECT * FROM {table} ORDER BY `update_time` DESC",
        },
      }
      vim.g.db_ui_win_position = "right"
      vim.g.db_ui_save_location = os.getenv("HOME") .. "/.config/nvim/db_ui"
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("dadbod-cmp", { clear = true }),
        pattern = {
          "sql",
          "mysql",
          "plsql",
        },
        callback = function(_)
          require("cmp").setup.buffer({
            sources = { { name = "vim-dadbod-completion" } },
            formatting = {
              fields = { "kind", "abbr", "menu" },
              format = function(entry, item)
                item.kind = ""
                item.menu = "[DB]"
                return item
              end,
            },
          })
        end,
      })
    end,
  },
}
