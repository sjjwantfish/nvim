return {
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      -- leader
      wk.add({
        { "<leader><TAB>", group = "Tab" },
        { "<leader><TAB>h", "<cmd>tabprevious<cr>", desc = "Previous Tab" },
        { "<leader><TAB>l", "<cmd>tabnext<cr>", desc = "Next Tab" },
        { "<leader>b", group = "Buffer" },
        { "<leader>bH", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer to the left" },
        { "<leader>bL", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer to the right" },
        { "<leader>g", group = "git" },
        { "<leader>go", "<cmd>silent !git open<cr>", desc = "Git open" },
        { "<leader>s", group = "Search" },
        { "<leader>se", "<cmd>Telescope encodings<cr>", desc = "Search encodings" },
        { "<leader>w", group = "windows" },
        { "<leader>wh", "<cmd>wincmd H<cr>", desc = "Move window to left" },
        { "<leader>wj", "<cmd>wincmd J<cr>", desc = "Move window to bottom" },
        { "<leader>wk", "<cmd>wincmd K<cr>", desc = "Move window to top" },
        { "<leader>wl", "<cmd>wincmd L<cr>", desc = "Move window to right" },
      })
      wk.add( {
          { "gp", "%", desc = "Match pair", mode = { "n", "v" } },
      })
      -- motion
      wk.add({
        { "<A-H>", function()
              vim.cmd("normal! 0")
              local char = vim.api.nvim_get_current_line():sub(1, 1)
              if char:match("%s") then
                vim.cmd("normal! w")
              end
            end, desc = "Move to line head", mode = { "n", "v" } },
        { "<A-L>", "$", desc = "Move to line end", mode = { "n", "v" } },
      })
      wk.add({
        { "<A-H>", "<esc>I", desc = "Move to line head", mode = { "i" } },
        { "<A-L>", "<esc>A", desc = "Move to line end", mode = { "i" } },
      })
    end,
  },
}
