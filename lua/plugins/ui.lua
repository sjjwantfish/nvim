return {
  {
    "folke/noice.nvim",
    opts = {

      messages = {
        enabled = true, -- enables the Noice messages UI
        view = "virtualtext", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      lsp = {
        signature = {
          enabled = false,
        },
        progress = {
          enabled = false,
        },
      },
      presets = {
        -- bottom_search = true, -- use a classic bottom cmdline for search
        -- command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
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
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    init = function()
      vim.cmd([[
        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
      ]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      sections = {
        lualine_z = {
          "encoding",
        },
      },
    },
  },
  {
    "luukvbaal/statuscol.nvim",
    lazy = false,
    enabled = false,
    config = function(_, opts)
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        -- configuration goes here, for example:
        relculright = false,
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          {
            sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
            click = "v:lua.ScSa",
          },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
          {
            sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
            click = "v:lua.ScSa",
          },
        },
      })
    end,
  },
  {
    "nyngwang/NeoZoom.lua",
    opts = {
      exclude_buftypes = { "terminal" },
      exclude_filetypes = { "lspinfo", "mason", "lazy", "NvimTree" },
      -- winopts = {
      --   offset = {
      --     -- NOTE: omit `top`/`left` to center the floating window vertically/horizontally.
      --     -- top = 0,
      --     -- left = 0.17,
      --     width = 150,
      --     height = 0.85,
      --   },
      --   -- NOTE: check :help nvim_open_win() for possible border values.
      --   border = "thicc", -- this is a preset, try it :)
      -- },
      presets = {
        {
          -- NOTE: regex pattern can be used here!
          filetypes = { "dapui_.*", "dap-repl" },
          winopts = {
            offset = { top = 0.02, left = 0.26, width = 0.74, height = 0.25 },
          },
        },
        {
          filetypes = { "markdown" },
          callbacks = {
            function()
              vim.wo.wrap = true
            end,
          },
        },
      },
    },
    keys = {
      { "<leader>wt", "<cmd>NeoZoomToggle<cr>", desc = "Find Plugin File" },
    },
  },
  { "kevinhwang91/nvim-bqf", opts = {
    preview = {
      winblend = 0,
    },
  } },
  {
    "xiyaowong/transparent.nvim",
    enabled = false,
    opts = {
      groups = { -- table: default groups
        "Normal",
        "NormalNC",
        "NormalFloat",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLineNr",
        "EndOfBuffer",
        -- "BqfPreviewFloat",
      },
      extra_groups = {}, -- table: additional groups that should be cleared
      exclude_groups = {}, -- table: groups you don't want to clear
    },
  },
}
