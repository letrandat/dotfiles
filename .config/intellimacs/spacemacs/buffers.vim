" Switch among recently opened files
let g:WhichKeyDesc_Buffers_ListBuffers = "<leader>bb    list-buffers"
nnoremap <leader>bb    :action RecentFiles<CR>
vnoremap <leader>bb    :action RecentFiles<CR>

" Close current tab
let g:WhichKeyDesc_Buffers_KillBuffer = "<leader>bd    kill-buffer"
nnoremap <leader>bd    :action CloseContent<CR>
vnoremap <leader>bd    <Esc>:action CloseContent<CR>

" Open a new scratch buffer
let g:WhichKeyDesc_Buffers_ScratchBuffer = "<leader>bs    scratch-buffer"
nnoremap <leader>bs    :action NewScratchBuffer<CR>
vnoremap <leader>bs    <Esc>:action NewScratchBuffer<CR>

" Reopen last closed tab
let g:WhichKeyDesc_Buffers_ReopenLastKilledBuffer = "<leader>bu    reopen-last-killed-buffer"
nnoremap <leader>bu    :action ReopenClosedTab<CR>
vnoremap <leader>bu    <Esc>:action ReopenClosedTab<CR>

" Close other tabs in current window
let g:WhichKeyDesc_Buffers_KillOtherBuffers = "<leader>bo    kill-other-buffers"
nnoremap <leader>bo    :action CloseAllEditorsButActive<CR>
vnoremap <leader>bo    :action CloseAllEditorsButActive<CR>
