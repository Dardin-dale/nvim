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

local function on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- Custom mappings
    vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
    vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
end

nvim_tree.setup({
    on_attach = on_attach,
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = false,
    update_cwd = true,
    respect_buf_cwd = true,
    diagnostics = {
        enable = true,
        --[[ icons = { ]]
        --[[     hint = "", ]]
        --[[     info = "", ]]
        --[[     warning = "", ]]
        --[[     error = "", ]]
        --[[ }, ]]
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
    },
    view = {
        width = 30,
        side = "left",
        number = false,
        relativenumber = false,
    },
    renderer = {
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "U",
                    ignored = "◌",
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
            },
        },
    },
})

-- Import and setup the git-aware rename function
local git_rename_status_ok, git_rename = pcall(require, "logan.nvim-tree-git-rename")
if git_rename_status_ok then
    git_rename.setup_git_rename()
end

--[[ -- Auto-open nvim-tree on startup ]]
--[[ local function open_nvim_tree(data) ]]
--[[     local IGNORED_FT = { ]]
--[[         "alpha", ]]
--[[     } ]]
--[[     -- buffer is a real file on the disk ]]
--[[     local real_file = vim.fn.filereadable(data.file) == 1 ]]
--[[     -- buffer is a [No Name] ]]
--[[     local no_name = data.file == "" and vim.bo[data.buf].buftype == "" ]]
--[[     -- &ft ]]
--[[     local filetype = vim.bo[data.buf].ft ]]
--[[     -- only files please ]]
--[[     if not real_file and not no_name then ]]
--[[         return ]]
--[[     end ]]
--[[     -- skip ignored filetypes ]]
--[[     if vim.tbl_contains(IGNORED_FT, filetype) then ]]
--[[         return ]]
--[[     end ]]
--[[     -- open the tree but don't focus it ]]
--[[     require("nvim-tree.api").tree.toggle({ focus = false }) ]]
--[[ end ]]
--[[]]
--[[ vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree }) ]]
