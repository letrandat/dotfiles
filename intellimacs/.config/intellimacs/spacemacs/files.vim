""" IDE Submenu ---------------------------------
let g:WhichKeyDesc_Files_IDE = "<leader>fe +IDE"

" Find files
let g:WhichKeyDesc_Files_GotoFile = "<leader>ff goto-file"
nnoremap <leader>ff    :action GotoFile<CR>
vnoremap <leader>ff    :action GotoFile<CR>

" Recent files
let g:WhichKeyDesc_Files_Recent = "<leader>fr recent"
nnoremap <leader>fr    :action RecentFiles<CR>
vnoremap <leader>fr    :action RecentFiles<CR>

" Focus on project window.
" Sadly when you are inside the project window this key binding does not work
" anymore. You can use <A-1> if you want to close the window or <Esc> if you
" want to leave the window opened and focus on the code.
let g:WhichKeyDesc_Files_FileTree = "<leader>ft file-tree"
nnoremap <leader>ft    :action ActivateProjectToolWindow<CR>
vnoremap <leader>ft    :action ActivateProjectToolWindow<CR>


" Copy file path
let g:WhichKeyDesc_Files_YankCopy_FilePath = "<leader>fP file-path absolute"
nnoremap <leader>fyy    :action CopyAbsolutePath<CR>
vnoremap <leader>fyy    :action CopyAbsolutePath<CR>

let g:WhichKeyDesc_Files_YankCopy_FilePath = "<leader>fp file-path"
nnoremap <leader>fyy    :action CopyContentRootPath<CR>
vnoremap <leader>fyy    :action CopyContentRootPath<CR>
""" ---------------------------------------------------
