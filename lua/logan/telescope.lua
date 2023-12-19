local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local status_ok, themes = pcall(require, "telescope.themes")
if not status_ok then
    return
end

telescope.load_extension('media_files')
telescope.load_extension('ui-select')

local actions = require "telescope.actions"
  
telescope.setup { 
    defaults = {
        prompt_prefix = " >",
        selection_caret = " ",
        path_display = { "smart" },
        color_devicons = true,
        file_ignore_patterns = { 
            "node%_modules/.*",
            ".git/.*"
        },
        mappings = {
            n = {
                
            },

            i = {
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            }
        }
    },
    extenstions = {
        media_files = {
            filetypes = {"png", "webp", "jpg", "jpeg"},
            find_cmd = "rg" -- find command (defaults to `fd`)
        },
        ['ui-select'] = {
            themes.get_dropdown
        }
    }
}
