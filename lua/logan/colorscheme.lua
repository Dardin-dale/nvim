
local colorscheme = "tokyonight"---"lunar"

-- vim.g.tokyonight_transparent = true;
vim.g.tokyonight_style = true;
-- vim.g.tokyonight_transparent_sidebar = true;


local status_ok, scheme = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

-- vim.g.transparent_enabled = true
-- vim.g.tokyonight_transparent = vim.g.transparent_enabled

