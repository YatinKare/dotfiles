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
vim.cmd('filetype plugin on')
vim.cmd('set omnifunc=syntaxcomplete#Complete')

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    end,
})

-- Leader
vim.g.mapleader = ' '

-- Basic Keybindings

vim.keymap.set('n', '<leader>w', '<cmd>update<cr>')
vim.keymap.set('n', '<leader>s', '<cmd>source %<cr>')
vim.keymap.set('n', '<leader>qq', '<cmd>q!<cr>')
vim.keymap.set('n', '<leader>o', '<cmd>Oil<cr>')                         -- Open Oil
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>')                        -- Open package manager (lazy)
vim.keymap.set('n', '<leader>m', '<cmd>Mason<cr>')                       -- Open package manager (lazy)
vim.keymap.set('n', '<leader>ge', '<cmd>w | below Recompile<cr> <cr>ww') -- compile-mode.nvim
vim.keymap.set('n', '<leader>c', ':w | below Compile ')
vim.keymap.set('n', '<leader>t', '<cmd>below term<cr> i')                -- Open terminal below
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)                    -- compile-mode.nvim

-- Plugins [https://neovim.io/doc/user/pack.html]
require("config.lazy")

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
    columns = {
        "permissions",
        "size",
        "mtime",
        "icon"
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    lsp_file_methods = {
        -- Enable or disable LSP file operations
        enabled = true,
        -- Time to wait for LSP file operations to complete before skipping
        timeout_ms = 1000,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        -- Set to "unmodified" to only save unmodified buffers
        autosave_changes = true,
    },
    watch_for_changes = true,

    win_options = {
        winbar = "%!v:lua.get_oil_winbar()",
    },
    view_options = {
        show_hidden = true
    },
})




-- require("telescope").setup({
--
--     defaults = {
--         preview = { treesitter = false },
--         color_devicons = true,
--         path_displays = { smart },
--     },
-- })

require('nvim-treesitter.configs').setup({
    ensure_installed = { "lua", "python" },
})

vim.g.typst_pdf_viewer = "sioyek"

-- Plugin Keybindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

local actions = require('telescope.actions')

local action_state = require('telescope.actions.state')

require('telescope').setup({
    defaults = {
        mappings = {
            n = {
                ["<C-d>"] = actions.delete_buffer, -- Delete selected in normal mode
                ["dd"] = actions.delete_buffer,    -- Or use 'dd' to delete
            },
        },
    },
})

-- Oil - Telescope picker with Oil-like preview
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local previewers = require("telescope.previewers")

local common_dirs = {
    { name = "Downloads", value = "~/Downloads" },
    { name = "School",    value = "~/Dropbox/Yatins Vault/SPRING 2026" },
    { name = "Config",    value = "~/.config/nvim-bare" },
    { name = "Jobs",      value = "~/Dropbox/Yatins Vault/Jobs" }, -- fixed Vault/Value if needed
    { name = "Documents", value = "~/Documents" },
    { name = "Dropbox",   value = "~/Dropbox" },
    { name = "GitHub",    value = "~/Documents/GitHub" },
}

local function scandir_oil_like(path)
    local expanded = vim.fn.expand(path)
    local fs = vim.uv or vim.loop

    local entries = {}
    local handle = fs.fs_scandir(expanded)
    if not handle then
        return {
            "Could not read directory:",
            expanded,
        }
    end

    while true do
        local name, t = fs.fs_scandir_next(handle)
        if not name then
            break
        end

        table.insert(entries, {
            name = name,
            type = t, -- "file", "directory", "link", etc.
        })
    end

    table.sort(entries, function(a, b)
        if a.type == "directory" and b.type ~= "directory" then
            return true
        end
        if a.type ~= "directory" and b.type == "directory" then
            return false
        end
        return a.name:lower() < b.name:lower()
    end)

    local lines = {}
    table.insert(lines, "../")
    table.insert(lines, "")

    for _, entry in ipairs(entries) do
        local prefix = "  "
        local suffix = ""

        if entry.type == "directory" then
            prefix = " "
            suffix = "/"
        elseif entry.type == "link" then
            prefix = " "
        else
            prefix = "󰈔 "
        end

        table.insert(lines, prefix .. entry.name .. suffix)
    end

    return lines
end

local oil_like_previewer = previewers.new_buffer_previewer({
    title = "Directory Preview",
    define_preview = function(self, entry, _)
        if not entry or not entry.value then
            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { "No selection" })
            return
        end

        local lines = scandir_oil_like(entry.value)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

        vim.bo[self.state.bufnr].filetype = "oil"
        vim.bo[self.state.bufnr].buftype = "nofile"
        vim.bo[self.state.bufnr].modifiable = false
    end,
})

show_common_dirs = function(opts)
    opts = opts or {}

    pickers.new(opts, {
        prompt_title = "Common Directories",

        finder = finders.new_table({
            results = common_dirs,

            entry_maker = function(entry)
                local expanded = vim.fn.expand(entry.value)

                return {
                    value = expanded, -- used when selecting
                    display = string.format("  %s", entry.name), -- shown in picker
                    ordinal = entry.name .. " " .. expanded, -- searchable text
                    path = expanded,
                    name = entry.name,
                }
            end,
        }),

        sorter = conf.generic_sorter(opts),
        previewer = oil_like_previewer,

        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                if not selection or not selection.value then
                    vim.notify("No directory selected", vim.log.levels.WARN)
                    return
                end

                -- Open in Oil
                if opts.new_tab then
                    vim.cmd("tabnew " .. vim.fn.fnameescape(selection.value))
                    vim.cmd("Oil")
                else
                    vim.cmd("Oil " .. vim.fn.fnameescape(selection.value))
                    require("oil.actions").cd.callback()
                end


                -- Alternative:
                -- require("oil").open(selection.value)
            end)

            return true
        end,
    }):find()
end

vim.keymap.set("n", "<leader>fd", function()
    show_common_dirs({ new_tab = false })
end, { desc = "Oil common dirs" })

vim.keymap.set("n", "<leader>Fd", function()
    show_common_dirs({ new_tab = true })
end, { desc = "Oil common dirs (tab)" })




-- LSP

vim.lsp.config('ts_ls', {
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
})

-- Neovide

local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<C-=>", function() if vim.g.neovide then change_scale_factor(1.05) end end)     -- zoom in
vim.keymap.set("n", "<C-->", function() if vim.g.neovide then change_scale_factor(1 / 1.05) end end) -- zoom out

if vim.g.neovide then
    vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
    vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
    vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end
