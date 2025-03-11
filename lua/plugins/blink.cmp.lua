return {
  { import = "lazyvim.plugins.extras.ai.copilot" },
  -- {
  --   "giuxtaposition/blink-cmp-copilot",
  --   enabled = false,
  -- },
  {
    "saghen/blink.cmp",
    dependencies = { "xzbdmw/colorful-menu.nvim" },
    opts = {
      completion = {
        trigger = { show_on_keyword = true },
        menu = {
          border = "single",
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
        documentation = { window = { border = "single" } },
      },
      signature = { window = { border = "single" } },
      sources = {
        -- default = { "emoji" },
        providers = {
          -- copilot = {
          --   module = "blink-copilot",
          --   opts = {
          --     max_completions = 3,
          --     max_attempts = 4,
          --   },
          --   score_offset = 8,
          -- },
          lsp = {
            score_offset = 10,
          },
          dadbod = {
            score_offset = 10,
          },
        },
      },
      keymap = {
        preset = "default",
        ["<S-TAB>"] = { "snippet_backward", "select_prev", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_next({ auto_insert = true })
              -- return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },

        ["<C-j>"] = { "select_next" },
        ["<C-k>"] = { "select_prev" },
        ["<CR>"] = {
          -- function(cmp)
          --   if cmp.snippet_active() then
          --     return cmp.select_and_accept()
          --   end
          -- end,
          "accept",
          "fallback",
        },
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = "<TAB>", -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
