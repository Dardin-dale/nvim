local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local status_ok, dash = pcall(require, "alpha.themes.dashboard")
if not status_ok then
	return
end

dash.section.header.val = {
	"                                                     ",
	"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
	"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
	"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
	"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
	"                                                     ",
}

dash.section.buttons.val = {
		dash.button("e", "  New file", "<cmd>ene <CR>"),
		dash.button("SPC f f", "  Find file"),
		dash.button("SPC f l", "  Recently opened files"),
		dash.button("SPC f r", "  Frecency/MRU"),
		dash.button("SPC f g", "  Find word"),
		dash.button("SPC f m", "  Jump to bookmarks"),
		dash.button("SPC f s", "  Pick Session"),
		dash.button("SPC s l", "  Open last session", ":SessionManager load_last_session<cr>"),
        --[[ dash.button( "s", "  > Settings" , ":e %VIMRC% <CR>"), ]]
        dash.button( "q", "  Quit NVIM" , ":qa<CR>"),
}

alpha.setup(dash.config)
