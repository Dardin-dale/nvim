local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

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
--Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- keymap("n", "<leader>e", ":Lex 30<cr>", opts)

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
keymap("n", "<leader>w", ":w<cr>", opts) -- write buffer
keymap("n", "<C-s>", ":w<cr>", opts) -- write buffer

-- NVIMTree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Formatting/null_ls
keymap("n", "<leader>f", ":Format<cr>", opts)

-- Insert --
keymap("i", "<C-c>", "<esc>", opts)

-- Visual --

-- move text
keymap("v", "J", ":move .+1<CR>==", opts)
keymap("v", "K", ":move .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dp', opts)

-- Visual Block --
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
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
--[[ keymap("n", "<leader>zn", ":TZNarrow<CR>", opts) ]]
--[[ keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", opts) ]]
--[[ keymap("n", "<leader>zf", ":TZFocus<CR>", opts) ]]
--[[ keymap("n", "<leader>zm", ":TZFocus<CR>", opts) ]]
--[[ keymap("n", "<leader>za", ":TZAtaraxis<CR>", opts) ]]
keymap("n", "<leader>zn", ":ZenMode<CR>", opts)
