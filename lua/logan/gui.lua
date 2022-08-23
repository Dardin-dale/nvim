local font = "FiraCode NF"

local status_ok, _ = pcall(vim.cmd, "guifont " .. font)
if not status_ok then
    vim.notify("font " .. font .. " not found!")
    return
end

