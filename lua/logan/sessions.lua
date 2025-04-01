local status_ok, sessions = pcall(require, "persistance")
if not status_ok then
    return
end

sessions.setup {
    autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
    hooks = {
        after_load = function()
            -- Force LSP restart after session load with a longer timeout
            vim.defer_fn(function()
                -- First restart all LSP servers
                vim.cmd("LspRestart")
                
                -- Then force attachment for all valid buffers
                vim.defer_fn(function()
                    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == "" then
                            -- Try to manually attach LSP servers for this filetype
                            vim.cmd("doautocmd FileType " .. vim.bo[bufnr].filetype)
                        end
                    end
                end, 1000) -- Additional delay to ensure servers have restarted
            end, 3000)
        end
    }
}
