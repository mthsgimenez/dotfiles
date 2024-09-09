local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
   'nvim-lua/popup.nvim',
   'nvim-lua/plenary.nvim',
   { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
   { 'folke/tokyonight.nvim', lazy = false, priority = 1000 },
   { 'rose-pine/neovim', name = 'rose-pine', priority = 1000 },
   {
      'kylechui/nvim-surround',
      version = '*',
      event = 'VeryLazy',
      config = true
   },
   {
      'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' }
   },
   { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
   { 'stevearc/oil.nvim', opts = {}, dependencies = { "nvim-tree/nvim-web-devicons" } },
   { 'windwp/nvim-ts-autotag', config = true },
   { 'numToStr/Comment.nvim', config = true },
   {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
   },
   {
      "lervag/vimtex",
      lazy = false,     -- we don't want to lazy load VimTeX
      -- tag = "v2.15", -- uncomment to pin to a specific release
      init = function()
         -- VimTeX configuration goes here, e.g.
         vim.g.vimtex_view_method = "zathura"
      end
   },
   -- LSP
   'neovim/nvim-lspconfig',
   'williamboman/mason.nvim',
   'williamboman/mason-lspconfig.nvim',
   'hrsh7th/nvim-cmp',
   'hrsh7th/cmp-nvim-lsp',
   'L3MON4D3/LuaSnip',
}

require("lazy").setup(plugins, opts)
