function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

set updatetime=500
set signcolumn=number

autocmd ColorScheme * highlight CocHighlightText guibg=#444444
autocmd CursorHold * silent call CocActionAsync('highlight')

if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-space> coc#refresh()
	inoremap <silent><expr> <c-@> coc#refresh()
endif
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible()
                               \ ? coc#_select_confirm()
                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gt :call CocActionAsync('doHover')<cr>
nmap <silent> <leader>gf <plug>(coc-fix-current)
nmap <silent> <leader>ge :call CocAction('codeActions')<cr>
" nmap <silent> <leader>ge <plug>(coc-refactor)
