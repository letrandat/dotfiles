" List bookmarks
" Create bookmark 0 with <C-S-0>, Create bookmark 1 with <C-S-1> and so on.
" Go to bookmark 0 with <C-0>, go to bookmark 1 with <C-1> and so on.
let g:WhichKeyDesc_Bookmarks_List = "ml list-bookmarks"
nnoremap ml    :action ShowBookmarks<CR>
vnoremap ml    :action ShowBookmarks<CR>

" Previous bookmark
let g:WhichKeyDesc_Bookmarks_PreviousN = "mF previous-bookmark"
nnoremap mF    :action GotoPreviousBookmark<CR>
vnoremap mF    <Esc>:action GotoPreviousBookmark<CR>

" Next bookmark
let g:WhichKeyDesc_Bookmarks_Next = "mf next-bookmark"
nnoremap mf    :action GotoNextBookmark<CR>
vnoremap mf    <Esc>:action GotoNextBookmark<CR>

" Toggle bookmark
let g:WhichKeyDesc_Bookmarks_Toggle = "mm toggle-bookmark"
nnoremap mm    :action ToggleBookmark<CR>
vnoremap mm    :action ToggleBookmark<CR>
