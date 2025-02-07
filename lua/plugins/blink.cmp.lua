return {
  { import = "lazyvim.plugins.extras.ai.copilot" },
  {
    "giuxtaposition/blink-cmp-copilot",
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot", "xzbdmw/colorful-menu.nvim" },
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
          copilot = {
            module = "blink-copilot",
            opts = {
              max_completions = 3,
              max_attempts = 4,
            },
            score_offset = 8,
          },
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
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<C-j>"] = { "select_next" },
        ["<C-k"] = { "select_prev" },
        ["<CR>"] = {
          function(cmp)
            return cmp.select_and_accept()
          end,
          -- "accept",
          "fallback",
        },
      },
    },
  },
}
