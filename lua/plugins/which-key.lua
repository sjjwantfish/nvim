return {
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      -- leader
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
          o = { "<cmd>silent !git open<cr>", "Git open" },
        },
        s = {
          name = "Search",
          e = { "<cmd>Telescope encodings<cr>", "Search encodings" },
        },
        b = {
          name = "Buffer",
          H = {
            "<cmd>BufferLineMovePrev<cr>",
            "Move buffer to the left",
          },
          L = {
            "<cmd>BufferLineMoveNext<cr>",
            "Move buffer to the right",
          },
        },
        ["<TAB>"] = {
          name = "Tab",
          l = {
            "<cmd>tabnext<cr>",
            "Next Tab",
          },
          h = {
            "<cmd>tabprevious<cr>",
            "Previous Tab",
          },
        },
      }, { prefix = "<leader>" })
      -- prefix g
      wk.register({
        mode = { "v", "n" },
        p = {
          { "%", "Match pair" },
        },
      }, { prefix = "g" })
      -- motion
      wk.register({
        mode = { "n", "v" },
        ["<A-H>"] = {
          {
            function()
              vim.cmd("normal! 0")
              local char = vim.api.nvim_get_current_line():sub(1, 1)
              if char:match("%s") then
                vim.cmd("normal! w")
              end
            end,
            "Move to line head",
          },
        },
        ["<A-L>"] = { "$", "Move to line end" },
      }, {})
      wk.register({
        mode = { "i" },
        ["<A-H>"] = { "<esc>I", "Move to line head" },
        ["<A-L>"] = { "<esc>A", "Move to line end" },
      }, {})
    end,
  },
}
