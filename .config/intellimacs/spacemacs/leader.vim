" Focus last buffer
let g:WhichKeyDesc_Leader_LastBuffer = "<leader><Tab> last-buffer"
nnoremap <leader><Tab>    <C-S-6>
vnoremap <leader><Tab>    <Esc><C-S-6>

" Activate terminal window
let g:WhichKeyDesc_Leader_OpenShell2 = "<leader>= open-shell"
nnoremap <leader>=    :action ActivateTerminalToolWindow<CR>
vnoremap <leader>=    :action ActivateTerminalToolWindow<CR>

" Activate terminal window
let g:WhichKeyDesc_Leader_OpenShell2 ` "<leader>` open-shell"
nnoremap <leader>`    :action ActivateTerminalToolWindow<CR>
vnoremap <leader>`    :action ActivateTerminalToolWindow<CR>

" Search in project.
let g:WhichKeyDesc_SearchSymbol_SearchProject = "<leader>* search-grep"
nnoremap <leader>*    :action FindInPath<CR>
vnoremap <leader>*    :action FindInPath<CR>

" Show key bindings
let g:WhichKeyDesc_Leader_ShowKeybindings = "<leader>? show-keybindings"
nnoremap <leader>?    :map<CR>
vnoremap <leader>?    <Esc>:map<CR>

" Search in project files
let g:WhichKeyDesc_Leader_SearchProject = "<leader>/ search-project"
nnoremap <leader>/    :action FindInPath<CR>
vnoremap <leader>/    :action FindInPath<CR>
