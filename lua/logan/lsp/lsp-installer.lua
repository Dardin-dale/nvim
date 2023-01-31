local status_ok, lsp_installer = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok, lsp_bridge = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

local opts = {
    on_attach = require("logan.lsp.handlers").on_attach,
    capabilities = require("logan.lsp.handlers").capabilities,
}

lsp_installer.setup({
    --[[ automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig) ]]
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

lsp_bridge.setup {
    ensure_installed = {"sumneko_lua", "rust_analyzer"},
    automatic_installation = true
}

local sumneko_opts = require("logan.lsp.settings.sumneko_lua")
local tsserver_opts = require("logan.lsp.settings.jsonls")
local rust_analyzer_opts = require("logan.lsp.settings.rust_analyzer")
local jdtls_opts = require("logan.lsp.settings.jdtls")

lspconfig.sumneko_lua.setup { on_attach = opts.on_attach, capabilities = opts.capabilities, settings = sumneko_opts }
lspconfig.tsserver.setup { on_attach = opts.on_attach, capabilities = opts.capabilities, settings = tsserver_opts }
lspconfig.rust_analyzer.setup { on_attach = opts.on_attach, capabilities = opts.capabilities, settings = rust_analyzer_opts}
lspconfig.jdtls.setup {opts.on_attach, capabilities = opts.capabilities, settings = jdtls_opts, cmd = { 'C:/Program Files/Java/jdt-language-server-1.9.0-202203031534/bin/jdtls' }}
lspconfig.gopls.setup {opts.on_attach, capabilities = opts.capabilities}
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
--lsp_installer.on_server_ready(function(server)

--	 if server.name == "jsonls" then
--	 	local jsonls_opts = require("logan.lsp.settings.jsonls")
--	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
--	 end

--	 if server.name == "sumneko_lua" then
--	 	local sumneko_opts = require("logan.lsp.settings.sumneko_lua")
--	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
--	 end

	 -- if server.name == "pyright" then
	 	-- local pyright_opts = require("logan.lsp.settings.pyright")
	 	-- opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	 -- end

--	 if server.name == "rust_analyzer" then
--	 	local rust_opts = require("logan.lsp.settings.rust_analyzer")
--	 	opts = vim.tbl_deep_extend("force", rust_opts, opts)
--	 end
	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--	server:setup(opts)
--end)
