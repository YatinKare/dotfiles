local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
require("telescope").setup({
	defaults = {
		mappings = {
			n = {
				["<C-d>"] = actions.delete_buffer, -- Delete selected in normal mode
				["dd"] = actions.delete_buffer, -- Or use 'dd' to delete
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
	{ name = "School", value = "~/Dropbox/Yatins Vault" },
	{ name = "Config", value = "~/.config/nvim" },
	{ name = "Jobs", value = "~/Dropbox/Yatins Vault/Jobs" }, -- fixed Vault/Value if needed
	{ name = "Documents", value = "~/Documents" },
	{ name = "Dropbox", value = "~/Dropbox" },
	{ name = "GitHub", value = "~/Documents/GitHub" },
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

	pickers
		.new(opts, {
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
		})
		:find()
end
