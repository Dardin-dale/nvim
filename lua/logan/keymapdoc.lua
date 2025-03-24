local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

vim.o.timeout = true
vim.o.timeoutlen = 300

which_key.setup({
	-- Core options
	icons = {
		group = "+",
	},
	-- Window configuration
	win = {
		border = "rounded",
		padding = { 2, 2 }, -- [top/bottom, right/left]
		winblend = 0,
	},
	-- Filter function
	filter = function(mapping)
		-- Return true to include the mapping, false to exclude it
		return mapping.desc and mapping.desc ~= ""
	end,
	-- Key navigation
	keys = {
		scroll_down = "<c-d>",
		scroll_up = "<c-u>",
	},
	-- Key formatting
	replace = {
		key = {
			{ "<Space>", "SPC" },
			{ "<CR>", "RET" },
			{ "<Tab>", "TAB" },
		},
	},
	-- Proper triggers format
	triggers = {
		{ "<auto>", mode = "nxso" }, -- Auto-trigger in these modes
	},
	-- Disable warnings
	notify = false,
})
