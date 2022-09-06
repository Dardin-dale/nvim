local font = "FiraCode NF"

local status_ok, _ = pcall(vim.cmd, "set guifont=" .. 'FiraCode NF:h10')
if not status_ok then
    vim.notify("font " .. font .. " not found!")
    return
end

if vim.g.neovide == 1 then
    vim.g.neovide_cursor_vfx_mode = "PixieDust"
    vim.g.neovide_fullscreen = true
end
vim.opt.guifont = {font, ":h10"}
