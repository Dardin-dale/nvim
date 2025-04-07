local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set

-- Space as Leader key
--[[ keymap("", "<Space>", "<Nop>", opts) ]]
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
--[[ keymap("n", "<leader>fs", ":lua require('persistence').select()<CR>", opts) ]]
--[[ keymap("n", "<leader>sl", ":lua require('persistence').load({last = true})<CR>", opts) ]]
--[[ keymap("n", "<leader>ns", ":lua require('persistence').save()<CR>", opts) ]]
--[[ keymap("n", "<leader>ts", ":lua require('persistence').stop()<CR>", opts) ]]

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

wk.add({
	-- Window movement
	{ "<C-h>", desc = "Move left" },
	{ "<C-j>", desc = "Move down" },
	{ "<C-k>", desc = "Move up" },
	{ "<C-l>", desc = "Move right" },

	-- Non-leader keys
	{ "<C-p>", desc = "Find files" },
	{ "gD", desc = "LSP: Go to declaration" },
	{ "gd", desc = "LSP: Go to definition" },
	{ "gi", desc = "LSP: Go to implementation" },
	{ "gr", desc = "LSP: Find references" },
	{ "gl", desc = "LSP: Show diagnostic details" },

	-- Leader prefixed commands
	{ "<leader>", group = "Leader" },

	-- Clipboard
	{ "<leader>p", '"+p', desc = "Paste from clipboard" },
	{ "<leader>yy", '"+yy', desc = "Line to clipboard" },
	{ "<leader>y$", '"+y$', desc = "To EOL to clipboard" },

	-- Telescope
	{ "<leader>f", group = "Find/Files" },
	{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find files" },
	{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Live grep" },
	{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "Buffers" },
	{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc = "Help tags" },
	{ "<leader>fl", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", desc = "Recent files" },
	{ "<leader>fr", "<cmd>lua require('telescope').extensions.frecency.frecency()<CR>", desc = "Frecency" },
	{ "<leader>fs", "<cmd>lua require('persistence').select()<CR>", desc = "Find/load sessions" },

	-- Harpoon/Marks
	{ "<leader>m", group = "Marks" },
	{ "<leader>fm", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Marks menu" },
	{ "<leader>ma", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add mark" },
	{ "<leader>mn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Next mark" },
	{ "<leader>mb", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Previous mark" },
	{ "<leader>m1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Mark 1" },
	{ "<leader>m2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Mark 2" },
	{ "<leader>m3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Mark 3" },
	{ "<leader>m4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Mark 4" },
	{ "<leader>m5", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", desc = "Mark 5" },
	{ "<leader>m6", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", desc = "Mark 6" },
	{ "<leader>m7", "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", desc = "Mark 7" },
	{ "<leader>m8", "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", desc = "Mark 8" },
	{ "<leader>m9", "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", desc = "Mark 9" },
	{ "<leader>m0", "<cmd>lua require('harpoon.ui').nav_file(10)<cr>", desc = "Mark 10" },

	-- Sessions
	{ "<leader>s", group = "Sessions" },
	{ "<leader>sl", "<cmd>lua require('persistence').load({last = true})<CR>", desc = "Load last session" },
	{ "<leader>ss", "<cmd>lua require('persistence').save()<CR>", desc = "Save session" },
	{ "<leader>sx", "<cmd>lua require('persistence').stop()<CR>", desc = "Terminate session tracking" },

	-- Window resize
	{ "<leader>r", group = "Resize" },
	{ "<leader>rp", "<cmd>resize 120<CR>", desc = "Resize to 120 height" },
	{ "<leader>+", "<cmd>vertical resize +5<CR>", desc = "Increase width" },
	{ "<leader>-", "<cmd>vertical resize -5<CR>", desc = "Decrease width" },

	-- Buffers
	{ "<leader>b", group = "Buffers" },
	{ "<leader>bd", "<cmd>Bdelete!<cr>", desc = "Delete buffer" },
	{ "<leader>w", "<cmd>w!<cr>", desc = "Write buffer" },

	-- NvimTree
	{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle explorer" },

	-- Formatting
	{
		"<leader>f",
		"<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>",
		desc = "Format file",
	},

	-- Quickfix
	{ "<leader>q", group = "Quickfix" },
	{ "<leader>qn", "<cmd>cnext<CR>", desc = "Next quickfix" },
	{ "<leader>qp", "<cmd>cprev<CR>", desc = "Previous quickfix" },
	{ "<leader>qo", "<cmd>copen<CR>", desc = "Open quickfix" },
	{ "<leader>qc", "<cmd>cclose<CR>", desc = "Close quickfix" },

	-- Location list
	{ "<leader>l", group = "Location/LSP" },
	{ "<leader>ln", "<cmd>lnext<CR>", desc = "Next location" },
	{ "<leader>lp", "<cmd>lprev<CR>", desc = "Previous location" },
	{ "<leader>lo", "<cmd>lopen<CR>", desc = "Open location list" },
	{ "<leader>lc", "<cmd>lclose<CR>", desc = "Close location list" },
	{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "LSP: Rename symbol" },
	{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "LSP: Code action" },
	{ "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "LSP: Diagnostics to loclist" },

	-- Debugging
	{ "<leader>d", group = "Debug" },
	{ "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle breakpoint" },
	{ "<leader>dc", "<cmd>lua require('dap').continue()<CR>", desc = "Continue" },
	{ "<leader>di", "<cmd>lua require('dap').step_into()<CR>", desc = "Step into" },
	{ "<leader>do", "<cmd>lua require('dap').step_over()<CR>", desc = "Step over" },
	{ "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>", desc = "REPL" },
	{
		"<leader>dB",
		"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
		desc = "Conditional breakpoint",
	},
	{
		"<leader>dl",
		"<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
		desc = "Logpoint",
	},

	-- Git
	{ "<leader>g", group = "Git" },
	{ "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "LazyGit" },
	{ "<leader>git", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "LazyGit" },

	-- Git Conflict (from your other config)
	{ "co", "<cmd>GitConflictChooseOurs<CR>", desc = "Git Conflict: Choose Ours" },
	{ "ct", "<cmd>GitConflictChooseTheirs<CR>", desc = "Git Conflict: Choose Theirs" },
	{ "cb", "<cmd>GitConflictChooseBoth<CR>", desc = "Git Conflict: Choose Both" },
	{ "c0", "<cmd>GitConflictChooseNone<CR>", desc = "Git Conflict: Choose None" },
	{ "[x", "<cmd>GitConflictPrevConflict<CR>", desc = "Git Conflict: Previous Conflict" },
	{ "]x", "<cmd>GitConflictNextConflict<CR>", desc = "Git Conflict: Next Conflict" },

	-- Node REPL
	{ "<leader>node", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node REPL" },

	-- Zen Mode
	{ "<leader>z", group = "Zen" },
	{ "<leader>zn", "<cmd>ZenMode<CR>", desc = "Zen Mode" },

	-- LSP mappings from your other config
	{ "<S-K>", desc = "Show hover" },
	{ "gk", desc = "Show signature help" },
	{ "[d", desc = "Previous diagnostic" },
	{ "]d", desc = "Next diagnostic" },
})
