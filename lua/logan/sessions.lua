local status_ok, sessions = pcall(require, "persistence")
if not status_ok then
	return
end

sessions.setup({
	options = { "buffers", "curdir", "tabpages", "winsize" },
	pre_save = function()
		-- Close certain buffers before saving session
		-- Example: NvimTree, fugitive, etc.
		vim.cmd([[silent! tabdo silent! NvimTreeClose]])
	end,
	-- Exclude file types or buffer types that cause problems
	-- when restored between sessions
	exclude = {
		"NvimTree",
		"fugitive",
		"gitcommit",
		"help",
		"qf",
		"netrw",
		"TelescopePrompt",
		"terminal",
		"lazy",
		"mason",
		"lspinfo",
	},
})
