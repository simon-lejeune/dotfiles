local black = function()
  return {
    exe = "black",
    args = {"-"},
    stdin = true
  }
end

local djhtml = function()
  return {
    exe = "djhtml",
    args = {"-t", "2"},
    stdin = true
  }
end

local luafmt = function()
  return {
    exe = "luafmt",
    args = {"--indent-count", 2, "--stdin"},
    stdin = true
  }
end

local fmt = require "formatter"
fmt.setup(
  {
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
      python = {black},
      lua = {luafmt},
      htmldjango = {require("formatter.filetypes.javascript").prettier},
      html = {require("formatter.filetypes.javascript").prettier},
      javascript = {require("formatter.filetypes.javascript").prettier},
      typescript = {require("formatter.filetypes.typescript").prettier},
      typescriptreact = {require("formatter.filetypes.typescript").prettier}
    }
  }
)
