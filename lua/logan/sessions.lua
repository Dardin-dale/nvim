local status_ok, sessions = pcall(require, "session_manager")
if not status_ok then
    return
end


sessions.setup {
    autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
    hooks = {
        after_load = function()
            -- Force LSP restart after session load
            vim.defer_fn(function()
                vim.cmd("LspRestart")
            end, 3000)
        end
    }
}
