
local colorscheme = "tokyonight" --"catppuccin"--"tokyonight"---"lunar"

-- vim.g.tokyonight_transparent = true;
--[[ vim.g.tokyonight_style = true; ]]
-- vim.g.tokyonight_transparent_sidebar = true;
vim.g.catpuccin_flavour = "mocha"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

-- vim.g.transparent_enabled = true
-- vim.g.tokyonight_transparent = vim.g.transparent_enabled

local status_ok, scheme = pcall(require, colorscheme)
if not status_ok then
    return
end

scheme.setup({
    --[[ dim_inactive = { ]]
    --[[     enabled=true ]]
    --[[ } ]]
})
