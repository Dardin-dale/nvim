local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

telescope.load_extension('media_files')

local actions = require "telescope.actions"
  
telescope.setup { 
    defaults = {
        prompt_prefix = " >",
        selection_caret = " ",
        path_display = { "smart" },
        color_devicons = true,

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
        }
    }
}
