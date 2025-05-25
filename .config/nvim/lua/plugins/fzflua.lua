local set_keymap = vim.keymap.set
local options = { noremap = true, silent = true }

set_keymap('n', '<c-p>', "<cmd>lua require('fzf-lua').git_files()<CR>", options)
set_keymap('n', ';', "<cmd>lua require('fzf-lua').buffers()<CR>", options)
set_keymap('n', '<leader>/', ":FzfLua live_grep_resume<CR>", options)
set_keymap('n', '<leader>fof', "<cmd>lua require('fzf-lua').oldfiles()<CR>", options)
set_keymap('n', '<F12>', ":FzfLua lsp_document_symbols<CR>", options)
set_keymap('n', '<leader>f', ":FzfLua<CR>", options)

require("fzf-lua").setup({
  buffers = {
    actions = {
      ["ctrl-d"] = { fn = require("fzf-lua").actions.buf_del }
    }
  }
})
