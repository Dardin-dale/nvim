local status_ok, sessions = pcall(require, "persistance")
if not status_ok then
    return
end

persistance.setup()
