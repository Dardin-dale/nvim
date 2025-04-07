local status_ok, gitconflict = pcall(require, "git-conflict")
if not status_ok then
	return
end

local status_ok1, wk = pcall(require, "which-key")
if not status_ok1 then
	return
end

gitconflict.setup({
	default_mappings = true, -- disable buffer local mapping created by this plugin
	default_commands = true, -- disable commands created by this plugin
	disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
	highlights = { -- They must have background color, otherwise the default color will be used
		incoming = "DiffText",
		current = "DiffAdd",
	},
})

wk.register({
	co = { "<cmd>GitConflictChooseOurs<CR>", "Git Conflict: Choose Ours" },
	ct = { "<cmd>GitConflictChooseTheirs<CR>", "Git Conflict: Choose Theirs" },
	cb = { "<cmd>GitConflictChooseBoth<CR>", "Git Conflict: Choose Both" },
	c0 = { "<cmd>GitConflictChooseNone<CR>", "Git Conflict: Choose None" },
	["[x"] = { "<cmd>GitConflictPrevConflict<CR>", "Git Conflict: Previous Conflict" },
	["]x"] = { "<cmd>GitConflictNextConflict<CR>", "Git Conflict: Next Conflict" },
})
