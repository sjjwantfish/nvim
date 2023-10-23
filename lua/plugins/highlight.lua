return {
  {
    "lfv89/vim-interestingwords",
    init = function()
      vim.g.interestingWordsDefaultMappings = 0
      vim.g.interestingWordsRandomiseColors = 1
      vim.api.nvim_set_keymap("v", "<a-h>", "<cmd>call InterestingWords('v')<cr>", { noremap = true, silent = true })
    end,
    keys = {
      { "<a-h>", "<cmd>call InterestingWords('n')<cr>", desc = "InterestingWords" },
      { "<a-H>", "<cmd>call UncolorAllWords()<cr>", desc = "UncolorAllWords" },
      { "<a-n>", "<cmd>call WordNavigation(1)<cr>", desc = "Next InterestingWords" },
      { "<a-N>", "<cmd>call WordNavigation(0)<cr>", desc = "Prev InterestingWords" },
    },
  },

  { "romainl/vim-cool" },
  { "ap/vim-css-color" },
}
