
local status_ok, sessions = pcall(require, "session_manager")
if not status_ok then
	return
end


sessions.setup {
    autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- LastSession, Disabled, CurrentDir
}
