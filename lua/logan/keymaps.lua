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
--nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
--nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
--nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
--nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<C-p>", ":lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<cr>", opts)

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

-- NVIMTree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Formatting null_ls
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

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


-- Zen Mode --
keymap("n", "<leader>zn", ":TZNarrow<CR>", opts)
keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", opts)
keymap("n", "<leader>zf", ":TZFocus<CR>", opts)
keymap("n", "<leader>zm", ":TZFocus<CR>", opts)
keymap("n", "<leader>za", ":TZAtaraxis<CR>", opts)
