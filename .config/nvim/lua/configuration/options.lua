local fn = vim.fn
local global_options = vim.o

local defined_options  = {
  mouse          = 'a',
  background     = 'dark',
  modeline       = false,
  number         = true,
  cursorline     = true,
  clipboard      = 'unnamedplus',
  expandtab      = true,
  splitbelow     = true,
  splitright     = true,
  list           = true,
  listchars      = 'tab:>·,trail:·,nbsp:¬',
  ignorecase     = true,
  fixendofline   = false,
}

-- Enable true colors if supported
if (fn.has('termguicolors')) then
  defined_options.termguicolors = true
end

-- Undo file settings
if (fn.has('persistent_undo')) then
  defined_options.undodir     = fn.stdpath('config') .. '/undodir/'
  defined_options.undofile    = true
end

-- Dissable some features when running as Root
if (fn.exists('$SUDO_USER') ~= 0) then
  defined_options.swapfile    = false
  defined_options.backup      = false
  defined_options.writebackup = false
  defined_options.undofile    = false
  defined_options.viminfo     = nil
end

-- Use ripgrep as the grep program, if available
if (fn.executable('rg') == 1) then
  defined_options.grepprg = 'rg --vimgrep --no-heading --smart-case'
end

for option, value in pairs(defined_options) do
  global_options[option] = value
end

-- Enable filetype detection and use plugins and indentation
vim.cmd('filetype plugin indent on')

-- Enable highlighting embedded lua code
vim.g.vimsyn_embed = 'l'

-- Use Python 3 for plugins
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

-- Set Space as the leader key
vim.g.mapleader = ' '

-- disable netrw, as per https://github.com/nvim-tree/nvim-tree.lua doc
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
