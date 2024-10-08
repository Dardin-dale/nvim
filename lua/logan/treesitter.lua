local configs = require("nvim-treesitter.configs")
require 'nvim-treesitter.install'.prefer_git = false
require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

configs.setup({
	ensure_installed = "all",
	sync_install = false,
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	autotag = {
		enable = true,
	},
	--[[ context_commentstring = { ]]
	--[[ 	enable = true, ]]
	--[[ }, ]]
})

local rainbow_delimiters = require('rainbow-delimiters')
vim.g.rainbow_delimiters = {
    strategy = {
            [''] = rainbow_delimiters.strategy['global'],
            commonlisp = rainbow_delimiters.strategy['local'],
        },
        query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
        },
        highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
        },
        blacklist = {'c', 'cpp'},
}
