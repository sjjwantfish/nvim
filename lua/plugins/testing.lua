return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      -- "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          -- require("neotest-python")({
          --   dap = { justMyCode = false },
          --   args = { "--log-level", "DEBUG", "-vs" },
          --   runner = "pytest",
          -- }),
          require("neotest-go"),
        },
      })
    end,

    keys = {
      { "<leader>tR", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Test run(dap)" },
      { "<leader>tr", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test run" },
      { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand(' % '))<cr>", desc = "Test file" },
      { "<leader>tp", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Test toggle panel" },
      { "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Test toggle summary" },
    },
  },
}
