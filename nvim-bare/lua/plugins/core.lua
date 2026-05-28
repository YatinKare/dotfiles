return {
    { 'neovim/nvim-lspconfig', enabled = false},
    {
        'mason-org/mason-lspconfig.nvim',
        opts = {},
        dependencies = {
            { 'mason-org/mason.nvim', opts = {} },
            'neovim/nvim-lspconfig',
        },
        enabled = false
    },
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
        lazy = false,
        enabled = false,
    },
    {
        'mason-org/mason.nvim',
        opts = {},
        enabled = false
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.2.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        enabled = false,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        lazy = false,
        build = ':TSUpdate',
        enabled = false,
    },
    { 'jannis-baum/vivify.vim', enabled = false },
    {
        'kaarmu/typst.vim',
        ft = 'typst',
        lazy = false,
        enabled = false,
    },
    {
        'ej-shafran/compile-mode.nvim',
        version = '^5.0.0',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            ---@type CompileModeOpts
            vim.g.compile_mode = {}
        end,
        enabled = false,
    },
    {
        'kawre/leetcode.nvim',
        build = ':TSUpdate html',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        opts = {
            lang = 'python',
            plugins = {
                non_standalone = true,
            },
        },
        enabled = false,
    },
    {
        'chomosuke/typst-preview.nvim',
        lazy = false,
        version = '1.*',
        opts = {
            open_cmd = 'qutebrowser %s',
        },
        enabled = false,
    },
    {
        dir = vim.fn.stdpath 'config',
        name = 'hellwal-config',
        priority = 1000,
        lazy = false,
        config = function()
            require('config.hellwal').setup()
        end,
        enabled = false,
    },
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
            -- add options here
            -- or leave it empty to use the default settings
        },
        keys = {
            -- suggested keymap
            { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
        },
        enabled = false,
    }
}
