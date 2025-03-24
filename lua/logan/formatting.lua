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
			prepend_args = { "--aosp" },
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
	},
	format_on_save = {
		enabled = false, -- Disabled by default
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

-- Define a command to manually format
vim.api.nvim_create_user_command("Format", function()
	conform.format({ async = true, lsp_fallback = true })
end, {})
