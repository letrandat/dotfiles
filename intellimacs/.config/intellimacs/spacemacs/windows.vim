" Split window right
let g:WhichKeyDesc_Windows_SplitWindowRightV = "<leader>wv split-window-right"
nnoremap <leader>wv    :action SplitVertically<CR>
vnoremap <leader>wv    <Esc>:action SplitVertically<CR>

" Split window below
let g:WhichKeyDesc_Windows_SplitWindowBelowS = "<leader>ws split-window-below"
nnoremap <leader>ws    :action SplitHorizontally<CR>
vnoremap <leader>ws    <Esc>:action SplitHorizontally<CR>

" Focus window left
let g:WhichKeyDesc_Windows_WindowLeft = "<Left> window-left"
nnoremap <Left>    <C-w>h
vnoremap <Left>    <Esc><C-w>h

" Focus window down
let g:WhichKeyDesc_Windows_WindowDown = "<Down> window-down"
nnoremap <Down>    <C-w>j
vnoremap <Down>    <Esc><C-w>j

" Focus window up
let g:WhichKeyDesc_Windows_WindowUp = "<Up> window-up"
nnoremap <Up>    <C-w>k
vnoremap <Up>    <Esc><C-w>k

" Focus window right
let g:WhichKeyDesc_Windows_WindowRight = "<Right> window-right"
nnoremap <Right>    <C-w>l
vnoremap <Right>    <Esc><C-w>l

" Split window below and focus
let g:WhichKeyDesc_Windows_SplitWindowBelowAndFocus = "<leader>wS split-window-below-and-focus"
nnoremap <leader>wS    <C-w>s<C-w>j
vnoremap <leader>wS    <Esc><C-w>s<C-w>j

" Split window right and focus
let g:WhichKeyDesc_Windows_SplitWindowRightAndFocus = "<leader>wV split-window-right-and-focus"
nnoremap <leader>wV    <C-w>v<C-w>l
vnoremap <leader>wV    <Esc><C-w>v<C-w>l

" Toggle maximized window
let g:WhichKeyDesc_Windows_ToggleMaximizeWindow = "<leader>wm toggle-maximize-window"
nnoremap <leader>wm    :only<CR>:action HideAllWindows<CR>
vnoremap <leader>wm    <Esc>:only<CR>:action HideAllWindows<CR>

" Restart
let g:WhichKeyDesc_Quit_InvalidateCache = "<leader>wR invalidate-cache"
nnoremap <leader>wR    :action InvalidateCaches<CR>
vnoremap <leader>wR    <Esc>:action InvalidateCaches<CR>

let g:WhichKeyDesc_Quit_Restart = "<leader>wr restart"
nnoremap <leader>wr    :action RestartIde<CR>
vnoremap <leader>wr    <Esc>:action RestartIde<CR>

" Recent projects
let g:WhichKeyDesc_Projects_RecentProjects = "<leader>ww recent-projects"
nnoremap <leader>ww    :action ManageRecentProjects<CR>
vnoremap <leader>ww    :action ManageRecentProjects<CR>
