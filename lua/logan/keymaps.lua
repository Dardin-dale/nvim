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

keymap("n", "<leader>e", ":Lex 30<cr>", opts)

--Window resize
keymap("n", "<leader>rp", ":resize 120<CR>", opts)
keymap("n", "<leader>+", ":vertical resize -5<CR>", opts)
keymap("n", "<leader>-", ":vertical resize +5<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)


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
