-- lua/plugins/lsp.lua

return {
	-- This table contains all the plugins related to LSP functionality

	-- Plugin 1: mason.nvim (The installer for LSPs, formatters, etc.)
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Plugin 2: mason-lspconfig.nvim (The bridge)
	{ "williamboman/mason-lspconfig.nvim" },

	-- Plugin 3: nvim-lspconfig (The main LSP configuration engine)
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- This on_attach function runs for each LSP server that attaches to a buffer.
			local on_attach = function(client, bufnr)
				-- Your Keymaps
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
				vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr, desc = "Line Diagnostics" })
				vim.keymap.set("n", "gd", function()
					require("telescope.builtin").lsp_definitions({ reuse_win = true })
				end, { buffer = bufnr, desc = "Goto Definition" })
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to Declaration" })
				vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go to References" })
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
			end

			-- Get capabilities from nvim-cmp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- The list of servers to set up
			local servers = {
				"lua_ls",
				"rust_analyzer",
				"vtsls",
				"tailwindcss",
				"cssls",
				"html",
				"yamlls",
				"terraformls",
			}

			-- Your custom server settings (if any)
			local custom_server_configs = {
				-- vtsls = { ... },
			}

			-- THE MODERNIZED SETUP LOOP
			for _, server_name in ipairs(servers) do
				-- Get any custom settings for the server
				local server_opts = custom_server_configs[server_name] or {}

				-- Merge the shared settings with the custom ones
				local final_opts = vim.tbl_deep_extend("force", {
					on_attach = on_attach,
					capabilities = capabilities,
				}, server_opts)

				-- This is the NEW, correct API call for Neovim 0.11+
				vim.lsp.config(server_name, final_opts)
				vim.lsp.enable(server_name)
			end
		end,
	},
}
