return {
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "lukas-reineke/cmp-under-comparator",
      "hrsh7th/cmp-calc",
      "ray-x/cmp-treesitter",
    },
    lazy = false,
    event = {
      "BufEnter",
      "InsertEnter",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
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
        -- { name = "codeium", group_index = 1 },
        -- { name = "cmp_tabnine", group_index = 1 },
        { name = "luasnip", group_index = 1 },
        { name = "buffer", group_index = 1 },
        { name = "path", group_index = 1 },
        { name = "nvim_lua", group_index = 1 },
        { name = "calc", group_index = 1 },
        { name = "treesitter", group_index = 1 },
      }
      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          -- icons
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          item.menu = ({
            -- codeium = "[Codeium]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            nvim_lua = "[NVIM_LUA]",
            buffer = "[Buffer]",
            path = "[Path]",
            -- cmp_tabnine = "[TABNINE]",
            calc = "[CALC]",
            treesitter = "[TS]",
          })[entry.source.name]
          return item
        end,
      }
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
            -- elseif has_words_before() then
            --   cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      })

      opts.sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          require("cmp-under-comparator").under,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }

      opts.confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }
    end,
  },
  {
    "tzachar/cmp-tabnine",
    enabled = false,
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    opts = {
      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = true,
      snippet_placeholder = "..",
      ignored_file_types = {
        -- default is not to ignore
        -- uncomment to ignore in lua:
        -- lua = true
      },
      show_prediction_strength = false,
    },
  },
  -- {
  --   "Exafunction/codeium.vim",
  --   lazy = true,
  --   event = { "InsertEnter" },
  --   config = function()
  --     vim.g.codeium_disable_bindings = 1
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.keymap.set("i", "<a-s>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true })
  --     vim.keymap.set("i", "<a-i>", function()
  --       return vim.fn["codeium#CycleCompletions"](1)
  --     end, { expr = true })
  --     -- vim.keymap.set("i", "<a-,>", function()
  --     --   return vim.fn["codeium#CycleCompletions"](-1)
  --     -- end, { expr = true })
  --     vim.keymap.set("i", "<a-x>", function()
  --       return vim.fn["codeium#Clear"]()
  --     end, { expr = true })
  --   end,
  -- },
  {
    "jcdickinson/codeium.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end,
  },
}
