return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    opts = {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      filesystem = {
        filtered_items = {
          hide_hidden = false,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            ".gitignored",
            "config.yaml",
            "config.lua",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            --".DS_Store",
            -- "thumbs.db",
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
            "__pycache__",
            "*.pyc",
            ".pytest_cache",
          },
        },
      },
    },
  },
  {
    "s1n7ax/nvim-window-picker",
    tag = "v1.5",
    -- config = function()
    --   require("window-picker").setup()
    -- end,
    -- dependencies = {},
  },
  {
    "nvim-tree/nvim-tree.lua",
    event = { "BufEnter" },
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      local opts = {
        reload_on_bufenter = true,
        auto_reload_on_write = true,
        update_focused_file = { enable = true },
        hijack_directories = {
          enable = false,
        },
        view = {
          width = 40,
          relativenumber = true,
          number = true,
        },
        filters = {
          dotfiles = false,
          custom = {
            "__pycache__",
            ".pytest_cache",
          },
        },
        renderer = {
          indent_markers = { enable = true },
        },
        modified = { enable = true },
        diagnostics = { enable = true },
        live_filter = {
          prefix = "[FILTER]: ",
          always_show_folders = false,
        },
      }
      require("nvim-tree").setup(opts)
    end,
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTreeToggle" },
    },
  },
  {
    "stevearc/oil.nvim",
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    columns = {
      "icon",
      "permissions",
      "mtime",
    },
    opts = {
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          return false
        end,
      },
      use_default_keymaps = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["L"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["q"] = "actions.close",
        ["R"] = "actions.refresh",
        ["H"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
      },
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
      preview = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a single value or a list of mixed integer/float types.
        -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
        max_height = 0.9,
        -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
    },
    keys = {
      -- { "<leader>E", mode = { "n" }, '<cmd>lua require("oil").open_float()<cr>', desc = "Oil open" },
      { "<leader>E", mode = { "n" }, '<cmd>lua require("oil").open()<cr>', desc = "Oil open" },
    },
  },
}
