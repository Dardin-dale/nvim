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
        python = { "black" },
        rust = { "rustfmt" },
        css = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
        less = { "prettierd", "prettier" },
        sh = { "shfmt" },
        --[[ java = { "google_java_format_file", "don_conditional_newline" }, ]]
        --[[ java = { "lsp_force", "don_conditional_newline" }, ]]
        dart = { "dart_format", "dart_sed_indent", "don_conditional_newline", "don_try_catch_newline" },
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
            prepend_args = { "--tab-spaces", "4" },
        },
        xmllint = {
            args = { "--format", "-" },
            stdin = true,
            env = {
                XMLLINT_INDENT = "    ", -- 4 spaces
            },
        },
        taplo = {
            args = { "format", "-" },
            stdin = true,
        },
        dart_format = {
            command = "dart",
            args = { "format", "$FILENAME" },
            stdin = false, -- dart format modifies the file directly
            condition = function()
                local dart_exe = vim.fn.executable("dart") == 1
                if not dart_exe then
                    vim.notify("dart executable not found for conform.nvim", vim.log.levels.WARN)
                end
                return dart_exe
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
        don_try_catch_newline = {
            command = "sed",
            -- Chain two substitutions: one for catch, one for finally
            -- Remember Lua escaping: \ -> \\, ( -> \\(, ) -> \\)
            args = {
                "-i",
                "s/^\\([[:space:]]*\\)}[[:space:]]*catch\\b/\\1}\\n\\1catch/;" -- catch part
                    .. "s/^\\([[:space:]]*\\)}[[:space:]]*finally\\b/\\1}\\n\\1finally/", -- finally part
                "$FILENAME",
            },
            stdin = false, -- sed -i operates on the file
            condition = function()
                return vim.fn.executable("sed") == 1
            end,
        },
        --[[ lsp_force = { ]]
        --[[     meta = { ]]
        --[[         url = "https://neovim.io/doc/user/lsp.html", ]]
        --[[         description = "Forces LSP formatting using vim.lsp.buf.format", ]]
        --[[     }, ]]
        --[[     format = function(self, ctx) ]]
        --[[         local bufnr = ctx.buf ]]
        --[[]]
        --[[         -- Format using LSP ]]
        --[[         vim.lsp.buf.format({ ]]
        --[[             bufnr = bufnr, ]]
        --[[             timeout_ms = 5000, ]]
        --[[             async = false, ]]
        --[[         }) ]]
        --[[]]
        --[[         -- Since we're modifying the buffer directly, return true to indicate success ]]
        --[[         return true ]]
        --[[     end, ]]
        --[[     stdin = false, ]]
        --[[ }, ]]
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
