-- This is the complete configuration file with the updated nvim-lspconfig setup.

return {
	-- Installs LSP servers, formatters, and linters
	{
	    "williamboman/mason.nvim",
		opts = {
            -- This is the list of ALL tools to install with Mason.
            -- Includes LSPs, linters, and formatters.
			ensure_installed = {
				-- LSPs
				"vtsls",
				"rust-analyzer",
				"tailwindcss",
				"cssls",
				"terraformls",
                "html", -- From your previous config
                "yamlls", -- From your previous config
                "lua-language-server", -- The package name for lua_ls

				-- Linters & Formatters
				"shellcheck",
				"shfmt",
                "stylua", -- From your previous config
                "selene", -- From your previous config
                "luacheck", -- From your a previous config
			},
		},
	},
	-- Bridges mason.nvim with nvim-lspconfig for automatic server setup
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- This is your list of servers that mason-lspconfig will ensure are installed.
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"vtsls",
				"tailwindcss",
				"cssls",
				"html",
				"yamlls",
				"vtsls",
				"terraformls",
			},
		},
	},

	-- The main LSP configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		-- This config function is updated to use the new vim.lsp.config API.
		config = function()
			-- This function runs for each LSP server that attaches to a buffer.
			local on_attach = function(client, bufnr)
				-- --- Your Custom Keymaps ---
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover (Type/Docs)" })
				vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show Line Diagnostics" })
				vim.keymap.set("n", "gd", function()
					require("telescope.builtin").lsp_definitions({ reuse_win = false })
				end, { buffer = bufnr, desc = "Goto Definition (Telescope)" })

				-- --- Other Standard LSP Keymaps ---
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to Declaration" })
				vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go to References" })
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
			end

			-- Standard capabilities for LSP servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			-- --- Your Custom Server Configurations ---
			-- A table holding server-specific settings.
			local servers = {
				cssls = {},
				tailwindcss = {},
				vtsls = {
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)

						local root = require("lspconfig.util").root_pattern(".git")(vim.api.nvim_buf_get_name(bufnr))
						if root and vim.fn.filereadable(root .. "/.prettierrc") > 0 then
							-- If a prettier config is found, disable the vtsls formatter to prevent conflicts
							client.server_capabilities.documentFormattingProvider = false
							client.server_capabilities.documentRangeFormattingProvider = false
						end
					end,
				},
				html = {},
				terraformls = {
					filetypes = { "terraform", "tf", "tfvars" },
				},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},
				lua_ls = {
					single_file_support = true,
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							completion = { workspaceWord = true, callSnippet = "Both" },
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = { privateName = { "^_" } },
							type = { castNumberToInteger = true },
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								groupSeverity = { strong = "Warning", strict = "Warning" },
								groupFileStatus = {
									ambiguity = "Opened",
									await = "Opened",
									codestyle = "None",
									duplicate = "Opened",
									global = "Opened",
									luadoc = "Opened",
									redefined = "Opened",
									strict = "Opened",
									strong = "Opened",
									["type-check"] = "Opened",
									unbalanced = "Opened",
									unused = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = { enable = false },
						},
					},
				},
			}

			-- This loop sets up every server with your custom settings.
			for server_name, server_config in pairs(servers) do
				-- Merge the server-specific settings with our shared settings
				local final_config = vim.tbl_deep_extend("force", {
					on_attach = on_attach,
					capabilities = capabilities,
					inlay_hints = { enabled = false },
				}, server_config)

				-- The new way to configure and enable LSPs
				vim.lsp.config(server_name, final_config)
				vim.lsp.enable(server_name)
			end
		end,
	},

	-- Markview config, correctly configured to be lazy-loaded.
	{
		"OXY2DEV/markview.nvim",
		ft = { "markdown" }, -- Only loads for markdown files
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}
