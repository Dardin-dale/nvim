local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

local status_ok2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok2 then
    return
end

local status_ok3, lspconfig = pcall(require, "lspconfig")
if not status_ok3 then
    return
end

-- Get our custom LSP handler settings
local opts = {
    on_attach = require("logan.lsp.handlers").on_attach,
    capabilities = require("logan.lsp.handlers").capabilities,
}

-- Set up Mason
mason.setup({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗",
        },
    },
})

-- Set up Mason-LSPConfig with your desired servers
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
        "groovyls",
        -- Configuration languages
        "yamlls",
        "taplo",   -- TOML
        "lemminx", -- XML
    },
    automatic_installation = true,
    -- Exclude servers that we manually configure below
    automatic_enable = {
        exclude = {
            "lua_ls",
            "rust_analyzer",
            "ts_ls",
            "bashls",
            "yamlls",
            "taplo",
        }
    },
})

-- Load custom server settings
local lua_ls_opts = require("logan.lsp.settings.lua_ls")
local ts_ls_opts = require("logan.lsp.settings.jsonls")
local rust_analyzer_opts = require("logan.lsp.settings.rust_analyzer")

-- Manually set up each server
-- Lua
lspconfig.lua_ls.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    settings = lua_ls_opts,
})

-- TypeScript
lspconfig.ts_ls.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    settings = ts_ls_opts,
})

-- Rust
lspconfig.rust_analyzer.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    settings = rust_analyzer_opts,
})

-- Bash
lspconfig.bashls.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    filetypes = { "sh" },
})

-- YAML
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

-- TOML
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

-- Set up the remaining servers with default options
local default_servers = {
    "html", "cssls", "eslint", "jsonls", "sqlls", "clangd", "groovyls", "lemminx"
}

for _, server in ipairs(default_servers) do
    lspconfig[server].setup({
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
    })
end

-- Custom Dart setup outside of Mason
local function setup_dart_workspace()
    local project_root = "/home/logan/sw/dynoshop1"

    -- Define all the workspace folders to include
    local workspace_folders = {
        {
            name = "project_root",
            uri = "file://" .. project_root,
        },
        {
            name = "store",
            uri = "file://" .. project_root .. "/store",
        },
        {
            name = "storeMgt",
            uri = "file://" .. project_root .. "/storeMgt",
        },
        {
            name = "shared",
            uri = "file://" .. project_root .. "/shared",
        },
    }

    return workspace_folders
end

lspconfig.dartls.setup({
    cmd = { "dart", "language-server", "--protocol=lsp" },
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    workspace_folders = setup_dart_workspace(),
})
