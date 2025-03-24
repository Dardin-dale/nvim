local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("logan.lsp.lsp-installer")
require("logan.lsp.handlers").setup()
