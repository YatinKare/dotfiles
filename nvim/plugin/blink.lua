_G.blink = false
require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust" },
	enabled = function()
		return _G.blink and vim.bo.buftype ~= "prompt"
	end,
})
