
local status_ok, sessions = pcall(require, "session_manager")
if not status_ok then
	return
end


sessions.setup{}
