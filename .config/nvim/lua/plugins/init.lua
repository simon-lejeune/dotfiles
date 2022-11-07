local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require("packer").startup(
  function(use)
    use "wbthomason/packer.nvim"
    use "ap/vim-buftabline"
    use "ellisonleao/gruvbox.nvim"
    use "tpope/vim-vinegar"
    use "tpope/vim-sleuth"
    use "tpope/vim-fugitive"
    use "tpope/vim-unimpaired"
    use(
      {
        "williamboman/mason.nvim",
        config = function()
          require("plugins.lspconfig")
        end,
        requires = {
          "williamboman/mason-lspconfig.nvim",
          "neovim/nvim-lspconfig"
        }
      }
    )
    use(
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("plugins.luasnip")
        end,
        requires = "rafamadriz/friendly-snippets"
      }
    )
    use(
      {
        "hrsh7th/nvim-cmp",
        config = function()
          require("plugins.cmp")
        end,
        requires = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-nvim-lua",
          "hrsh7th/cmp-buffer",
          "saadparwaiz1/cmp_luasnip"
        }
      }
    )
    use(
      {
        "junegunn/fzf",
        run = "./install --bin"
      }
    )
    use(
      {
        "ibhagwan/fzf-lua",
        config = function()
          require("plugins.fzflua")
        end
      }
    )
    use(
      {
        "mhartington/formatter.nvim",
        config = function()
          require("plugins.formatter")
        end
      }
    )
    use {
      "nvim-treesitter/nvim-treesitter",
      run = function()
        local ts_update = require("nvim-treesitter.install").update({with_sync = true})
        ts_update()
      end,
      config = "require('plugins.treesitter')",
      event = "BufRead"
    }

    if packer_bootstrap then
      require("packer").sync()
      vim.notify("restart nvim after the installation is done")
    end
  end
)
