local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
	vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

local opts = {
	on_attach = require("logan.lsp.handlers").on_attach,
	capabilities = require("logan.lsp.handlers").capabilities,
}

mason.setup({
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

mason_lspconfig.setup({
	ensure_installed = {
		-- Development languages
		"lua_ls",
		"rust_analyzer",
		"ts_ls",
		"eslint",
		"html",
		"cssls",
		"jsonls",
		"sqlls",
		"bashls",
		"clangd",

		-- Configuration languages
		"yamlls",
		"taplo", -- TOML
		"lemminx", -- XML
	},
	automatic_installation = true,
})

local lua_ls_opts = require("logan.lsp.settings.lua_ls")
local ts_ls_opts = require("logan.lsp.settings.jsonls")
local rust_analyzer_opts = require("logan.lsp.settings.rust_analyzer")
local noop = function() end

mason_lspconfig.setup_handlers({
	function()
		-- Development languages
		lspconfig.lua_ls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities, settings = lua_ls_opts })
		lspconfig.ts_ls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities, settings = ts_ls_opts })
		lspconfig.rust_analyzer.setup({
			on_attach = opts.on_attach,
			capabilities = opts.capabilities,
			settings = rust_analyzer_opts,
		})
		lspconfig.clangd.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
		lspconfig.cssls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
		lspconfig.html.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
		lspconfig.sqlls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
		lspconfig.bashls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities, filetypes = { "sh" } })
		lspconfig.dartls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })

		-- Configuration languages
		lspconfig.yamlls.setup({
			on_attach = opts.on_attach,
			capabilities = opts.capabilities,
			settings = {
				yaml = {
					schemas = {
						["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
						["https://json.schemastore.org/github-action.json"] = "/.github/actions/*",
						["https://json.schemastore.org/docker-compose.json"] = "/docker-compose.yml",
						["https://json.schemastore.org/kustomization.json"] = "/kustomization.yaml",
						["https://json.schemastore.org/chart.json"] = "/Chart.yaml",
					},
					validate = true,
					format = { enabled = true },
				},
			},
		})

		lspconfig.taplo.setup({
			on_attach = opts.on_attach,
			capabilities = opts.capabilities,
			settings = {
				evenBetterToml = {
					schema = {
						enabled = true,
						associations = {
							["Cargo.toml"] = "https://json.schemastore.org/cargo.json",
							["pyproject.toml"] = "https://json.schemastore.org/pyproject.json",
							["**/action.toml"] = "https://json.schemastore.org/github-action.json",
							["**/workflow*.toml"] = "https://json.schemastore.org/github-workflow.json",
						},
					},
					formatter = {
						indentTables = true,
						reorderKeys = false,
						indentString = "  ", -- 2 spaces
						alignEntries = false,
						arrayTrailingComma = false,
						arrayAutoExpand = true,
						compact = false,
					},
				},
			},
		})
		lspconfig.lemminx.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
	end,
	["jdtls"] = noop,
})
