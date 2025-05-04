local M = {}

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn",  text = "" },
        { name = "DiagnosticSignHint",  text = "" },
        { name = "DiagnosticSignInfo",  text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- Disable virtual text by default, but allow users to enable it
        virtual_text = false,
        -- Show signs in the sign column
        signs = {
            active = signs,
        },
        -- Update diagnostics in insert mode (set to false if causing performance issues)
        update_in_insert = false,
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
    if client.server_capabilities.documentHighlight then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = 0,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            buffer = 0,
            callback = vim.lsp.buf.clear_references,
        })
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

    -- Add a manual formatting command using conform.nvim
    keymap("n", "<leader>f", "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>")

    -- Document these keymaps with which-key (buffer-local)
    local wk_status_ok, wk = pcall(require, "which-key")
    if wk_status_ok then
        -- Register the non-leader LSP mappings
        wk.register({
            { "gD",    desc = "Go to declaration" },
            { "gd",    desc = "Go to definition" },
            { "<S-K>", desc = "Show hover" },
            { "gi",    desc = "Go to implementation" },
            { "gk",    desc = "Show signature help" },
            { "gr",    desc = "Find references" },
            { "[d",    desc = "Previous diagnostic" },
            { "]d",    desc = "Next diagnostic" },
            { "gl",    desc = "Show diagnostic details" },
        }, { buffer = bufnr })

        -- Register the leader LSP mappings under the existing LSP group
        wk.register({
            l = {
                q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Diagnostics to loclist" },
                r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol" },
                a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
            },
            f = { "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>", "Format file" },
        }, { buffer = bufnr, prefix = "<leader>" })
    end
end

M.on_attach = function(client, bufnr)
    -- Disable formatting for certain clients if conform.nvim is handling it
    if client.name == "tsserver" or client.name == "lua_ls" or client.name == "rust_analyzer" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

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
