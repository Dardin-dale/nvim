
local status_ok, zen = pcall(require, "zen-mode")--"true-zen")
if not status_ok then
  return
end


zen.setup()
