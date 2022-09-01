local font = "FiraCode NF"

local status_ok, _ = pcall(vim.cmd, "set guifont=" .. 'FiraCode NF:h10')
if not status_ok then
    vim.notify("font " .. font .. " not found!")
    return
end

vim.opt.guifont = {font, ":h10"}
