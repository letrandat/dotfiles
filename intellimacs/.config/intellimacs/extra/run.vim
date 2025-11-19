" Run Anything
let g:WhichKeyDesc_Run_Anything = "<leader>:r run-anything"
nnoremap <leader>:r    :action RunAnything<CR>
vnoremap <leader>:r    :action RunAnything<CR>

" Select configuration and run
let g:WhichKeyDesc_Run_SelectRunConfiguration = "<leader>:: select-run-configuration"
nnoremap <leader>::    :action ChooseRunConfiguration<CR>
vnoremap <leader>::    :action ChooseRunConfiguration<CR>

" Compile selected file, package or module
" Make project
let g:WhichKeyDesc_CompileComments_CompileDirty = "<leader>:b     compile-dirty"
nnoremap <leader>:b    :action CompileDirty<CR>
vnoremap <leader>:b    :action CompileDirty<CR>
