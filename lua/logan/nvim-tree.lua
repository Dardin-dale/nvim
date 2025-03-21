-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- vim.g.nvim_tree_icons = {
--   default = "",
--   symlink = "",
--   git = {
--     unstaged = "",
--     staged = "S",
--     unmerged = "",
--     renamed = "➜",
--     deleted = "",
--     untracked = "U",
--     ignored = "◌",
--   },
--   folder = {
--     default = "",
--     open = "",
--     empty = "",
--     empty_open = "",
--     symlink = "",
--   },
-- }
--
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	--[[ open_on_setup = false, ]]
	--[[ ignore_ft_on_setup = { ]]
	--[[     "startify", ]]
	--[[     "dashboard", ]]
	--[[     "alpha", ]]
	--[[ }, ]]
	-- auto_close = true,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	respect_buf_cwd = true,
	-- update_to_buf_dir = {
	--   enable = true,
	--   auto_open = true,
	-- },
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	filters = {
		dotfiles = false,
		-- custom = {"^.env$"}
	},
	view = {
		width = 30,
		hide_root_folder = false,
		side = "left",
		-- auto_resize = true,
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
			},
		},
		number = false,
		relativenumber = false,
	},
	renderer = {
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "U",
					ignored = "◌",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
	},
	-- quit_on_open = 0,
	-- git_hl = 1,
	-- -- disable_window_picker = 0,
	-- root_folder_modifier = ":t",
	-- show_icons = {
	--   git = 1,
	--   folders = 1,
	--   files = 1,
	--   folder_arrows = 1,
	--   tree_width = 30,
	-- },
})

local function open_nvim_tree(data)
	local IGNORED_FT = {
		"alpha",
	}

	-- buffer is a real file on the disk
	local real_file = vim.fn.filereadable(data.file) == 1

	-- buffer is a [No Name]
	local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

	-- &ft
	local filetype = vim.bo[data.buf].ft

	-- only files please
	if not real_file and not no_name then
		return
	end

	-- skip ignored filetypes
	if vim.tbl_contains(IGNORED_FT, filetype) then
		return
	end

	-- open the tree but don't focus it
	require("nvim-tree.api").tree.toggle({ focus = false })
end
