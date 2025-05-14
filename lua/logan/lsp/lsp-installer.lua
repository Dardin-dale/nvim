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
        "groovyls",
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
    -- Default handler for all servers
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
        })
    end,

    -- Custom handlers for specific servers
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
            settings = lua_ls_opts,
        })
    end,

    ["ts_ls"] = function()
        lspconfig.ts_ls.setup({
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
            settings = ts_ls_opts,
        })
    end,

    ["rust_analyzer"] = function()
        lspconfig.rust_analyzer.setup({
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
            settings = rust_analyzer_opts,
        })
    end,

    ["bashls"] = function()
        lspconfig.bashls.setup({
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
            filetypes = { "sh" },
        })
    end,

    ["yamlls"] = function()
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
    end,

    ["taplo"] = function()
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
    end,

    ["groovyls"] = function()
        lspconfig.groovyls.setup({
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
            -- You can add specific settings for Groovy here if needed
        })
    end,

    ["jdtls"] = noop,
})

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
