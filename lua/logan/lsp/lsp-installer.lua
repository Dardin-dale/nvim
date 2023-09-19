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


--[[ local status_ok, jdtls = pcall(require, "jdtls") ]]
--[[ if not status_ok then ]]
--[[     return ]]
--[[ end ]]


local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)


local opts = {
    on_attach = require("logan.lsp.handlers").on_attach,
    capabilities = require("logan.lsp.handlers").capabilities,
}

mason.setup({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

mason_lspconfig.setup {
    ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'tsserver',
        'eslint',
        'html',
        'cssls',
        --[[ 'pylsp', ]]
    },
    automatic_installation = true
}

local sumneko_opts = require("logan.lsp.settings.sumneko_lua")
local tsserver_opts = require("logan.lsp.settings.jsonls")
local rust_analyzer_opts = require("logan.lsp.settings.rust_analyzer")
local jdtls_opts = require("logan.lsp.settings.jdtls")

mason_lspconfig.setup_handlers({
function ()
    lspconfig.lua_ls.setup { on_attach = opts.on_attach, capabilities = opts.capabilities, settings = sumneko_opts }
    lspconfig.tsserver.setup { on_attach = opts.on_attach, capabilities = opts.capabilities }
    lspconfig.rust_analyzer.setup { on_attach = opts.on_attach, capabilities = opts.capabilities, settings = rust_analyzer_opts}
    lspconfig.jdtls.setup {opts.on_attach, capabilities = opts.capabilities}
    lspconfig.gopls.setup {opts.on_attach, capabilities = opts.capabilities}
    lspconfig.cssls.setup {opts.on_attach, capabilities = opts.capabilities}
    lspconfig.html.setup {opts.on_attach, capabilities = opts.capabilities}
    lspconfig.pylsp.setup {opts.on_attach, capabilities = opts.capabilities}
end
})


--[[ local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t') ]]
--[[]]
--[[ local workspace_dir = '/path/to/workspace-root/' .. project_name ]]


-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
--[[ local config = { ]]
--[[   -- The command that starts the language server ]]
--[[   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line ]]
--[[   cmd = { ]]
--[[]]
--[[     -- 💀 ]]
--[[     'java', -- or '/path/to/java17_or_newer/bin/java' ]]
--[[             -- depends on if `java` is in your $PATH env variable and if it points to the right version. ]]
--[[]]
--[[     '-Declipse.application=org.eclipse.jdt.ls.core.id1', ]]
--[[     '-Dosgi.bundles.defaultStartLevel=4', ]]
--[[     '-Declipse.product=org.eclipse.jdt.ls.core.product', ]]
--[[     '-Dlog.protocol=true', ]]
--[[     '-Dlog.level=ALL', ]]
--[[     '-Xms1g', ]]
--[[     '--add-modules=ALL-SYSTEM', ]]
--[[     '--add-opens', 'java.base/java.util=ALL-UNNAMED', ]]
--[[     '--add-opens', 'java.base/java.lang=ALL-UNNAMED', ]]
--[[]]
--[[     -- 💀 ]]
--[[     '-jar', 'C:/Users/Logan/AppData/Local/nvim-data/mason/packages/jdtls/bin', ]]
--[[          -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^ ]]
--[[          -- Must point to the                                                     Change this to ]]
--[[          -- eclipse.jdt.ls installation                                           the actual version ]]
--[[]]
--[[]]
--[[     -- 💀 ]]
--[[     '-configuration', 'C:/Users/Logan/AppData/Local/nvim-data/mason/packages/jdtls/config_win', ]]
--[[                     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^ ]]
--[[                     -- Must point to the                      Change to one of `linux`, `win` or `mac` ]]
--[[                     -- eclipse.jdt.ls installation            Depending on your system. ]]
--[[]]
--[[]]
--[[     -- 💀 ]]
--[[     -- See `data directory configuration` section in the README ]]
--[[     '-data', workspace_dir ]]
--[[   }, ]]
--[[]]
--[[   -- 💀 ]]
--[[   -- This is the default if not provided, you can remove it. Or adjust as needed. ]]
--[[   -- One dedicated LSP server & client will be started per unique root_dir ]]
--[[   root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}), ]]
--[[]]
--[[   -- Here you can configure eclipse.jdt.ls specific settings ]]
--[[   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request ]]
--[[   -- for a list of options ]]
--[[   settings = { ]]
--[[     java = { ]]
--[[     } ]]
--[[   }, ]]
--[[]]
--[[   -- Language server `initializationOptions` ]]
--[[   -- You need to extend the `bundles` with paths to jar files ]]
--[[   -- if you want to use additional eclipse.jdt.ls plugins. ]]
--[[   -- ]]
--[[   -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation ]]
--[[   -- ]]
--[[   -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this ]]
--[[   init_options = { ]]
--[[     bundles = {} ]]
--[[   }, ]]
--[[ } ]]
--[[]]
--[[ jdtls.start_or_attach(config); ]]
--[[]]
--[[ lsp_bridge.setup_handlers({ ]]
--[[     function (server_name) ]]
--[[         require("lspconfig")[server_name].setup{ ]]
--[[             on_attach = opts.on_attach, ]]
--[[]]
--[[         } ]]
--[[     end ]]
--[[ }) ]]
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
