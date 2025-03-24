local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- Space as Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.localleader = " "

-- Initialize which-key
local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then
	return
end

-- These mappings won't be tracked by which-key but are still useful
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Quick save with Ctrl-S
keymap("n", "<C-s>", ":w!<cr>", opts)

-- Clear search
keymap("n", "<C-c>", ":noh<CR>", opts)

-- Insert mode escape
keymap("i", "<C-c>", "<esc>", opts)

-- Visual mode paste without yanking replaced text
keymap("v", "p", '"_dp', opts)
keymap("x", "p", '"_dp', opts)

-- Copy to clipboard in visual mode
keymap("v", "<leader>y", '"+y', opts)

-- Move text in visual mode
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("x", "J", ":m '>+1<CR>gv-gv", opts)
keymap("x", "K", ":m '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- Terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrow keys
keymap("n", "<C-Up>", ":resize -5<CR>", opts)
keymap("n", "<C-Down>", ":resize +5<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -5<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +5<CR>", opts)

-- Function keys for debugging
keymap("n", "<F4>", ":lua require('dap').continue()<CR>", opts)
keymap("n", "<F2>", ":lua require('dap').step_over()<CR>", opts)
keymap("n", "<F1>", ":lua require('dap').step_into()<CR>", opts)
keymap("n", "<F3>", ":lua require('dap').step_out()<CR>", opts)

-- Clipboard operations
keymap("n", "<leader>p", '"+p', opts)
keymap("n", "<leader>yy", '"+yy', opts)
keymap("n", "<leader>y$", '"+y$', opts)

-- Telescope
keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<C-p>", ":lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<cr>", opts)
keymap("n", "<leader>fl", ":lua require('telescope.builtin').oldfiles()<cr>", opts)
keymap("n", "<leader>fr", ":lua require('telescope').extensions.frecency.frecency()<CR>", opts)

-- Session management
keymap("n", "<leader>fs", ":SessionManager load_session<cr>", opts)
keymap("n", "<leader>ns", ":SessionManager save_current_session<cr>", opts)
keymap("n", "<leader>cs", ":SessionManager! load_current_dir_session<cr>", opts)
keymap("n", "<leader>dds", ":SessionManager delete_session<cr>", opts)

-- Harpoon/Marks
keymap("n", "<leader>fm", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
keymap("n", "<leader>ma", ":lua require('harpoon.mark').add_file()<cr>", opts)
keymap("n", "<leader>mn", ":lua require('harpoon.ui').nav_next()<cr>", opts)
keymap("n", "<leader>mb", ":lua require('harpoon.ui').nav_prev()<cr>", opts)
keymap("n", "<leader>m1", ":lua require('harpoon.ui').nav_file(1)<cr>", opts)
keymap("n", "<leader>m2", ":lua require('harpoon.ui').nav_file(2)<cr>", opts)
keymap("n", "<leader>m3", ":lua require('harpoon.ui').nav_file(3)<cr>", opts)
keymap("n", "<leader>m4", ":lua require('harpoon.ui').nav_file(4)<cr>", opts)
keymap("n", "<leader>m5", ":lua require('harpoon.ui').nav_file(5)<cr>", opts)
keymap("n", "<leader>m6", ":lua require('harpoon.ui').nav_file(6)<cr>", opts)
keymap("n", "<leader>m7", ":lua require('harpoon.ui').nav_file(7)<cr>", opts)
keymap("n", "<leader>m8", ":lua require('harpoon.ui').nav_file(8)<cr>", opts)
keymap("n", "<leader>m9", ":lua require('harpoon.ui').nav_file(9)<cr>", opts)
keymap("n", "<leader>m0", ":lua require('harpoon.ui').nav_file(10)<cr>", opts)

-- Window resize
keymap("n", "<leader>rp", ":resize 120<CR>", opts)
keymap("n", "<leader>+", ":vertical resize +5<CR>", opts)
keymap("n", "<leader>-", ":vertical resize -5<CR>", opts)

-- Buffers
keymap("n", "<leader>bd", ":Bdelete!<cr>", opts)
keymap("n", "<leader>w", ":w!<cr>", opts)

-- NvimTree toggle - with the fixed <cr>
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Formatting
keymap("n", "<leader>f", ":lua require('conform').format({ async = true, lsp_fallback = true })<CR>", opts)

-- Quickfix navigation
keymap("n", "<leader>qn", ":cnext<CR>", opts)
keymap("n", "<leader>qp", ":cprev<CR>", opts)
keymap("n", "<leader>qo", ":copen<CR>", opts)
keymap("n", "<leader>qc", ":cclose<CR>", opts)

-- Location list navigation
keymap("n", "<leader>ln", ":lnext<CR>", opts)
keymap("n", "<leader>lp", ":lprev<CR>", opts)
keymap("n", "<leader>lo", ":lopen<CR>", opts)
keymap("n", "<leader>lc", ":lclose<CR>", opts)

-- Debugging
keymap("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>dc", ":lua require('dap').continue()<CR>", opts)
keymap("n", "<leader>di", ":lua require('dap').step_into()<CR>", opts)
keymap("n", "<leader>do", ":lua require('dap').step_over()<CR>", opts)
keymap("n", "<leader>dr", ":lua require('dap').repl.open()<CR>", opts)
keymap("n", "<leader>dB", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<leader>dl", ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)

-- Git
keymap("n", "<leader>gg", ":lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<leader>git", ":lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Node REPL
keymap("n", "<leader>node", ":lua _NODE_TOGGLE()<cr>", opts)

-- Zen Mode
keymap("n", "<leader>zn", ":ZenMode<CR>", opts)

-- DOCUMENTATION
wk.register({
    ["<C-h>"] = "Move left",
    ["<C-j>"] = "Move down",
    ["<C-k>"] = "Move up", 
    ["<C-l>"] = "Move right",
})

-- Clipboard
wk.register({
    p = "Paste from clipboard",
    yy = "Line to clipboard",
    ["y$"] = "To EOL to clipboard",
}, { prefix = "<leader>" })

-- Telescope
wk.register({
    ff = "Find files",
    fg = "Live grep",
    fb = "Buffers",
    fh = "Help tags",
    fl = "Recent files",
    fr = "Frecency",
    fs = "Find/load sessions",
}, { prefix = "<leader>" })

-- Document other non-leader keys
wk.register({
    ["<C-p>"] = "Find files",
    ["gD"] = "LSP: Go to declaration",
    ["gd"] = "LSP: Go to definition",
    ["gi"] = "LSP: Go to implementation",
    ["gr"] = "LSP: Find references",
    ["gl"] = "LSP: Show diagnostic details",
})

-- Harpoon
wk.register({
    fm = "Marks menu",
    ma = "Add mark",
    mn = "Next mark",
    mb = "Previous mark",
    m1 = "Mark 1",
    m2 = "Mark 2",
    m3 = "Mark 3",
    m4 = "Mark 4",
    m5 = "Mark 5",
    m6 = "Mark 6",
    m7 = "Mark 7",
    m8 = "Mark 8",
    m9 = "Mark 9",
    m0 = "Mark 10",
}, { prefix = "<leader>" })

-- Sessions
wk.register({
    ns = "Save session",
    cs = "Load current dir session",
    dds = "Delete session",
}, { prefix = "<leader>" })

-- Window resize
wk.register({
    rp = "Resize to 120 height",
    ["+"] = "Increase width",
    ["-"] = "Decrease width",
}, { prefix = "<leader>" })

-- Buffers
wk.register({
    bd = "Delete buffer",
    w = "Write buffer",
}, { prefix = "<leader>" })

-- NvimTree
wk.register({
    e = "Toggle explorer",
}, { prefix = "<leader>" })

-- Formatting
wk.register({
    f = "Format file",
}, { prefix = "<leader>" })

-- Quickfix
wk.register({
    qn = "Next quickfix",
    qp = "Previous quickfix",
    qo = "Open quickfix",
    qc = "Close quickfix",
}, { prefix = "<leader>" })

-- Location list
wk.register({
    ln = "Next location",
    lp = "Previous location",
    lo = "Open location list",
    lc = "Close location list",
    lr = "LSP: Rename symbol",
    la = "LSP: Code action",
    lq = "LSP: Diagnostics to loclist",
}, { prefix = "<leader>" })

-- Debugging
wk.register({
    ["db"] = "Toggle breakpoint",
    ["dc"] = "Continue",
    ["di"] = "Step into",
    -- Use this syntax for 'do' since it's a Lua keyword
    ["do"] = "Step over",
    ["dr"] = "REPL",
    ["dB"] = "Conditional breakpoint",
    ["dl"] = "Logpoint",
}, { prefix = "<leader>" })

-- Git
wk.register({
    gg = "LazyGit",
    git = "LazyGit",
}, { prefix = "<leader>" })

-- Node REPL
wk.register({
    node = "Node REPL",
}, { prefix = "<leader>" })

-- Zen Mode
wk.register({
    zn = "Zen Mode",
}, { prefix = "<leader>" })
