" Toggle distraction free mode
let g:WhichKeyDesc_UiTogglesThemes_DistractionFreeMode = "<leader>uz distraction-free-mode"
nnoremap <leader>uz    :action ToggleDistractionFreeMode<CR>
vnoremap <leader>uz    :action ToggleDistractionFreeMode<CR>

" Toggle truncate lines
let g:WhichKeyDesc_Toggles_SoftWraps = "<leader>uw soft-wraps"
nnoremap <leader>uw    :action EditorToggleUseSoftWraps<CR>
vnoremap <leader>uw    :action EditorToggleUseSoftWraps<CR>
