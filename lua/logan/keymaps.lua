local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local wk = require('which-key')

--shorten function name
local keymap = vim.api.nvim_set_keymap

-- Space as Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.localleader = " "

-- Modes
-- normal = n
-- insert = i
-- visual = v
-- visual_block = x
-- term = t
-- command = c

--Normal--
--Window/Pane navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
wk.register({
    ["<C-h>"] = {"<C-w>h", "Move one pane left"},
    ["<C-j>"] = {"<C-w>j", "Move one pane down"},
    ["<C-k>"] = {"<C-w>k", "Move one pane up"},
    ["<C-l>"] = {"<C-w>l", "Move one pane right"},
})

-- keymap("n", "<leader>e", ":Lex 30<cr>", opts)
-- COPY/Paste from clipboard
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>p", '"+p', opts)
keymap("n", "<leader>yy", '"+yy', opts)
keymap("n", "<leader>y$", '"+y$', opts)

--Telescope
keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<C-p>", ":lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<cr>", opts)
keymap("n", "<leader>fl", ":lua require('telescope.builtin').oldfiles()<cr>", opts)
keymap("n", "<leader>fr", ":lua require('telescope').extensions.frecency.frecency()<CR>", opts)

--Marks
keymap("n", "<leader>fm", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
keymap("n", "<leader>ma", ":lua require('harpoon.mark').add_file()<cr>", opts) --vim.api.nvim_buf_get_name(0)
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

--Sessions
keymap("n", "<leader>ns", ":SessionManager save_current_session<cr>", opts)
keymap("n", "<leader>fs", ":SessionManager load_session<cr>", opts)
keymap("n", "<leader>cs", ":SessionManager! load_current_dir_session<cr>", opts)
keymap("n", "<leader>dds", ":SessionManager delete_session<cr>", opts)

--Window resize
keymap("n", "<leader>rp", ":resize 120<CR>", opts)
keymap("n", "<leader>+", ":vertical resize +5<CR>", opts)
keymap("n", "<leader>-", ":vertical resize -5<CR>", opts)
-- Resize with arrows
keymap("n", "<C-Up>", ":resize -5<CR>", opts)
keymap("n", "<C-Down>", ":resize +5<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -5<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +5<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Buffers
keymap("n", "<leader>bd", ":Bdelete!<cr>", opts) -- delete buffer
keymap("n", "<leader>w", ":w!<cr>", opts) -- write buffer
keymap("n", "<C-s>", ":w!<cr>", opts) -- write buffer

-- NVIMTree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Formatting/null_ls
keymap("n", "<leader>f", ":Format<cr>", opts)

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
-- Coments
-- gcc - single line comment
-- gbc - block comment
-- [count]command - comment count lines

-- Insert --
keymap("i", "<C-c>", "<esc>", opts)

-- Visual --
keymap("v", "p", '"_dp', opts)

-- move text
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Visual Block --
keymap("x", "J", ":m '>+1<CR>gv-gv", opts)
keymap("x", "K", ":m '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)
keymap("x", "p", '"_dp', opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Debugging --
keymap('n', "<F4>", ":lua require('dap').continue()<CR>", opts)
keymap('n', "<F2>", ":lua require('dap').step_over()<CR>", opts)
keymap('n', "<F1>", ":lua require('dap').step_into()<CR>", opts)
keymap('n', "<F3>", ":lua require('dap').step_out()<CR>", opts)
keymap('n', "<leader>b", ":lua require('dap').toggle_breakpoint()<CR>", opts)
keymap('n', "<leader>B", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap('n', "<leader>lp", ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
keymap('n', "<leader>dr", ":lua require('dap').repl.open()<CR>", opts)

--GIT--
keymap("n", "<leader>git", ":lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<leader>node", ":lua _NODE_TOGGLE()<cr>", opts)

-- Zen Mode --
keymap("n", "<leader>zn", ":ZenMode<CR>", opts)

