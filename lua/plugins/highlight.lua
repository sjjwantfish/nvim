return {
  {
    "Mr-LLLLL/interestingwords.nvim",
    opts = {
      colors = { "#aeee00", "#ff0000", "#0000ff", "#b88823", "#ffa724", "#ff2c4b" },
      search_count = true,
      navigation = true,
      search_key = "<leader>h",
      cancel_search_key = "<leader>H",
      color_key = "<a-h>",
      cancel_color_key = "<a-H>",
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
