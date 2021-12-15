let mapleader = ","
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

set background=dark
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set backup " keep a backup file (restore to previous version)
set backupdir=~/.vim/tmp/backup/
set directory=~/.vim/tmp/swap/
set encoding=utf-8
set expandtab
set hidden
set history=50
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nocompatible " Use Vim settings
set noshowmode
set number
set path=.,/usr/local/include,,**
set relativenumber
set ruler
set shiftwidth=4
set showcmd " display incomplete commands
set smartcase
set softtabstop=4
set splitbelow
set splitright
set t_Co=256
set tabstop=4
set termguicolors
set timeoutlen=1000
set ttimeoutlen=10
set undodir=~/.vim/tmp/undo/
set undofile " keep an undo file (undo changes after closing)
set visualbell t_vb= " Stop the bloody beeping and blinking
set wildmenu
set wildmode=longest,list,full " Change vim's default tab completion to a more sensible behaviour

syntax on
filetype plugin indent on

" Convenient command to see the difference between the current buffer and the " file it was loaded from
command! DiffOrig vert new | set buftype=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
" Make it easier to remove highlights after search
nnoremap <silent> <leader>nh :nohlsearch<CR>
" Convenience keys for opening file in same dir as file in buffer
" Mnemonics:
" Edit in Window
" Edit in Split (horisontal)
" Edit in Vertical split
" Edit in Tab
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
" Key bindings for bubbling text
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
nmap <leader>v :tabedit $MYVIMRC<CR>
" Easier access to [ and ] in normal mode on Danish keyboards
nmap æ [
nmap ø ]

augroup vimStartup
  autocmd!
  autocmd FileType text setlocal textwidth=78 " For all text files set 'textwidth' to 78 characters.
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Reload .vimrc after edit
augroup myvimrc
  au!
  au BufWritePost vimrc,.vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,.vim/packages.vim so $MYVIMRC | if has('gui_running') && filereadable('$HOME/.gvimrc') | so expand('$HOME/.gvimrc') | endif
augroup END

" See http://vimcasts.org/episodes/minpac/ for this setup of minpac
source ~/.vim/packages.vim
source ~/.vim/coc-setup.vim
source ~/.vim/coc-extensions.vim
" NerdTree setup
let NERDTreeHijackNetrw=1

" FZF setup
nnoremap <C-p> :<C-u>FZF<CR>
let g:ctrlp_working_path_mode=0

" Gruvbox Setup
let g:gruvbox_contrast_dark = 'hard'
autocmd vimenter * ++nested colorscheme gruvbox

" airline Setup
set guifont=Source\ Code\ Pro\ for\ Powerline:h13
let g:airline#extensions#hunks#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1

" delimitMate setup
let delimitMate_expand_cr = 1

" UltiSnips setup
nnoremap <leader>ue :UltiSnipsEdit<CR>
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsSnippetDirectories=[$HOME."/UltiSnips", $HOME."/.vim/UltiSnips", "UltiSnips"]
let g:UltiSnipsEditSplit="vertical"

" C++ setup
set errorformat^=%-G%f:%l:\ warning:%m
autocmd FileType cpp setlocal commentstring=//\ %s

" Terraform setup
augroup Terraform
  au!
  autocmd FileType terraform setlocal ts=2 sts=2 sw=2 expandtab
augroup END

" Python setup
augroup Python
  au!
  autocmd BufWritePost *.py call Flake8()
augroup END

" JSON setup
augroup JSON
  au!
  autocmd BufNewFile,BufReadPost *.json set filetype=json " foldmethod=indent
  autocmd FileType json setlocal ts=4 sts=4 sw=4 expandtab
augroup END

" YAML setup
" augroup YAML
" 	au!
" 	autocmd BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml " foldmethod=indent
" 	autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab
" augroup END

" Recognize QMake .pro and .pri files
augroup qmake
  au!
  autocmd BufNewFile,BufRead *.pro set filetype=qmake
  autocmd BufNewFile,BufRead *.pri set filetype=qmake
augroup END

"Markdown setup
augroup WrapLineInMarkdownFile
  au!
  autocmd FileType markdown setlocal textwidth=90
  autocmd FileType markdown setlocal wrap
augroup END
