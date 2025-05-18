-- In lua_ls.lua file:
return {
    Lua = {
        runtime = {
            version = 'LuaJIT',
        },
        diagnostics = {
            globals = {
                'vim',
                'use',
                'require',
            },
        },
        workspace = {
            -- Correctly format as an array, not a dictionary
            library = {
                vim.fn.expand('$VIMRUNTIME/lua'),
                vim.fn.expand('$VIMRUNTIME/lua/vim/lsp'),
                vim.fn.stdpath('config') .. '/lua',
            },
            checkThirdParty = false,
        },
        telemetry = {
            enable = false,
        },
    }
}
