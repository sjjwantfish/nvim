return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "q",
        -- visual_line = "Q",
        delete = "ds",
        change = "cs",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      padding = true,
      sticky = true,
      ignore = "^$",
      post_hook = nil,
    },
    keys = {
      {
        "<leader>m",
        mode = { "n" },
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        desc = "Comment Toggle line",
      },
      {
        "<leader>m",
        mode = { "v" },
        function()
          local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
          local api = require("Comment.api")
          vim.api.nvim_feedkeys(esc, "nx", false)
          api.toggle.linewise(vim.fn.visualmode())
        end,
        desc = "Comment Toggle line",
      },
    },
    init = function()
      local ft = require("Comment.ft")
      ft({ "mysql", "sql" }, { "--%s" })
      ft({ "Jenkinsfile", "groovy" }, { "//%s" })
    end,
  },
  {
    "chrisgrieser/nvim-puppeteer",
    -- required :TSInstall python javascript typescript
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = false, -- plugin lazy-loads itself. Can also load on filetypes.
  },
  {
    "nguyenvukhang/nvim-toggler",
    opts = {
      inverses = {
        ["-"] = "_",
      },
      -- removes the default <leader>i keymap
      remove_default_keybinds = true,
      -- removes the default set of inverses
      remove_default_inverses = false,
    },
    keys = {
      {
        "<leader>ii",
        mode = { "n", "v" },
        function()
          require("nvim-toggler").toggle()
        end,
        desc = "Inverses",
      },
    },
  },
  {
    "chrisgrieser/nvim-origami",
    dependencies = {
      "kevinhwang91/nvim-ufo",
    },
    -- enabled = false,
    event = "BufReadPost", -- later or on keypress would prevent saving folds
    opts = {
      keepFoldsAcrossSessions = package.loaded["ufo"] ~= nil,
      pauseFoldsOnSearch = false,
      setupFoldKeymaps = false,
    }, -- needed even when using default config
  },
  -- selection
  {
    "gcmt/wildfire.vim",
    keys = {
      { "<Enter>", mode = { "n", "v" }, "<Plug>(wildfire-fuel)", desc = "Select previous text object" },
      { "<S-Enter>", mode = { "n", "v" }, "<Plug>(wildfire-water)", desc = "Select previous text object" },
    },
  },
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_theme = "lightpurple1"
      vim.g.VM_highlight_matches = "underline"
      vim.g.VM_maps = {
        ["Undo"] = "u",
        ["Redo"] = "<C-r>",
        ["Add Cursor Down"] = "<C-S-j>",
        ["Add Cursor Up"] = "<C-S-k>",
        ["Select All"] = "<leader>va",
        ["Start Regex Search"] = "<leader>v/",
        ["Switch Mode"] = "<leader>v<Tab>",
        ["Add Cursor At Pos"] = "<leader>vi",
        -- ["I BS"] = "",
        -- ["Goto Next"] = "]v",
        -- ["Goto Prev"] = "[v",
        -- ["I CtrlB"] = "<M-b>",
        -- ["I CtrlF"] = "<M-f>",
        ["I Return"] = "<S-CR>",
        -- ["I Down Arrow"] = "",
        -- ["I Up Arrow"] = "",
      }
    end,
  },
}
