local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use("lewis6991/impatient.nvim")
    use("wbthomason/packer.nvim") -- Have packer manage itself
    use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
    use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
    use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })
    use("kyazdani42/nvim-web-devicons") -- optional, for file icons
    use({
        "NTBBloodbath/galaxyline.nvim",
        -- your statusline
        config = function()
            require("galaxyline.themes.eviline")
        end,
    })
    use({
        "kyazdani42/nvim-tree.lua",
        tag = "nightly", -- optional, updated every week. (see issue #1193)
    })
    use("numToStr/Comment.nvim") -- Easily comment stuff
    use("folke/twilight.nvim") -- focus in zen mode
    --use("Pocco81/true-zen.nvim") --zen mode
    use("folke/zen-mode.nvim")
    -- using packer.nvim
    use({ "akinsho/bufferline.nvim", tag = "v2.*" })
    use("moll/vim-bbye")
    use("lukas-reineke/indent-blankline.nvim") -- vertical tablines
    use("xiyaowong/nvim-transparent") -- transparent background

    use('goolord/alpha-nvim') -- startup nvim home page

    use('Shatur/neovim-session-manager') --Sessions
    --[[ use('Pocco81/auto-save.nvim') ]]

    -- Terminal
    use({ "akinsho/toggleterm.nvim", tag = "v2.*" })

    -- cmp plugins
    use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
    use({ "hrsh7th/cmp-buffer" }) -- buffer completions
    use({ "hrsh7th/cmp-path" }) -- path completions
    use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
    use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
    use({ "hrsh7th/cmp-nvim-lsp" }) -- lsp autocompletions
    use({ "hrsh7th/cmp-nvim-lua" })
    use({ 'saecki/crates.nvim' })

    -- snippets
    use({ "L3MON4D3/LuaSnip" }) --snippet engine
    use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use
    use("heavenshell/vim-jsdoc")

    -- LSP
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    use("jose-elias-alvarez/null-ls.nvim")
    use 'mfussenegger/nvim-jdtls'

    --Debug
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use 'nvim-telescope/telescope-dap.nvim'
    use 'theHamsta/nvim-dap-virtual-text'


    --Telescope
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-media-files.nvim")
    use { "kkharji/sqlite.lua" } -- required for frecency
    use("nvim-telescope/telescope-frecency.nvim")
    use { 'nvim-telescope/telescope-ui-select.nvim' }

    use("ThePrimeagen/harpoon")

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use("p00f/nvim-ts-rainbow")
    use("nvim-treesitter/playground")
    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- Git
    use({
        "lewis6991/gitsigns.nvim",
        --tag = 'release' -- To use the latest release
    })
    use({ "akinsho/git-conflict.nvim" })
    -- ColorSchemes --
    use("lunarvim/colorschemes")
    use("folke/tokyonight.nvim")
    use({ "ellisonleao/gruvbox.nvim" })
    use { "catppuccin/nvim", as = "catppuccin" }
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
