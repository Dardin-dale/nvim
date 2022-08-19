
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    return
end


local status_ok, dash = pcall(require, "alpha.themes.dashboard")
if not status_ok then
    return
end


alpha.setup(dash.config)
