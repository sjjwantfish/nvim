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
  {
    "kevinhwang91/nvim-bqf",
    opts = function()
      return {
        preview = {
          winblend = 0,
          win_height = math.floor(vim.api.nvim_win_get_height(0) * 0.6),
          wrap = true,
        },
      }
    end,
    init = function()
      vim.cmd("packadd cfilter")
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("QfCfilterMapping", { clear = true }),
        pattern = { "qf" },
        callback = function(_)
          -- support cfilter
          vim.keymap.set({ "n" }, "<c-/>", function()
            local qfwin = vim.api.nvim_get_current_win()
            vim.ui.input({ prompt = "Cfilter: " }, function(input)
              if string.sub(input, 1, 1) == "!" and #input > 1 then
                vim.cmd("Cfilter! " .. string.sub(input, 2))
              else
                vim.cmd("Cfilter " .. input)
              end
              vim.api.nvim_set_current_win(qfwin)
            end)
          end)
        end,
      })
    end,
  },
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
        groups = {
          options = {
            toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
          },
          items = {
            {
              name = "Tests", -- Mandatory
              highlight = { sp = "gray" }, -- Optional
              priority = 2, -- determines where it will appear relative to other groups (Optional)
              icon = "", -- Optional
              matcher = function(buf) -- Mandatory
                return buf.name:match("test_") or buf.name:match("_test")
              end,
            },
            {
              name = "Docs",
              highlight = { sp = "green" },
              auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
              matcher = function(buf)
                return buf.name:match("%.md") or buf.name:match("%.txt")
              end,
            },
            require("bufferline.groups").builtin.ungrouped,
          },
        },
      },
    },
    keys = {
      { "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    opts = {
      chunk = {
        notify = false,
        exclude_filetypes = { dbui = true, toml = true },
        chars = {
          horizontal_line = "━",
          vertical_line = "┃",
          left_top = "┏",
          left_bottom = "┗",
          -- right_arrow = ">",
          right_arrow = "",
        },
        style = {
          { fg = "#5395c6" },
        },
        max_file_size = 1024 * 1024,
        error_sign = true,
      },
      line_num = {
        enable = false,
      },
    },
  },
}
