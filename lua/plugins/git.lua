return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

      -- stylua: ignore start
      map("n", "<leader>gj", gs.next_hunk, "Next Hunk")
      map("n", "<leader>gk", gs.prev_hunk, "Prev Hunk")
      -- map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      -- map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
      -- map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>gd", gs.diffthis, "Diff This")
      map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
      -- map("n", "<leader>gf", "<cmd>Telescope git_status<cr>", "Git status")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    -- requires = 'nvim-lua/plenary.nvim',
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>df", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffviewFileHistory" },
      { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
      { "<leader>dr", "<cmd>DiffviewRefresh<cr>", desc = "DiffviewRefresh" },
    },
    config = function()
      local opts = {
        view = {
          merge_tool = {
            layout = "diff3_vertical",
          },
        },
      }
      if vim.fn.winwidth(0) <= 120 then
        opts.view.file_history = { layout = "diff2_vertical" }
      end
      require("diffview").setup(opts)
    end,
  },
}
