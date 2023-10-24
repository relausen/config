function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

set updatetime=500
" set signcolumn=number

autocmd ColorScheme * highlight CocHighlightText guibg=#444444
autocmd CursorHold * silent call CocActionAsync('highlight')

if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-space> coc#refresh()
	inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
" nmap <silent> <leader>gaf  <plug>(coc-codeaction)
nmap <silent> <leader>gac  <plug>(coc-codeaction-cursor)
vmap <silent> <leader>gac  <plug>(coc-codeaction-cursor)
" nmap <silent> <leader>gal  <plug>(coc-codeaction-line)
nmap <silent> <leader>gas  <plug>(coc-codeaction-selected)
nmap <silent> <leader>gc   <plug>(coc-refactor)
vmap <silent> <leader>gc   <plug>(coc-refactor)
nmap <silent> <leader>gd   <Plug>(coc-definition)
nmap <silent> <leader>gdn  <plug>(coc-diagnostic-next)
nmap <silent> <leader>gdp  <plug>(coc-diagnostic-prev)
nmap <silent> <leader>gf   <plug>(coc-fix-current)
nmap <silent> <leader>gi   <Plug>(coc-implementation)
nmap <silent> <leader>gos  :call CocAction('showOutline')<cr>
nmap <silent> <leader>goh  :call CocAction('hideOutline')<cr>
nmap <silent> <leader>gp   <plug>(coc-format-selected)
vmap <silent> <leader>gp   <plug>(coc-format-selected)
nmap <silent> <leader>gr   <Plug>(coc-rename)
nmap <silent> <leader>gref <Plug>(coc-references)
nmap <silent> <leader>grfa <Plug>(coc-refactor)
nmap <silent> <leader>gt   :call CocActionAsync('definitionHover')<cr>
nmap <silent> <leader>gy   <Plug>(coc-type-definition)
nmap <silent> <leader>gtfv   :call CocAction('terraform.validate')<cr>
