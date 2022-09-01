if vim.g.neovide == 1 then
    vim.cmd[[ 
     "let g:neovide_fullscreen=v:true", 
     "let g:neovide_cursor_vfx_mode='PixieDust'", 
    ]]
    --[[ vim.g.neovide_cursor_vfx_mode="PixieDust" ]]
    --[[ vim.g.neovide_fullscreen=true ]]
    vim.cmd[["set guifont=FiraCode\ NF:h10"]]
end

