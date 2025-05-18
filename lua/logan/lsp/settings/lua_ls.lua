-- In lua_ls.lua file:
return {
    Lua = {
        runtime = {
            -- Tell the language server which version of Lua you're using
            version = 'LuaJIT',
            -- Setup your lua path
            path = vim.split(package.path, ';'),
        },
        diagnostics = {
            -- Get the language server to recognize common globals
            globals = {
                -- Vim API
                'vim',
                -- Plugin development
                'use',
                -- Global variables from Neovim
                'assert',
                -- Builtins
                'string', 'table', 'math', 'io', 'os', 'coroutine',
                -- NVIM globals often used in config
                '_G', 'NVIM_ROOT', 'USER',
                -- Packer
                'packer',
                -- Common plugin globals
                'require',
                -- Lazy
                'lazy',
            },
            disable = {
                "lowercase-global",
            },
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                [vim.fn.stdpath('config') .. '/lua'] = true,
                [vim.fn.stdpath('data') .. '/lazy'] = true,  -- For lazy.nvim plugin files
            },
            -- Don't analyze the following libraries
            ignoreDirs = { '/tmp', '~/.cargo' },
            checkThirdParty = false, -- Disable annoying prompt
            maxPreload = 2000,      -- Adjust based on your machine's capability
            preloadFileSize = 1000,  -- Adjust based on your machine's capability
        },
        telemetry = {
            enable = false,
        },
        hint = {
            enable = true,           -- Enable inlay hints (if you want them)
            arrayIndex = "Disable",  -- "Enable", "Auto", "Disable"
            await = true,
            paramName = "Disable",   -- "All", "Literal", "Disable"
            paramType = false,
            semicolon = "Disable",   // "All", "SameLine", "Disable"
            setType = true,
        },
        completion = {
            callSnippet = "Replace",  // "Replace" or "Both" or "Disable"
            keywordSnippet = "Replace",  // "Replace" or "Both" or "Disable"
        },
    },
}
