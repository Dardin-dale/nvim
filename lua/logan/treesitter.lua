local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

-- Use plenary paths for more reliable path handling
local plenary_status_ok, path = pcall(require, "plenary.path")
if not plenary_status_ok then
	-- Continue even if plenary is not available, but with reduced functionality
	vim.notify("Plenary not found, some treesitter functionality may be limited", vim.log.levels.WARN)
end

-- Skip ts_context_commentstring module in treesitter
-- as recommended by the plugin author
vim.g.skip_ts_context_commentstring_module = true

-- Configure ts_context_commentstring directly
local ts_comment_status_ok, ts_context = pcall(require, "ts_context_commentstring")
if ts_comment_status_ok then
	ts_context.setup {
		enable_autocmd = false,
	}
end

-- Configure Treesitter
require("nvim-treesitter.install").prefer_git = true -- Use git for more reliable installation
require("nvim-treesitter.install").compilers = { "gcc", "clang", "cl", "zig" } -- Add more compilers for better compatibility

configs.setup({
	-- Only install parsers for languages you actually use
	ensure_installed = {
		-- Core languages
		"lua",
		"vim",
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
		"json",
		"rust",
		"java",
		"dart",
		"python",
		"bash",
		"c",
		"cpp",
		"go",
		"markdown",
		"yaml",
		"toml",
		"xml",
		"regex",
	},
	sync_install = false,
	auto_install = true, -- Auto-install missing parsers when entering buffer
	ignore_install = { "" },
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = false, -- Set to false for better performance
	},
	indent = { 
		enable = true, 
		disable = { "yaml" } 
	},
	-- Remove the deprecated context_commentstring module configuration
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
})

-- Load and configure rainbow delimiters correctly
local rainbow_delimiters = require("rainbow-delimiters")

-- Set up rainbow delimiters configuration
vim.g.rainbow_delimiters = {
	strategy = {
		[""] = rainbow_delimiters.strategy["global"],
		commonlisp = rainbow_delimiters.strategy["local"],
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
	highlight = {
		"RainbowDelimiterRed",
		"RainbowDelimiterYellow",
		"RainbowDelimiterBlue",
		"RainbowDelimiterOrange",
		"RainbowDelimiterGreen",
		"RainbowDelimiterViolet",
		"RainbowDelimiterCyan",
	},
	-- Remove blacklist to ensure all languages work correctly
	-- blacklist = { "c", "cpp" },
}

-- Set up fallback rainbow colors if specific highlights aren't defined
-- This ensures consistent appearance across different colorschemes
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.cmd([[
			highlight default RainbowDelimiterRed guifg=#E06C75
			highlight default RainbowDelimiterYellow guifg=#E5C07B
			highlight default RainbowDelimiterBlue guifg=#61AFEF
			highlight default RainbowDelimiterOrange guifg=#D19A66
			highlight default RainbowDelimiterGreen guifg=#98C379
			highlight default RainbowDelimiterViolet guifg=#C678DD
			highlight default RainbowDelimiterCyan guifg=#56B6C2
		]])
	end,
})
