return {
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "lukas-reineke/cmp-under-comparator",
      "hrsh7th/cmp-calc",
    },
    lazy = false,
    event = {
      "BufEnter",
      "InsertEnter",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local border = {
        { "┏", "FloatBorder" },
        { "━", "FloatBorder" },
        { "┓", "FloatBorder" },
        { "┃", "FloatBorder" },
        { "┛", "FloatBorder" },
        { "━", "FloatBorder" },
        { "┗", "FloatBorder" },
        { "┃", "FloatBorder" },
      }
      opts.preselect = cmp.PreselectMode.None
      opts.window = {
        completion = {
          border = border,
          -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          -- scrolloff = 0,
          -- col_offset = 0,
          -- side_padding = 1,
          scrollbar = true,
        },
        documentation = {
          -- max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
          -- max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
          scrollbar = true,
          border = border,
          -- winhighlight = "FloatBorder:NormalFloat",
        },
      }

      opts.sources = {
        { name = "nvim_lsp", group_index = 1 },
        { name = "copilot", group_index = 2 },
        { name = "codeium", group_index = 2 },
        { name = "cmp_tabnine", group_index = 2 },
        { name = "snippets", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 1 },
        { name = "nvim_lua", group_index = 1 },
        { name = "calc", group_index = 3 },
      }
      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        expandable_indicator = false,
        format = function(entry, item)
          -- icons
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          item.menu = ({
            codeium = "[Codeium]",
            nvim_lsp = "[LSP]",
            snippets = "[Snippet]",
            nvim_lua = "[NVIM_LUA]",
            buffer = "[Buffer]",
            path = "[Path]",
            cmp_tabnine = "[Tabnine]",
            calc = "[Calc]",
          })[entry.source.name]
          return item
        end,
      }

      local suggestion = require("copilot.suggestion")
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- cmp.select_next_item({ behavior = cmp.ConfirmBehavior.Insert })
            cmp.select_next_item()
          elseif suggestion.is_visible() then
            print("copilot suggestion")
            suggestion.accept()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replaces }),
      })
    end,
  },
}
