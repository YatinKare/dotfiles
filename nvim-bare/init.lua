-- General Editor
vim.cmd([[set mouse=]])
vim.o.number = true
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.opt.winborder = "rounded"
vim.o.smartindent = true
vim.o.termguicolors = true

-- Leader
vim.g.mapleader = ' '

-- Basic Keybindings
local map = vim.keymap.set

vim.keymap.set('n', '<leader>w', '<cmd>update<cr>')
vim.keymap.set('n', '<leader>s', '<cmd>source %<cr>')
vim.keymap.set('n', '<leader>qq', '<cmd>q!<cr>')
vim.keymap.set('n', '<leader>o', '<cmd>Oil<cr>') -- Open Oil
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>') -- Open package manager (lazy)
vim.keymap.set('n', '<leader>m', '<cmd>Mason<cr>') -- Open package manager (lazy)

-- Plugins [https://neovim.io/doc/user/pack.html]
require("config.lazy")

require("oil").setup({
	columns = {
		"permissions",
		"size",
		"mtime",
		"icon"
	},
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	prompt_save_on_select_new_entry = true,
	lsp_file_methods = {
    -- Enable or disable LSP file operations
    enabled = true,
    -- Time to wait for LSP file operations to complete before skipping
    timeout_ms = 1000,
    -- Set to true to autosave buffers that are updated with LSP willRenameFiles
    -- Set to "unmodified" to only save unmodified buffers
    autosave_changes = true,
	watch_for_changes = true,
  },
})

function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

require("oil").setup({
  win_options = {
    winbar = "%!v:lua.get_oil_winbar()",
  },
})
-- require("telescope").setup({
--     defaults = {
--         preview = { treesitter = false },
--         color_devicons = true,
--         path_displays = { smart },
--     },
-- })

-- Plugin Keybindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


-- LSP
vim.lsp.enable({
    "lua_ls", 
})
