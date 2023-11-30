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
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
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
    -- User interface is subject to change without notice.
    "monaqa/dial.nvim",
    init = function()
      vim.keymap.set("n", "<C-a>", function()
        require("dial.map").manipulate("increment", "normal")
      end)
      vim.keymap.set("n", "<C-x>", function()
        require("dial.map").manipulate("decrement", "normal")
      end)
      vim.keymap.set("n", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gnormal")
      end)
      vim.keymap.set("n", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gnormal")
      end)
      vim.keymap.set("v", "<C-a>", function()
        require("dial.map").manipulate("increment", "visual")
      end)
      vim.keymap.set("v", "<C-x>", function()
        require("dial.map").manipulate("decrement", "visual")
      end)
      vim.keymap.set("v", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gvisual")
      end)
      vim.keymap.set("v", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gvisual")
      end)
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
        "<leader>cc",
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
    -- enabled = false,
    event = "BufReadPost", -- later or on keypress would prevent saving folds
    opts = {
      keepFoldsAcrossSessions = true,
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
}
