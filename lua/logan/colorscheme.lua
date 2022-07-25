
local colorscheme = "lunar"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

-- vim.g.transparent_enabled = true
-- vim.g.tokyonight_transparent = vim.g.transparent_enabled
