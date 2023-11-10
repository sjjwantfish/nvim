local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end
local actions = require("telescope.actions")

local function get_visual()
  local _, ls, cs = unpack(vim.fn.getpos("v"))
  local _, le, ce = unpack(vim.fn.getpos("."))

  if ls > le or (ls == le and cs > ce) then
    ls, cs, le, ce = le, ce, ls, cs
  end
  return vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
end

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "paopaol/telescope-git-diffs.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "crispgm/telescope-heading.nvim",
      "LinArcX/telescope-env.nvim",
      "ThePrimeagen/harpoon",
      "sjjwantfish/encodings.nvim",
    },
    config = function(_, opts)
      local lga_actions = require("telescope-live-grep-args.actions")
      opts.extensions = {
        undo = {},
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              -- ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
            },
          },
          vimgrep_arguments = {
            "rg",
            "--hidden",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "-g",
            "!.git",
            "-g",
            "!devTools",
            "-g",
            "!vendor",
            "-g",
            "!node_modules",
          },
        },
        heading = { treesitter = true },
      }

      if vim.api.nvim_win_get_width(0) > 120 then
        opts.defaults.layout_strategy = "horizontal"
      else
        vim.notify("telescope layout strategy has been changed to vertical", "info", { title = "nvim-telescope" })
        opts.defaults.layout_strategy = "vertical"
      end

      telescope.setup(opts)
      telescope.load_extension("vim_bookmarks")
      telescope.load_extension("undo")
      telescope.load_extension("git_diffs")
      telescope.load_extension("emoji")
      telescope.load_extension("heading")
      telescope.load_extension("env")
      telescope.load_extension("harpoon")
      telescope.load_extension("encodings")
      -- telescope.load_extension("aerial")
      require("telescope-all-recent").setup({
        default = {
          sorting = "frecency",
        },
      })
    end,
    keys = {
      {
        "gs",
        mode = { "v", "x", "n" },
        function()
          local mode = vim.api.nvim_get_mode().mode
          if mode == "n" then
            local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
            live_grep_args_shortcuts.grep_word_under_cursor()
          else
            local live_grep_args = require("telescope").extensions.live_grep_args
            local visual_text = get_visual()
            live_grep_args.live_grep_args({ default_text = visual_text[1] })
          end
        end,
        desc = "Live Grep with word",
      },
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      {
        "<leader>sf",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Current buffer fuzzy find",
      },
      {
        "<leader>su",
        "<cmd>Telescope undo<cr>",
        desc = "Undo tree",
      },
      {
        "<leader>sm",
        "<cmd>Telescope vim_bookmarks<cr>",
        desc = "Bookmarks",
      },
      {
        "<leader><leader>",
        "<cmd>Telescope find_files<cr>",
        desc = "Find Files",
      },
      { "<leader>ca", false },
      { "<leader>/", false },
      -- { "<leader>p", "<cmd>Telescope live_grep<cr>", desc = "Find in files(Grep)" },
      {
        "<leader>p",
        ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        desc = "Live Grep with args",
      },
      { "<leader>gB", ":Telescope git_branches<CR>", desc = "Checkout branch" },
    },
    opts = {
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "-g", "!.git", "-g", "!devTools", "-g", "!vendor" },
        },
        live_grep = {
          vimgrep_arguments = {
            "rg",
            "--hidden",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "-g",
            "!.git",
            "-g",
            "!devTools",
            "-g",
            "!vendor",
          },
        },
      },
      defaults = {
        -- selection_strategy = "follow",
        layout_strategy = "horizontal",
        cache_picker = {
          num_pickers = 5,
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<S-Down>"] = function(...)
              return actions.cycle_history_next(...)
            end,
            ["<S-Up>"] = function(...)
              return actions.cycle_history_prev(...)
            end,
            ["<C-Down>"] = function(...)
              return actions.cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return actions.cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return actions.preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return actions.preview_scrolling_up(...)
            end,
            ["<ESC>"] = function(...)
              return actions.close(...)
            end,
          },
          n = {
            -- ["q"] = function(...)
            --   return require("telescope.actions").close(...)
            -- end,
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
          },
        },
      },
    },
  },

  {
    "axkirillov/easypick.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      local easypick = require("easypick")
      local function joinList(list, separator)
        local result = ""
        local len = #list
        for i, item in ipairs(list) do
          result = result .. item
          if i < len then
            result = result .. separator
          end
        end
        return result
      end

      easypick.setup({
        pickers = {
          {
            name = "filehistory",
            command = "cat << EOF\n" .. joinList({
              "DiffviewFileHistory %",
              "DiffviewFileHistory",
            }, "\n") .. "\nEOF",
            action = easypick.actions.nvim_command(),
            opts = require("telescope.themes").get_dropdown({}),
          },
        },
      })
    end,
    keys = {
      {
        "<leader>dd",
        mode = { "n" },
        "<cmd>Easypick filehistory<cr>",
        desc = "Diffview file history pick",
      },
    },
  },
  { "prochri/telescope-all-recent.nvim", dependencies = { "nvim-telescope/telescope.nvim", "kkharji/sqlite.lua" } },
}
