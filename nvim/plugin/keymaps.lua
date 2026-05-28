vim.keymap.set("n", "<leader>w", "<cmd>update<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>source %<cr>")
vim.keymap.set("n", "<leader>qq", "<cmd>q!<cr>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>t", "<cmd>below term<cr> i")
vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>")
vim.keymap.set("n", "<leader>c", ":w | below Compile ")
vim.keymap.set("n", "<leader>ge", "<cmd>w | below Compile <cr> <cr> ww")

-- Split into new Oil Buffer
vim.keymap.set("n", "<C-w><C-s>", "<C-w><C-s><C-w>w <cmd>Oil<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>s", "<C-w><C-s><C-w>w <cmd>Oil<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w><C-v>", "<C-w><C-v><C-w>w <cmd>Oil<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>v", "<C-w><C-v><C-w>w <cmd>Oil<cr>", { noremap = true, silent = true })

-- Plugins
vim.keymap.set("n", "<leader>pc", require("pack-config").pack_clean, { desc = "Clean unused plugins" })
vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>")
vim.keymap.set("n", "<leader>pu", "<cmd>lua vim.pack.update()<cr>")

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)

-- Blink.cmp

vim.keymap.set("n", "<leader>lbt", function()
	_G.blink = not _G.blink
	print("Blink enabled: " .. tostring(_G.blink))
end)

-- Copilot
vim.keymap.set("n", "<leader>lct", function()
	vim.lsp.inline_completion.enable(not vim.lsp.inline_completion.is_enabled())
	vim.print("Copilot Enabled: " .. tostring(vim.lsp.inline_completion.is_enabled()))
end, { desc = "Toggle Copilot" })
vim.keymap.set("i", "<Tab>", vim.lsp.inline_completion.get)

-- Custom to my common dirs.
vim.keymap.set("n", "<leader>fd", function()
	show_common_dirs({ new_tab = false })
end, { desc = "Oil common dirs" })

vim.keymap.set("n", "<leader>Fd", function()
	show_common_dirs({ new_tab = true })
end, { desc = "Oil common dirs (tab)" })

vim.keymap.set("n", "<leader>p", "<cmd>PasteImage<cr>")
