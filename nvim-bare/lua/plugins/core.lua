return {
	{
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
      dependencies = { 'nvim-lua/plenary.nvim' }
  },
}
