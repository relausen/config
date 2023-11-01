cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
inoremap <C-U> <C-G>u<C-U>
map <leader>es :sp %%
map <leader>et :tabe %%
map <leader>ev :vsp %%
map <leader>ew :e %%
nmap <leader>Gt :tab Git<CR>
nmap <leader>Gv :vert Git<CR>
nmap <leader>Tt :tab term<CR>
nmap <leader>Tv :vert term<CR>
nmap <leader>v :tabedit $MYVIMRC<CR>

nmap æ [
nmap ø ]
vmap æ [
vmap ø ]

nnoremap <silent> <leader>nh :nohlsearch<CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <leader>ue :UltiSnipsEdit<CR>
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
