-- General Settings
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.winborder = "rounded"
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.cmd("filetype plugin on")
vim.cmd("set omnifunc=syntaxcomplete#Complete")
vim.g.mapleader = " "

-- vim.pack helpers
require("pack-config") -- pack_clean(): cleans unused packages (<leader>pc)

-- plugins
vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" }, -- dep
	{ src = "https://github.com/ej-shafran/compile-mode.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" }, --dep
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range('1.x')},
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/tjdevries/colorbuddy.nvim" }, -- dep
	{ src = "https://github.com/jesseleite/noirbuddy.nvim" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = "https://github.com/hakonharnes/img-clip.nvim" },
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})
