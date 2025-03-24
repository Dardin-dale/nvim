-- Enhanced NvimTree rename functionality that uses git mv when in a git repository
-- Add this to your nvim-tree.lua file

local function is_git_repo()
	-- Check if current directory is a git repository
	local result = vim.fn.systemlist("git rev-parse --is-inside-work-tree 2>/dev/null")
	return result[1] == "true"
end

local function is_file_tracked_by_git(file_path)
	-- Check if file is tracked by git
	local result = vim.fn.systemlist("git ls-files --error-unmatch " .. vim.fn.shellescape(file_path) .. " 2>/dev/null")
	return vim.v.shell_error == 0
end

local function setup_git_rename()
	-- Store the original rename function
	local nvim_tree_api = require("nvim-tree.api")
	local original_rename = nvim_tree_api.fs.rename

	-- Override the rename function
	nvim_tree_api.fs.rename = function(...)
		local node = nvim_tree_api.tree.get_node_under_cursor()
		if not node then
			return
		end

		local file_path = node.absolute_path

		-- If we're in a git repo and the file is tracked, use git mv
		if is_git_repo() and is_file_tracked_by_git(file_path) then
			-- Get new name
			local new_name = vim.fn.input("New name: ", node.name)
			if new_name == "" or new_name == node.name then
				-- User cancelled or didn't change the name
				return
			end

			-- Get the directory path
			local dir_path = vim.fn.fnamemodify(file_path, ":h")
			local new_path = dir_path .. "/" .. new_name

			-- Execute git mv
			local cmd = "git mv " .. vim.fn.shellescape(file_path) .. " " .. vim.fn.shellescape(new_path)
			local result = vim.fn.system(cmd)

			-- Check for errors
			if vim.v.shell_error ~= 0 then
				vim.api.nvim_err_writeln("Git mv failed: " .. result)
				return
			end

			-- Refresh the tree
			nvim_tree_api.tree.reload()

			-- Print success message
			vim.api.nvim_out_write("File renamed with git mv\n")
		else
			-- Fall back to the original rename function for non-git files
			original_rename(...)
		end
	end
end

return {
	setup_git_rename = setup_git_rename,
}
