local M = {}

-- TODO: backfill this to template
M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local keymap = function(mode, key, cmd)
		vim.keymap.set(mode, key, cmd, opts)
	end

	-- Basic LSP keymaps
	keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
	keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	keymap("n", "<S-K>", "<cmd>lua vim.lsp.buf.hover()<CR>")
	keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
	keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>')
	keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>')
	keymap("n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>')

	-- Changed from <leader>q to <leader>lq to avoid conflict with quickfix
	keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>")

	-- Renamed from <leader>rn to <leader>lr for consistency
	keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>")

	-- Add leader+l+a for code actions
	keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>")

	--[[ -- Document these keymaps with which-key (buffer-local) ]]
	--[[ local wk_status_ok, wk = pcall(require, "which-key") ]]
	--[[ if wk_status_ok then ]]
	--[[ 	-- Register the non-leader LSP mappings ]]
	--[[ 	wk.register({ ]]
	--[[ 		{ "gD", desc = "Go to declaration" }, ]]
	--[[ 		{ "gd", desc = "Go to definition" }, ]]
	--[[ 		{ "<S-K>", desc = "Show hover" }, ]]
	--[[ 		{ "gi", desc = "Go to implementation" }, ]]
	--[[ 		{ "gk", desc = "Show signature help" }, ]]
	--[[ 		{ "gr", desc = "Find references" }, ]]
	--[[ 		{ "[d", desc = "Previous diagnostic" }, ]]
	--[[ 		{ "]d", desc = "Next diagnostic" }, ]]
	--[[ 		{ "gl", desc = "Show diagnostic details" }, ]]
	--[[ 	}, { buffer = bufnr }) ]]
	--[[]]
	--[[ 	-- Register the leader LSP mappings under the existing LSP group ]]
	--[[ 	wk.register({ ]]
	--[[ 		l = { ]]
	--[[ 			q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Diagnostics to loclist" }, ]]
	--[[ 			r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol" }, ]]
	--[[ 			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" }, ]]
	--[[ 		}, ]]
	--[[ 	}, { buffer = bufnr, prefix = "<leader>" }) ]]
	--[[ end ]]

	-- Format command (use your conform.nvim setup instead)
	vim.cmd("command! -buffer Format lua vim.lsp.buf.format({ async = true })")
end

M.on_attach = function(client, bufnr)
	--[[ if client.name == "tsserver" then ]]
	--[[   client.resolved_capabilities.document_formatting = false ]]
	--[[ end ]]
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
