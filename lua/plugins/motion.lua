return {
  -- bookmarks
  { "MattesGroeger/vim-bookmarks" },
  { "tom-anders/telescope-vim-bookmarks.nvim" },
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    opts = { skipInsignificantPunctuation = false },
    init = function()
      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
      vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
    end,
  },
  {
    "cbochs/portal.nvim",
    opts = {
      window_options = {
        height = 7,
      },
      escape = {
        ["<esc>"] = true,
        ["q"] = true,
      },
    },
    init = function()
      vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
      vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
    end,
  },
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<leader>;;", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "harpoon quick menu" },
      { "<leader>;a", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "harpoon mark file" },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "<leader>n",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            search = { mode = "search", max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = "^",
          })
        end,
        desc = "Flash Jump To Line",
      },
      {
        "<leader>j",
        mode = { "n", "x", "o" },
        function()
          local Flash = require("flash")
          local function format(opts)
            return {
              { opts.match.label1, opts.hl_group },
              { opts.match.label2, "Search" },
            }
          end
          Flash.jump({
            search = { mode = "search" },
            label = {
              after = false,
              before = { 0, 0 },
              uppercase = false,
              format = format,
            },
            pattern = [[\<]],
            action = function(match, state)
              state:hide()
              Flash.jump({
                search = { max_length = 0 },
                highlight = { matches = false },
                label = { format = format },
                matcher = function(win)
                  return vim.tbl_filter(function(m)
                    return m.label == match.label and m.win == win
                  end, state.results)
                end,
                labeler = function(matches)
                  for _, m in ipairs(matches) do
                    m.label = m.label2
                  end
                end,
              })
            end,
            labeler = function(matches, state)
              local labels = state:labels()
              for m, match in ipairs(matches) do
                match.label = labels[math.floor((m - 1) / #labels) + 1]
                match.label1 = match.label
                match.label2 = labels[(m - 1) % #labels + 1]
              end
            end,
          })
        end,
        desc = "Flash Jump",
      },
    },
  },
  {
    "abecodes/tabout.nvim",
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
    end,
    dependencies = { "nvim-treesitter", "nvim-cmp" },
  },
}
