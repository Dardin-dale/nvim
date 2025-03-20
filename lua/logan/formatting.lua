local status_ok, conform = pcall(require, "conform")
if not status_ok then
  return
end

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Add formatters for your languages
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    javascriptreact = { { "prettierd", "prettier" } },
    typescriptreact = { { "prettierd", "prettier" } },
    json = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
    css = { { "prettierd", "prettier" } },
    python = { "black" },
    rust = { "rustfmt" },
    java = { "google-java-format" },
    dart = { "dart_format" }
    -- Add more as needed
  },
  format_on_save = {
    -- Set to false to disable format on save
    enabled = false,
    -- You can specify timeouts or other conditions
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- Create command Format
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  conform.format({ async = true, lsp_fallback = true, range = range })
end, { range = true })
