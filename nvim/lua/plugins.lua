-- Plugin definition and loading
-- local execute = vim.api.nvim_command
local fn = vim.fn
local cmd = vim.cmd

-- Boostrap Packer
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone','https://github.com/wbthomason/packer.nvim', install_path})
end

-- Load Packer
cmd([[packadd packer.nvim]])

-- Rerun PackerCompile everytime pluggins.lua is updated
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Initialize pluggins
return require('packer').startup(function(use)
  -- Let Packer manage itself
  use({'wbthomason/packer.nvim', opt = true})

  -- LSP management (must come first as per mason-lspconfig.nvim's instructions)
  -- use "williamboman/mason.nvim"
  -- use ({
  --   "williamboman/mason-lspconfig.nvim",
  --   config = function() require('pluginConfig.mason-lspconfig') end,
  -- })

  -- -- LSP server
  -- use({
  --   'neovim/nvim-lspconfig',
  --   config = function() require('pluginConfig.lspconfig') end
  -- })
  use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile', requres = 'pluginConfig.cocConfig'}

    -- Autocomplete
  use({
    "hrsh7th/nvim-cmp",
    -- Sources for nvim-cmp
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function() require('pluginConfig.cmp') end,
  })

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    config = function() require('pluginConfig.treesitter') end,
    run = ':TSUpdate'
  })

  -- Snippets
  use {"L3MON4D3/LuaSnip", config = function() require('pluginConfig.snippets') end}
  use "rafamadriz/friendly-snippets"

  -- Copilot
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  }

  use {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua" },
  config = function ()
    require("copilot_cmp").setup()
  end
}

  -- Signature help
  use "ray-x/lsp_signature.nvim"

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/plenary.nvim'}},
    config = function() require('pluginConfig.telescope') end,
  })

  use({'nvim-telescope/telescope-fzf-native.nvim', run ='make'})

  -- bufferline
  use({
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('pluginConfig.bufferline') end,
    event = 'BufWinEnter',
  })

  -- statusline
  use({
    'hoob3rt/lualine.nvim',
    config = function() require('pluginConfig.lualine') end,
  })

  -- NvimTree
  use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('pluginConfig.nvimtree') end,  -- Must add this manually
  })

  -- Startify
  use({
    'mhinz/vim-startify',
    config = function()
      local path = vim.fn.stdpath('config')..'/lua/pluginConfig/startify.vim'
      vim.cmd('source '..path)
    end
  })

  -- git commands
  use 'tpope/vim-fugitive'

  -- Gitsigns
  use ({
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function() require('pluginConfig.gitsigns') end
  })

  -- Formatting
  use 'tpope/vim-commentary'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'junegunn/vim-easy-align'
  use({'jose-elias-alvarez/null-ls.nvim',
      config = function() require('pluginConfig.nullLs') end
  })
    -- Lua
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
       -- your configuration comes here
       -- or leave it empty to use the default settings
       -- refer to the configuration section below
     }
  end
  }
use {'mg979/vim-visual-multi', branch = 'master',}
  -- Markdown
  use 'godlygeek/tabular'
  use 'ellisonleao/glow.nvim'

  -- TOML Files
  use 'cespare/vim-toml'

  -- kitty config syntax-highlight
  use "fladson/vim-kitty"

  -- Themes
  use 'folke/tokyonight.nvim'
  use 'marko-cerovac/material.nvim'
  use { "bluz71/vim-moonfly-colors", as = "moonfly" }


  if packer_bootstrap then
    require('packer').sync()
  end
end)
