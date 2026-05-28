require("mason").setup()
require("mason-lspconfig").setup()

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = "vim",
			},
		},
	},
})

-- makes sure that ruff_lsp doesn't provide diagnostics, since pyrefly does
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.name == "ruff_lsp" then
			client.server_capabilities.diagnosticProvider = {
				identifier = "pyrefly",
				interFileDependencies = false,
				workDoneProgress = true,
				workspaceDiagnostics = false,
			}
            vim.print("removed ruff diag")
		end
	end,
})
