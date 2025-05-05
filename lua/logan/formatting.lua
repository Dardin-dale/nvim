local status_ok, conform = pcall(require, "conform")
if not status_ok then
	return
end

conform.setup({
	formatters_by_ft = {
		-- Programming languages
		lua = { "stylua" },
		javascript = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier" },
		typescriptreact = { "prettierd", "prettier" },
		json = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
		css = { "prettierd", "prettier" },
		python = { "black" },
		rust = { "rustfmt" },
		java = { "google-java-format" },
		dart = { "dart_format" },

		-- Config formats
		yaml = { "prettier" },
		toml = { "taplo" },
		xml = { "xmllint" },
	},
	formatters = {
		-- AOSP style (4 spaces) for Java
		google_java_format = {
			args = { "--aosp" },
		},
		-- 4-space indentation for JavaScript/TypeScript/etc.
		prettier = {
			prepend_args = { "--tab-width", "4" },
		},
		prettierd = {
			prepend_args = { "--tab-width", "4" },
		},
		-- XML formatting
		xmllint = {
			args = { "--format", "-" },
		},
		dart_format = {
			args = { "--line-length=100", "--fix" }, -- Default args, modify as needed
		},
	},
	format_on_save = {
		-- You can change this to true if you want automatic formatting
		enabled = false, 
		timeout_ms = 500,
		lsp_fallback = true,
	},
	-- This will run before formatting
	format_before_save = function(bufnr)
		-- Optional: close LSP diagnostics float windows before formatting
		-- to prevent position conflicts
		vim.lsp.diagnostic.hide_all()
		return true -- return true to continue formatting, false to abort
	end,
})

-- Define a command to manually format
vim.api.nvim_create_user_command("Format", function()
	conform.format({ async = true, lsp_fallback = true })
end, {})

-- Keybinding to toggle format-on-save (added functionality)
vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
	local current = conform.get_config().format_on_save.enabled
	conform.setup({ format_on_save = { enabled = not current } })
	vim.notify("Format on save: " .. (not current and "enabled" or "disabled"))
end, {})

-- Add the toggle format keybinding
vim.keymap.set("n", "<leader>tf", ":ToggleFormatOnSave<CR>", { noremap = true, silent = true, desc = "Toggle format on save" })

-- Register with which-key
local wk_status_ok, wk = pcall(require, "which-key")
if wk_status_ok then
	wk.register({
		t = {
			f = { ":ToggleFormatOnSave<CR>", "Toggle format on save" },
		},
	}, { prefix = "<leader>" })
end
