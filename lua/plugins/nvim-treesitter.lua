return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- vim.list_extend(opts.ensure_installed, {
      --   "tsx",
      --   "typescript",
      -- })
      opts.indent = { enable = true }
      opts.ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        -- "tsx",
        -- "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "vue",
        "css",
        "scss",
        "go",
      }
      opts.autopairs = {
        enable = true,
      }
      opts.autotag = {
        enable = true,
      }
      opts.rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
      }
      opts.context_commentstring = {
        enable = true,
      }
      opts.highlight = {
        enable = true,
        -- disable = { "c", "rust" },
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<c-p>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
    init = function()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if not cmp_status_ok then
        return
      end
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    end,
  },
  { "windwp/nvim-ts-autotag" },
  { "p00f/nvim-ts-rainbow" },
}
