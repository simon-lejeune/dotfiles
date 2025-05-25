local black = function()
  return {
    exe = "black",
    args = {"-"},
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

local util = require "formatter.util"
local prettier = function()
  return {
      exe = "node_modules/prettier/bin/prettier.cjs",
      args = {
        "--stdin-filepath",
        util.escape_path(util.get_current_buffer_file_path()),
      },
      stdin = true,
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
      javascript = {prettier},
      typescript = {prettier},
      typescriptreact = {prettier},
      css = {require("formatter.filetypes.css").prettier},
      yaml = {prettier}
    }
  }
)
