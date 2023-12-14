return {
  {
    "nyngwang/NeoZoom.lua",
    opts = {
      exclude_buftypes = { "terminal" },
      exclude_filetypes = { "lspinfo", "mason", "lazy", "NvimTree" },
      -- winopts = {
      --   offset = {
      --     -- NOTE: omit `top`/`left` to center the floating window vertically/horizontally.
      --     -- top = 0,
      --     -- left = 0.17,
      --     width = 150,
      --     height = 0.85,
      --   },
      --   -- NOTE: check :help nvim_open_win() for possible border values.
      --   border = "thicc", -- this is a preset, try it :)
      -- },
      presets = {
        {
          -- NOTE: regex pattern can be used here!
          filetypes = { "dapui_.*", "dap-repl" },
          winopts = {
            offset = { top = 0.02, left = 0.26, width = 0.74, height = 0.25 },
          },
        },
        {
          filetypes = { "markdown" },
          callbacks = {
            function()
              vim.wo.wrap = true
            end,
          },
        },
      },
    },
    keys = {
      { "<leader>wt", "<cmd>NeoZoomToggle<cr>", desc = "NeoZoomToggle" },
    },
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    opts = {
      highlight = {
        -- bg  "#16161E",
        fg = "#8bd7fd",
      },
      interval = 30,
      no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest" },
      symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
    },
  },
}
