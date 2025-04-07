local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

which_key.setup({
    opts = {
        -- Core options
        icons = {
            group = "+",
        },
        -- Window configuration
        win = {
            border = "rounded",
            padding = { 2, 2 }, -- [top/bottom, right/left]
            winblend = 0,
        },
        -- Filter function
        filter = function(mapping)
            return mapping.desc and mapping.desc ~= ""
        end,
        -- Key navigation
        keys = {
            scroll_down = "<c-d>",
            scroll_up = "<c-u>",
        },
        -- Key formatting
        replace = {
            key = {
                { "<Space>", "SPC" },
                { "<CR>", "RET" },
                { "<Tab>", "TAB" },
            },
        },
        -- Proper triggers format
        triggers = {
            { "<auto>", mode = "nixsotc" }, -- Auto-trigger in these modes
            { "<leader>", mode = { "n", "v" } },
        },
        -- Disable warnings
        notify = false,
    }
})
