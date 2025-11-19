" Search in project.
let g:WhichKeyDesc_SearchSymbol_SearchProject = "<leader>sg search-grep"
nnoremap <leader>sg    :action FindInPath<CR>
vnoremap <leader>sg    :action FindInPath<CR>
let g:WhichKeyDesc_SearchSymbol_ResumeLastSearch = "<leader>sr resume-last-search"
nnoremap <leader>sr    :action FindInPath<CR>
vnoremap <leader>sr    :action FindInPath<CR>

let g:WhichKeyDesc_SearchSymbol_Swoop ="<leader>ss swoop"
nnoremap <leader>ss    :action GotoSymbol<CR>
vnoremap <leader>ss    :action GotoSymbol<CR>
