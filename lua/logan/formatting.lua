local status_ok, conform = pcall(require, "conform")
if not status_ok then
    vim.notify("conform.nvim not found", vim.log.levels.WARN)
    return
end

-- Set the initial state. false means formatting is ON by default.
vim.g.disable_autoformat = false

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
        python = { "black" },
        rust = { "rustfmt" },
        css = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
        less = { "prettierd", "prettier" },
        sh = { "shfmt" },
        dart = { "dart_format", "dart_indent_4_spaces", "don_conditional_newline", "don_try_catch_newline" },
        -- Config formats
        yaml = { "prettier" },
        toml = { "taplo" },
        xml = { "xmlformat" },
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
        shfmt = {
            prepend_args = { "-i", "4" },
        },
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
            prepend_args = { "--tab-spaces", "4", "--blanks" },
        },
        xmlformat = {
            args = { "--indent", "4" },
            stdin = true,
        },
        taplo = {
            args = { "format", "-" },
            stdin = true,
        },
        dart_format = {
            command = "dart",
            args = { "format", "--output", "show" },
            stdin = true,
        },
        -- Define the sed step, which also needs the file
        dart_sed_indent = {
            command = "sed",
            args = { "s/^ */&&/" },
            stdin = true, -- sed -i requires file access
        },
        dart_indent_4_spaces = {
            command = "sed",
            -- This script ignores lines in block comments and doubles leading spaces on others.
            -- We also add a rule to ignore /// doc comments.
            args = {
                --[[ "-e", ]]
                --[[ "/^\\s*\\/\\/\\//b", -- Skip '///' doc comments ]]
                "-e",
                "/\\/\\*/,/\\*\\//b", -- Skip '/* ... */' block comments
                "-e",
                "s/^\\( *\\)/\\1\\1/", -- Double leading spaces on all other lines
            },
            stdin = true,
        },
        don_conditional_newline = {
            command = "sed",
            -- sed pattern needs careful escaping in Lua string:
            -- \ becomes \\, ( becomes \\( etc. \n is fine, \1 is fine.
            args = {
                "s/^\\([[:space:]]*\\)}[[:space:]]*else\\b/\\1}\\n\\1else/",
            },
            stdin = true, -- sed -i operates on the file
        },
        don_try_catch_newline = {
            command = "sed",
            -- Chain two substitutions: one for catch, one for finally
            -- Remember Lua escaping: \ -> \\, ( -> \\(, ) -> \\)
            args = {
                "s/^\\([[:space:]]*\\)}[[:space:]]*catch\\b/\\1}\\n\\1catch/;" -- catch part
                    .. "s/^\\([[:space:]]*\\)}[[:space:]]*finally\\b/\\1}\\n\\1finally/", -- finally part
            },
            stdin = true,
        },
    },
    default_format_opts = {
        timeout_ms = 3000,
    },
    format_on_save = {
        enabled = function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return false
            end
            return true
        end,
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

-- New Toggle Command
vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    if vim.g.disable_autoformat then
        vim.notify("Format on save: disabled globally", vim.log.levels.INFO)
    else
        vim.notify("Format on save: enabled globally (unless buffer override)", vim.log.levels.INFO)
        -- Optionally, you could clear buffer-local disables when enabling globally
        -- for _, bnr in ipairs(vim.api.nvim_list_bufs()) do
        --   if vim.api.nvim_buf_is_loaded(bnr) then
        --     vim.b[bnr].disable_autoformat = false
        --   end
        -- end
    end
end, {
    desc = "Toggle autoformat-on-save globally",
})

-- For buffer-local disabling (from conform docs)
vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        vim.b.disable_autoformat = true
        vim.notify("Format on save: disabled for current buffer", vim.log.levels.INFO)
    else
        vim.g.disable_autoformat = true
        vim.notify("Format on save: disabled globally", vim.log.levels.INFO)
    end
end, {
    desc = "Disable autoformat-on-save (globally or [!]buffer)",
    bang = true,
})

-- For buffer-local/global enabling (from conform docs)
vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
    vim.notify("Format on save: enabled (globally and for current buffer)", vim.log.levels.INFO)
end, {
    desc = "Re-enable autoformat-on-save",
})

vim.keymap.set(
    "n",
    "<leader>tf",
    ":ToggleFormatOnSave<CR>",
    { noremap = true, silent = true, desc = "Toggle format on save" }
)

vim.keymap.set("n", "<leader>tF", ":FormatDisable!<CR>", { desc = "Disable format on save (Buffer)" })
vim.keymap.set("n", "<leader>tE", ":FormatEnable<CR>", { desc = "Enable format on save (Global & Buffer)" })

local wk_status_ok, wk = pcall(require, "which-key")
if wk_status_ok then
    wk.register({
        t = {
            name = "+Toggle", -- Group name for toggles
            f = { ":ToggleFormatOnSave<CR>", "Format on Save (Global)" },
            -- Example for buffer-local if you add keymaps:
            -- F = { ":FormatDisable!<CR>", "Format on Save (Buffer Disable)" },
            -- E = { ":FormatEnable<CR>", "Format on Save (Enable)" },
        },
    }, { prefix = "<leader>" })
end
