return {
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
  {
    "s1n7ax/nvim-window-picker",
    tag = "v1.5",
    config = function()
      require("window-picker").setup()
    end,
    dependencies = {},
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
}
