return {
  {
    "folke/noice.nvim",
    opts = {

      messages = {
        enabled = false, -- enables the Noice messages UI
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
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      sections = {
        lualine_z = {
          "encoding",
        },
        lualine_y = {
          {
            "filetype",
            colored = true,
            icon_only = false,
          },
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
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
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        buffer_close_icon = "",
        always_show_bufferline = true,
        truncate_names = false,
      },
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    opts = {
      chunk = {
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        style = {
          { fg = "#CB8764" },
        },
        -- chars = {
        --   horizontal_line = "─",
        --   vertical_line = "│",
        --   left_top = "╭",
        --   left_bottom = "╰",
        --   right_arrow = ">",
        -- },
        -- style = {
        --   { fg = "#806d9c" },
        --   { fg = "#c21f30" },
        -- },
        max_file_size = 1024 * 1024,
        error_sign = true,
      },
      line_num = {
        enable = false,
      },
      -- blank = {
      --   enable = false,
      -- },
      indent = {
        enable = false,
      },
    },
  },
}
