return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        transparent = true,
        modules = {
          cmp = false,
        },
      },
      groups = {
        all = {
          -- NormalFloat = { bg = "NONE" },
          NormalFloat = { fg = "fg1", bg = "NONE" },
        },
      },
    },
  },
  {
    "marko-cerovac/material.nvim",
    opts = {
      disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = true, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false, -- Hide the end-of-buffer lines
      },
    },
  },
  {
    "shaunsingh/nord.nvim",
    config = function()
      vim.g.nord_disable_background = true
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
        },
      })
      -- vim.cmd("colorscheme github_dark_tritanopia")
    end,
  },
  { "Everblush/nvim", name = "everblush", opts = {
    transparent_background = false,
  } },
  {
    "olimorris/onedarkpro.nvim",
    opts = {
      options = {
        cursorline = true, -- Use cursorline highlighting?
        transparency = true, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      styles = {
        transparency = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "nightfox",
      -- colorscheme = "tokyonight",
      -- colorscheme = "tokyonight-storm",
      -- colorscheme = "material-oceanic",
      -- colorscheme = "material-deep-ocean",
      -- colorscheme = "material-darker",
      -- colorscheme = "nord",
      -- colorscheme = "github_dark",
      -- colorscheme = "github_dark_colorblind",
      -- colorscheme = "github_dark_tritanopia",
      -- colorscheme = "everblush",
      -- colorscheme = "onedark",
      colorscheme = "rose-pine",
      -- colorscheme = "rose-pine-main",
      -- colorscheme = "rose-pine-moon",
      -- colorscheme = "rose-pine-dawn",
    },
  },
}
