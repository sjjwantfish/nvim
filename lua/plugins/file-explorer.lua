return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- enabled = false,
    config = function()
      -- vim.api.nvim_set_hl(0, "MyNeoTreeTabInactive", { fg = "none" })
      -- vim.api.nvim_set_hl(0, "MyNeoTreeTabActive", { fg = "#7199f1" })

      -- vim.api.nvim_set_hl(0, "MyNeoTreeTabInactive", { fg = "none" })
      -- vim.api.nvim_set_hl(0, "MyNeoTreeTabSeparatorInactive", { fg = "none" })
      -- vim.api.nvim_set_hl(0, "MyNeoTreeTabSeparatorActive", { fg = "none" })

      local opts = {
        auto_clean_after_session_restore = true,
        close_if_last_window = true,
        sources = { "filesystem", "buffers", "git_status" },
        source_selector = {
          winbar = true,
          content_layout = "center",

          highlight_tab = "MyNeoTreeTabInactive",
          highlight_tab_active = "MyNeoTreeTabActive",
          highlight_background = "MyNeoTreeTabInactive",
          highlight_separator = "MyNeoTreeTabSeparatorInactive",
          highlight_separator_active = "MyNeoTreeTabSeparatorActive",
        },
        commands = {
          system_open = function(state)
            (vim.ui.open)(state.tree:get_node():get_id())
          end,
          parent_or_close = function(state)
            local node = state.tree:get_node()
            if (node.type == "directory" or node:has_children()) and node:is_expanded() then
              state.commands.toggle_node(state)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
          end,
          child_or_open = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" or node:has_children() then
              if not node:is_expanded() then -- if unexpanded, expand
                state.commands.toggle_node(state)
              else -- if expanded and has children, seleect the next child
                require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
              end
            else -- if not a directory just open it
              state.commands.open(state)
            end
          end,
          copy_selector = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local vals = {
              ["BASENAME"] = modify(filename, ":r"),
              ["EXTENSION"] = modify(filename, ":e"),
              ["FILENAME"] = filename,
              ["PATH (CWD)"] = modify(filepath, ":."),
              ["PATH (HOME)"] = modify(filepath, ":~"),
              ["PATH"] = filepath,
              ["URI"] = vim.uri_from_fname(filepath),
            }

            local options = vim.tbl_filter(function(val)
              return vals[val] ~= ""
            end, vim.tbl_keys(vals))
            if vim.tbl_isempty(options) then
              vim.notify("No values to copy", vim.log.levels.WARN)
              return
            end
            table.sort(options)
            vim.ui.select(options, {
              prompt = "Choose to copy to clipboard:",
              format_item = function(item)
                return ("%s: %s"):format(item, vals[item])
              end,
            }, function(choice)
              local result = vals[choice]
              if result then
                vim.notify(("Copied: `%s`"):format(result))
                vim.fn.setreg("+", result)
              end
            end)
          end,
          find_in_dir = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require("telescope.builtin").find_files({
              cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
            })
          end,
          live_grep_in_dir = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require("telescope").extensions.live_grep_args.live_grep_args({
              cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
            })
          end,
        },
        window = {
          auto_expand_width = true,
          width = 30,
          mappings = {
            ["<space>"] = false, -- disable space until we figure out which-key disabling
            ["<a-h>"] = "prev_source",
            ["<a-l>"] = "next_source",
            ["<leader>space"] = "find_in_dir",
            ["<leader>p"] = "live_grep_in_dir",
            O = "system_open",
            Y = "copy_selector",
            h = "parent_or_close",
            l = "child_or_open",
            o = "open",
            z = "none",
            ["/"] = "none",
          },
          fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
            ["<C-j>"] = "move_cursor_down",
            ["<C-k>"] = "move_cursor_up",
          },
        },
        filesystem = {
          find_by_full_path_words = true,
          follow_current_file = { enabled = true },
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
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
              "__pycache__",
              "*.pyc",
              ".pytest_cache",
            },
          },
        },
        event_handlers = {
          {
            event = "neo_tree_buffer_enter",
            handler = function(_)
              vim.opt_local.signcolumn = "auto"
            end,
          },
        },
      }
      require("neo-tree").setup(opts)
    end,
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
    enabled = false,
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
        ["<leader>s"] = "actions.select_vsplit",
        ["<leader>h"] = "actions.select_split",
        ["<leader>t"] = "actions.select_tab",
        ["<leader>p"] = "actions.preview",
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
