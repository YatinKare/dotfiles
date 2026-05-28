local config = {
	defaults = {
		theme = "dark",
		transparent = false,
		hellwal = {
			enabled = false,
			palette_file = "~/.cache/hellwal/hellwal.lua",
		},
		italics = {
			comments = true,
			keywords = true,
			functions = true,
			strings = true,
			variables = true,
			bufferline = false,
		},
		overrides = {},
	},
}

setmetatable(config, { __index = config.defaults })

return config
