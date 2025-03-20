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
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.sh", command = "set filetype=sh" })

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
		"lua_ls",
		"rust_analyzer",
		"ts_ls",
		"eslint",
		"html",
		"cssls",
		"sqlls",
		"bashls",
		"clangd",
		--[[ 'pylsp', ]]
	},
	automatic_installation = true,
})

local sumneko_opts = require("logan.lsp.settings.sumneko_lua")
local ts_ls_opts = require("logan.lsp.settings.jsonls")
local rust_analyzer_opts = require("logan.lsp.settings.rust_analyzer")
local noop = function() end

mason_lspconfig.setup_handlers({
	function()
		lspconfig.lua_ls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities, settings = sumneko_opts })
		lspconfig.ts_ls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities, settings = ts_ls_opts })
		lspconfig.rust_analyzer.setup({
			on_attach = opts.on_attach,
			capabilities = opts.capabilities,
			settings = rust_analyzer_opts,
		})
		lspconfig.clangd.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
		--[[ lspconfig.gopls.setup { on_attach = opts.on_attach, capabilities = opts.capabilities} ]]
		lspconfig.cssls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
		lspconfig.html.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
		--[[ lspconfig.pylsp.setup { on_attach = opts.on_attach, capabilities = opts.capabilities} ]]
		lspconfig.sqlls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
		lspconfig.bashls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities, filetypes = { "sh" } })
		lspconfig.dartls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
	end,
	["jdtls"] = noop,
})
