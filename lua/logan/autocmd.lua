
--vim.api.nvim_create_autocommand('User', {
  --pattern = 'GitConflictDetected',
  --callback = function()
    --vim.notify('Conflict detected in '..vim.fn.expand('<afile>'))
    --vim.keymap.set('n', 'cww', function()
      --engage.conflict_buster()
      --create_buffer_local_mappings()
    --end)
  --end
--})
local function AutoDetectFileType()
    local line = vim.fn.getline(1)
    if line:match("^//") then
        vim.bo.filetype = 'java'
    elseif line:match("^%s*{") then
        vim.bo.filetype = 'json'
    end
end

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {pattern = "*", callback = AutoDetectFileType})
