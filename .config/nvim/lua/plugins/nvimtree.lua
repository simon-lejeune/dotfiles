require("nvim-tree").setup({
  sort_by = "case_sensitive",
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  view = {
    width = 50,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  renderer = {
    group_empty = false,
    highlight_opened_files = "names",
    icons = {
      show = {
        git = false,
        folder = false,
        file = false,
        folder_arrow = false,
      },
    },
  },
})

local set_keymap = vim.keymap.set
local options = { noremap = true, silent = true }

set_keymap('n', '<leader>-', ':NvimTreeToggle<CR>', options)
