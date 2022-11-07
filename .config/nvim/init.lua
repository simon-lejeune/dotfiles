-- inspired by https://github.com/talha-akram/anvil/blob/220e21e46154da965b0ce16b497a0d99355a7570/lua/plugins/lspconfig.lua
-- https://github.com/ibhagwan/nvim-lua/blob/6fc6379046d3abbfabfcd26c459b7ded87e32c76/lua/plugins/fzf-lua/mappings.lua
-- https://github.com/NullVoxPopuli/dotfiles/blob/main/home/.config/nvim/lua/plugin-config/lsp.lua
--
require('configuration')
if (vim.fn.exists('$SUDO_USER') == 0) then
  require('plugins')
end
vim.cmd([[
  try
    colorscheme gruvbox
    catch
  endtry
]])

