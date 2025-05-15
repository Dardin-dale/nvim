-- In lua_ls.lua file:
return {
    Lua = {
        diagnostics = {
            globals = { "vim" },
        },
        workspace = {
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
            },
            checkThirdParty = false, -- Disable annoying prompt
        },
        telemetry = {
            enable = false,
        },
    },
}
