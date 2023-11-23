return {
  -- database
  { "tpope/vim-dadbod" },
  {
    "kristijanhusak/vim-dadbod-ui",
    keys = {
      { "<leader>ub", "<cmd>DBUIToggle<cr>", desc = "DB UI" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_table_helpers = {
        mysql = {
          Structure = "SHOW CREATE TABLE {table};",
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
      vim.cmd([[
        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
      ]])
    end,
  },
}
