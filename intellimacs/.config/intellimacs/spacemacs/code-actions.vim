" Reformat whole buffer
let g:WhichKeyDesc_CodeActions_ReformatSelection = "<leader>cf reformat-selection"
nnoremap <leader>cf    :action ReformatCode<CR>
" Reformat selected lines
vnoremap <leader>cf    :action ReformatCode<CR>

" Rename symbol
let g:WhichKeyDesc_CodeActions_RenameElement = "<leader>cr rename-element"
nnoremap <leader>cr    :action RenameElement<CR>
vnoremap <leader>cr    :action RenameElement<CR>