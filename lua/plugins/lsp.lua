return {
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua
        "stylua",
        "lua-language-server",
        -- shell
        "shellcheck",
        "shfmt",
        "bash-language-server",
        -- -- golang ==> go.nvim
        -- "gopls",
        -- python
        "pyright",
        "flake8",
        "isort",
        "black",
        "autoflake",
        "pylint",
        -- vue
        "vue-language-server",
        -- "eslint_d",
        "prettier",
        -- buf
        "buf-language-server",
        "buf",
      },
    },
  },
  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    keys = { { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Symbols Outline" } },
    opts = {
      backends = { "treesitter", "lsp", "markdown", "man", "vim", "vimdoc" },
      layout = {
        min_width = 10,
      },
      autojump = true,
      show_guides = true,
    },
  },
  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                -- reportOptionalMemberAccessL = "none"
                -- useLibraryCodeForTypes = false,
                autoSearchPaths = false,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = false,
              },
            },
          },
        },
        -- eslint = {
        --   codeAction = {
        --     -- disableRuleComment = {
        --     --   enable = true,
        --     --   location = "separateLine"
        --     -- },
        --     showDocumentation = {
        --       enable = true,
        --     },
        --   },
        --   -- workingDirectory = {
        --   --   mode = "location",
        --   -- },
        -- },
        -- vuels = {},
        volar = {
          -- settings = {
          --   vue = {
          --     updateImportsOnFileMove = { enabled = true },
          --     { server = { fullCompletionList = true, petiteVue = { supportHtmlFile = true } } },
          --   },
          -- },
        },
        -- gopls = {},
      },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", "<cmd>Lspsaga hover_doc<cr>" }
      keys[#keys + 1] = { "gh", "<cmd>Lspsaga finder<cr>" }
      keys[#keys + 1] = { "gd", "<cmd>Lspsaga goto_definition<cr>" }
      keys[#keys + 1] = { "<leader>ca", "<cmd>Lspsaga code_action<cr>" }
      keys[#keys + 1] = { "gj", "<cmd>Lspsaga outgoing_calls<cr>" }
      keys[#keys + 1] = { "gk", "<cmd>Lspsaga incoming_calls<cr>" }
      keys[#keys + 1] = { "<leader>cS", "<cmd>Lspsaga outline<cr>" }
      keys[#keys + 1] = { "<leader>cR", "<cmd>LspRestart<cr>" }
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    opts = {
      preview = {
        lines_above = 0,
        lines_below = 10,
      },
      scroll_preview = {
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
      },
      request_timeout = 2000,
      finder = {
        --percentage
        max_height = 0.5,
        force_max_height = false,
        keys = {
          jump_to = "p",
          edit = { "o", "<CR>" },
          vsplit = "s",
          split = "i",
          tabe = "t",
          tabnew = "r",
          quit = { "q", "<ESC>" },
          close_in_preview = "<ESC>",
        },
      },
      lightbulb = {
        enable = false,
      },
      outline = {
        -- win_position = "right",
        -- win_width = 30,
        -- auto_preview = true,
        -- detail = false,
        layout = "float",
        -- custom_sort = nil,
        keys = {
          jump = "<cr>",
          expand_collapse = "z",
          quit = "q",
        },
      },
      implement = {
        enable = true,
        sign = false,
      },
      code_action = {
        show_server_name = true,
        extend_gitsigns = true,
      },
    },
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    opts = {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "double",
      },
      noice = true,
      -- transparency = 1,
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local cmd_write_grp = vim.api.nvim_create_augroup("GoCmdWrite", {})
      local go_commands = {
        "GoStop",
        "GoAddTest",
        "GoRename",
        "GoAddTags",
        "GoRmTags",
        "GoImpl",
      }
      for _, cmd in ipairs(go_commands) do
        vim.api.nvim_create_autocmd("User", {
          pattern = cmd,
          command = ":w | :" .. cmd,
          group = cmd_write_grp,
        })
      end

      local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
        group = format_sync_grp,
      })

      require("go").setup({
        icons = { breakpoint = "B", currentpos = "->" },
        run_in_floaterm = true,
        luasnip = true,
        -- goimport = "goimport",
        gofmt = "gofumpt",
        lsp_gofumpt = true,
        diagnostic = {
          underline = false,
          virtual_text = { space = 0, prefix = "■" },
          signs = true,
          update_in_insert = false,
        },
        lsp_cfg = true,
        lsp_codelens = true,
        lsp_inlay_hints = {
          enable = true,
          only_current_line = false,
          only_current_line_autocmd = "CursorHold",
          show_variable_name = true,
          parameter_hints_prefix = "󰊕 ",
          show_parameter_hints = true,
          -- prefix for all the other hints (type, chaining)
          other_hints_prefix = "=> ",
          -- whether to align to the lenght of the longest line in the file
          max_len_align = false,
          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,
          -- whether to align to the extreme right or not
          right_align = false,
          -- The color of the hints
          highlight = "Comment",
        },
        lsp_keymaps = false,
        dap_debug = true,
        dap_debug_gui = true,
        textobjects = true,
        test_runner = "dlv",
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
}
