local set_keymap = vim.keymap.set
local options = { noremap = true, silent = true }

set_keymap('n', '<leader>w', ':bd<CR>', options)
set_keymap('n', '<CR>', ':nohlsearch<CR><CR>', options)
