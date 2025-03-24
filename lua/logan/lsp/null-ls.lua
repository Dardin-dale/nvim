local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		-- JavaScript/TypeScript
		formatting.prettier.with({ extra_args = { "--tab-width", "4" } }),
		diagnostics.eslint,
		code_actions.eslint,

		-- Lua
		formatting.stylua,

		-- Python
		diagnostics.flake8,
		formatting.black,

		-- Rust
		formatting.rustfmt,

		-- Go
		formatting.gofmt,

		-- LaTeX
		diagnostics.chktex,

		-- Shell
		diagnostics.shellcheck,

		-- YAML
		diagnostics.yamllint,

		-- XML
		formatting.xmllint,

		-- TOML
		formatting.taplo,
	},
})
