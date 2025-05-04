local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
local plugins = {
    -- Core plugins
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "windwp/nvim-autopairs",

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    -- UI improvements
    "nvim-tree/nvim-web-devicons",
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "nvim-tree/nvim-tree.lua",
        tag = "nightly",
    },
    "numToStr/Comment.nvim",
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
    },
    "folke/zen-mode.nvim",
    { "akinsho/bufferline.nvim", version = "*" },
    "moll/vim-bbye",
    --[[ { ]]
    --[[ 	"lukas-reineke/indent-blankline.nvim", ]]
    --[[ 	main = "ibl", ]]
    --[[ }, ]]
    "xiyaowong/nvim-transparent",
    "goolord/alpha-nvim",
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
    },
    --[[ "Shatur/neovim-session-manager", ]]
    "folke/which-key.nvim",

    -- Terminal
    { "akinsho/toggleterm.nvim", version = "*" },

    -- Completion and snippets
    {
        "hrsh7th/nvim-cmp",
        version = "*",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "saecki/crates.nvim",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "heavenshell/vim-jsdoc",
        },
    },

    -- LSP
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    "mfussenegger/nvim-jdtls",
    "mfussenegger/nvim-lint",

    -- Debug
    "mfussenegger/nvim-dap",
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
    "nvim-telescope/telescope-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",

    -- Telescope
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    { "kkharji/sqlite.lua" },
    "nvim-telescope/telescope-frecency.nvim",
    { "nvim-telescope/telescope-ui-select.nvim" },
    "ThePrimeagen/harpoon",

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
    },
    "HiPhish/rainbow-delimiters.nvim",
    "nvim-treesitter/playground",
    "JoosepAlviste/nvim-ts-context-commentstring",

    -- Git
    "lewis6991/gitsigns.nvim",
    "akinsho/git-conflict.nvim",

    -- Color Schemes
    "lunarvim/colorschemes",
    "folke/tokyonight.nvim",
    { "ellisonleao/gruvbox.nvim" },
    { "catppuccin/nvim",                        as = "catppuccin" },

    -- New plugins for config format support
    { "b0o/schemastore.nvim" }, -- JSON schemas for YAML/JSON
    {
        "tamasfe/taplo",
        ft = { "toml" },
        cmd = { "Taplo" },
        build = function()
            -- Only install if the taplo binary doesn't exist yet
            if vim.fn.executable("taplo") == 0 then
                vim.notify("Installing taplo via cargo...", vim.log.levels.INFO)
                vim.fn.system({ "cargo", "install", "--features", "lsp", "--locked", "taplo-cli" })
            end
        end,
    },
}

local opts = {}

require("lazy").setup(plugins, opts)
