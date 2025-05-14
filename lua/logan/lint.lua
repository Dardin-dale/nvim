local M = {}

-- Get references to required modules
local status_ok, lint = pcall(require, "lint")
if not status_ok then
    return M
end

local mason_status_ok, mason_registry = pcall(require, "mason-registry")
if not mason_status_ok then
    vim.notify("Mason registry not available - automatic linter installation disabled", vim.log.levels.WARN)
    return M
end

-- Define linters by filetype
M.linters_by_ft = {
    -- Programming languages
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    python = { "flake8" },
    --[[ lua = { "luacheck" }, ]]
    sh = { "shellcheck" },
    bash = { "shellcheck" },
    rust = { "cargo" },

    -- Config formats
    yaml = { "yamllint" },
    markdown = { "markdownlint" },

    -- Add more filetypes and linters as needed
}

-- Map linter names to their mason package names
local linter_to_mason_map = {
    eslint_d = "eslint_d",
    flake8 = "flake8",
    --[[ luacheck = "luacheck", ]]
    shellcheck = "shellcheck",
    yamllint = "yamllint",
    markdownlint = "markdownlint",
    -- Add more mappings as needed
}

-- Get all unique linters from the map
local function get_all_linters()
    local linters = {}
    for _, ft_linters in pairs(M.linters_by_ft) do
        for _, linter in ipairs(ft_linters) do
            if linter_to_mason_map[linter] then
                linters[linter_to_mason_map[linter]] = true
            end
        end
    end

    local result = {}
    for linter, _ in pairs(linters) do
        table.insert(result, linter)
    end

    return result
end

-- Install missing linters
function M.ensure_installed()
    local linters = get_all_linters()

    for _, linter_name in ipairs(linters) do
        local package = linter_name

        if not mason_registry.is_installed(package) then
            vim.notify("Installing linter: " .. package, vim.log.levels.INFO)
            local pkg = mason_registry.get_package(package)
            pkg:install():once("closed", function()
                vim.notify(package .. " installation complete", vim.log.levels.INFO)
            end)
        end
    end
end

-- Configure linting
function M.setup()
    -- Configure nvim-lint with the linters
    lint.linters_by_ft = M.linters_by_ft

    -- Create an autocommand group for linting
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- Trigger linting on events
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
            lint.try_lint()
        end,
    })

    -- Ensure all linters are installed
    M.ensure_installed()

    -- Create a command to manually trigger linting
    vim.api.nvim_create_user_command("Lint", function()
        lint.try_lint()
    end, {})

    -- Add a keybinding for manual linting
    vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
        vim.notify("Linting triggered", vim.log.levels.INFO)
    end, { noremap = true, silent = true, desc = "Trigger linting" })

    -- Register with which-key
    local wk_status_ok, wk = pcall(require, "which-key")
    if wk_status_ok then
        wk.register({
            l = {
                l = {
                    function()
                        lint.try_lint()
                    end,
                    "Trigger linting",
                },
            },
        }, { prefix = "<leader>" })
    end
end

-- Initialize the linting configuration
M.setup()

return M
