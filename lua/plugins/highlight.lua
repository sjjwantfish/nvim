return {
  {
    "Mr-LLLLL/interestingwords.nvim",
    opts = {
      colors = { "#aeee00", "#ff0000", "#0000ff", "#b88823", "#ffa724", "#ff2c4b" },
      search_count = true,
      navigation = true,
      search_key = "<leader>hs",
      cancel_search_key = "<leader>hcs",
      color_key = "<leader>hw",
      cancel_color_key = "<leader>hcw",
    },
  },
  { "romainl/vim-cool" },
  {
    "norcalli/nvim-colorizer.lua",
    opts = {
      "*",
    },
  },
  {
    "mawkler/modicator.nvim",
    init = function()
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    opts = {
      highlights = {
        defaults = {
          bold = true,
          italic = true,
        },
      },
    },
  },
}
