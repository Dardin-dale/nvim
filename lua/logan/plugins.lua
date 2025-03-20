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
    -- My plugins here
    -- "wbthomason/packer.nvim", -- Have packer manage itself
    "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
    "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
    "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        "NTBBloodbath/galaxyline.nvim",
        -- your statusline
        config = function()
            require("galaxyline.themes.eviline")
        end,
    },
    "nvim-tree/nvim-web-devicons",
    {
        'nvim-tree/nvim-tree.lua',
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    },
    "numToStr/Comment.nvim", -- Easily comment stuff
    { -- Formatting
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
    },
    --[[ "folke/twilight.nvim") -- focus in zen mode ]]
    "folke/zen-mode.nvim",
    { "akinsho/bufferline.nvim", version = "*"},
    "moll/vim-bbye",
    {"lukas-reineke/indent-blankline.nvim", main = "ibl", opts={}}, -- vertical tablines
    "xiyaowong/nvim-transparent", -- transparent background

    'goolord/alpha-nvim', -- startup nvim home page

    'Shatur/neovim-session-manager', --Sessions
    --[[ 'Pocco81/auto-save.nvim') ]] -- annoying af
    'folke/which-key.nvim',

    -- Terminal
    { "akinsho/toggleterm.nvim", version = "*"},

    -- cmp plugins
    { "hrsh7th/nvim-cmp" }, -- The completion plugin
    { "hrsh7th/cmp-buffer" }, -- buffer completions
    { "hrsh7th/cmp-path" }, -- path completions
    { "hrsh7th/cmp-cmdline" }, -- cmdline completions
    { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp" }, -- lsp autocompletions
    { "hrsh7th/cmp-nvim-lua" },
    { 'saecki/crates.nvim' },

    -- snippets
    { "L3MON4D3/LuaSnip" }, --snippet engine
    { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
    "heavenshell/vim-jsdoc",

    -- LSP
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    "jose-elias-alvarez/null-ls.nvim",
    'mfussenegger/nvim-jdtls',

    --Debug
    'mfussenegger/nvim-dap',
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
    'nvim-telescope/telescope-dap.nvim',
    'theHamsta/nvim-dap-virtual-text',


    --Telescope
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    { "kkharji/sqlite.lua" }, -- required for frecency
    "nvim-telescope/telescope-frecency.nvim",
    { 'nvim-telescope/telescope-ui-select.nvim' },

    "ThePrimeagen/harpoon",

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        --run = ":TSUpdate",
        --enabled = false,
    },
    --[[ "p00f/nvim-ts-rainbow", ]]
    'HiPhish/rainbow-delimiters.nvim',
    "nvim-treesitter/playground",
    "JoosepAlviste/nvim-ts-context-commentstring",

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        --tag = 'release' -- To the latest release
    },
    { "akinsho/git-conflict.nvim" },
    -- ColorSchemes --
    "lunarvim/colorschemes",
    "folke/tokyonight.nvim",
    { "ellisonleao/gruvbox.nvim" },
    { "catppuccin/nvim", as = "catppuccin" },
}

local opts = {}

require("lazy").setup(plugins, opts)
