local configs = require("nvim-treesitter.configs")
require("nvim-treesitter.install").prefer_git = false
require("nvim-treesitter.install").compilers = { "clang", "gcc" }

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
	ignore_install = { "" },
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
	autotag = {
		enable = true,
	},
})

local rainbow_delimiters = require("rainbow-delimiters")
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
	blacklist = { "c", "cpp" },
}
