return {
  "mfussenegger/nvim-lint",
  init = function()
    vim.diagnostic.config({ virtual_text = true })
  end,
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      python = { "pylint" },
      -- module requires Go 1.20
      go = { "golangcilint" },
    },
    linters = {
      pylint = {
        stdin = false,
        args = {
          "-f",
          "json",
          "--max-line-length=80",
          "-d=C0112,C0114,C0115,C0116,W0621,E0401,C0103",
          "--logging-fstring-interpolation=false",
          "--logging-format-interpolation=true",
        },
        ignore_exitcode = true,
      },
    },
  },
}
