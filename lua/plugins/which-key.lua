return {
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      wk.register({
        w = {
          name = "windows",
          h = { "<cmd>wincmd H<cr>", "Move window to left" },
          j = { "<cmd>wincmd J<cr>", "Move window to bottom" },
          k = { "<cmd>wincmd K<cr>", "Move window to top" },
          l = { "<cmd>wincmd L<cr>", "Move window to right" },
        },
        g = {
          name = "git",
          o = { "<cmd>!git open<cr><cr>", "Git open" },
        },
        s = {
          name = "Search",
          e = { "<cmd>Telescope encodings<cr>", "Search encodings" },
        },
      }, { prefix = "<leader>" })
    end,
  },
}
