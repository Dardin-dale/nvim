local status_ok, conform = pcall(require, "conform")
if not status_ok then
    vim.notify("conform.nvim not found", vim.log.levels.WARN)
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
        --[[ java = { "google_java_format_file", "don_conditional_newline" }, ]]
        java = { "eclipse_jdtls", "don_conditional_newline" },
        dart = { "dart_format", "dart_sed_indent", "don_conditional_newline" },
        -- Config formats
        yaml = { "prettier" },
        toml = { "taplo" },
        xml = { "xmllint" },
    },
    -- Ensure your other formatters are correctly defined here
    formatters = {
        stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
        },
        --[[ google_java_format_file = { ]]
        --[[     command = "google-java-format", ]]
        --[[     -- --aosp for style, --replace to modify file in-place ]]
        --[[     args = { "--aosp", "--replace", "$FILENAME" }, ]]
        --[[     stdin = false, -- Operates on the file specified in args ]]
        --[[     condition = function() ]]
        --[[         return vim.fn.executable("google-java-format") == 1 ]]
        --[[     end, ]]
        --[[ }, ]]
        prettier = {
            prepend_args = { "--tab-width", "4", "--print-width", "80" },
        },
        prettierd = {
            prepend_args = { "--tab-width", "4", "--print-width", "80" },
        },
        black = {
            prepend_args = { "--line-length", "80", "--skip-string-normalization" },
        },
        rustfmt = {
            prepend_args = { "--tab-spaces", "4" },
        },
        xmllint = {
            args = { "--format", "-" },
            stdin = true,
        },
        taplo = {
            args = { "format", "-" },
            stdin = true,
        },
        dart_format = {
            command = "dart",
            args = { "format", "$FILENAME" },
            stdin = false, -- Ensure it modifies the file
            condition = function()
                return vim.fn.executable("dart") == 1
            end,
        },
        -- Define the sed step, which also needs the file
        dart_sed_indent = {
            command = "sed",
            args = { "-i", "s/^ */&&/", "$FILENAME" },
            stdin = false, -- sed -i requires file access
            condition = function()
                return vim.fn.executable("sed") == 1
            end,
        },
        don_conditional_newline = {
            command = "sed",
            -- sed pattern needs careful escaping in Lua string:
            -- \ becomes \\, ( becomes \\( etc. \n is fine, \1 is fine.
            args = {
                "-i",
                "s/^\\([[:space:]]*\\)}[[:space:]]*else\\b/\\1}\\n\\1else/",
                "$FILENAME",
            },
            stdin = false, -- sed -i operates on the file
            condition = function()
                return vim.fn.executable("sed") == 1
            end,
        },
    },
    default_format_opts = {
        timeout_ms = 3000,
    },
    format_on_save = {
        enabled = false,
        timeout_ms = 3000,
        lsp_fallback = true,
    },
    format_before_save = function(bufnr)
        vim.lsp.diagnostic.hide_all()
        return true
    end,
})

-- Your user commands and keymaps seem correct
vim.api.nvim_create_user_command("Format", function()
    conform.format({ async = true, lsp_fallback = true })
end, {})
vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
    local conf = require("conform").get_config()
    local current_enabled = conf.format_on_save and conf.format_on_save.enabled or false
    local new_enabled = not current_enabled

    conform.setup({
        format_on_save = vim.tbl_deep_extend("force", conf.format_on_save or {}, {
            enabled = new_enabled,
        }),
    })
    vim.notify("Format on save: " .. (new_enabled and "enabled" or "disabled"))
end, {})

vim.keymap.set(
    "n",
    "<leader>tf",
    ":ToggleFormatOnSave<CR>",
    { noremap = true, silent = true, desc = "Toggle format on save" }
)

-- which-key integration seems fine
local wk_status_ok, wk = pcall(require, "which-key")
if wk_status_ok then
    wk.register({
        t = {
            f = { ":ToggleFormatOnSave<CR>", "Toggle format on save" },
        },
    }, { prefix = "<leader>" })
end
