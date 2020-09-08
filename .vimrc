let mapleader = ","

set encoding=utf-8

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Stop the bloody beeping
set visualbell

set termguicolors

" Easier access to [ and ] in normal mode on Danish keyboards
nmap æ [
nmap ø ]

" Use smart casing for searches
set ignorecase
set smartcase

" Disable arrow keys
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep a backup file (restore to previous version)
set undofile		" keep an undo file (undo changes after closing)
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set directory=~/.vim/tmp/swap/
set backupdir=~/.vim/tmp/backup/
set undodir=~/.vim/tmp/undo/

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")
" let guioptions="egm"


" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
" if has('mouse')
"   set mouse=a
" endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

" Vundle
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Languages
" Syntax checker
Plugin 'vim-syntastic/syntastic'
Plugin 'ycm-core/YouCompleteMe'
" golang
" Plugin 'fatih/vim-go'
" Python
Plugin 'davidhalter/jedi-vim'
Plugin 'nvie/vim-flake8'
" SWIG interface files
" Plugin 'vim-scripts/SWIG-syntax'
" Doxygen
Plugin 'vim-scripts/DoxygenToolkit.vim'
" MediaWiki
Plugin 'chikamichi/mediawiki.vim'

" VCS
" Git
Plugin 'tpope/vim-fugitive'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Misc
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-abolish'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'artoj/qmake-syntax-vim'
" Plugin 'jiangmiao/auto-pairs'
Plugin 'Raimondi/delimitMate'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'godlygeek/tabular'
Plugin 'vim-scripts/argtextobj.vim.git'
Plugin 'mileszs/ack.vim'
Plugin 'keith/tmux.vim'
Plugin 'SirVer/ultisnips'
Plugin 'wesQ3/vim-windowswap'
Plugin 'mkitt/tabline.vim'
Plugin 'haya14busa/is.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'hashivim/vim-terraform'
Plugin 'juliosueiras/vim-terraform-completion'
" Plugin 'mrk21/yaml-vim'
Plugin 'vim-scripts/indentpython.vim'

" -Themes
Plugin 'morhetz/gruvbox'

" All of your Plugins must be added before the following line
call vundle#end()            " required
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

  filetype plugin indent on

" Let's use ag instead of ack, if present
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:ctrlp_working_path_mode=0

" Disable Auto Pairs AutoPairsFastWrap to make letter 'å' work
let g:AutoPairsShortcutFastWrap='<Nop>'

" Set path to something sensible
set path=.,/usr/local/include,,**

" Allow switching away from edited buffer
set hidden

" Split behaviour
set splitbelow
set splitright

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

" Setup theme
set t_Co=256
set background=dark
try
	colorscheme gruvbox
catch /.*/
endtry

" Setup airline
" set guifont=Sauce\ Code\ Powerline\ Light:h13
set guifont=Source\ Code\ Pro\ for\ Powerline:h13
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline#extensions#branch#enabled = 1
set noshowmode
set timeoutlen=1000
set ttimeoutlen=10

" Change vim's stupid tab completion to a more sensible behaviour
set wildmode=longest,list,full
set wildmenu

" Merge vim and OS clipboard
set clipboard=unnamed

" Make it easier to remove highlights after search
nnoremap <silent> <leader>nh :nohlsearch<CR>

" Show line numbers
set number
set relativenumber

" Text width
" set textwidth=95
" augroup textwidth_autocmds
"   autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
"   autocmd BufEnter * match OverLength /\%96v.*/
" augroup END

" Sensible tabs
set tabstop=4
set shiftwidth=4
" set softtabstop=4
set noexpandtab

" delimitMate setup
let delimitMate_expand_cr = 1

" UltiSnips setup
nnoremap <leader>ue :UltiSnipsEdit<CR>
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsSnippetDirectories=[$HOME."/UltiSnips", $HOME."/.vim/UltiSnips", "UltiSnips"]
let g:UltiSnipsEditSplit="vertical"

" Python setup
let python_highlight_all=1

" C++ setup
set errorformat^=%-G%f:%l:\ warning:%m
autocmd FileType cpp setlocal commentstring=//\ %s
" augroup make
"   au!
"   autocmd QuickFixCmdPost [^l]* nested cwindow
"   autocmd QuickFixCmdPost    l* nested lwindow
" augroup END
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_python_checkers=['pylint']

" YouCompleteMe setup
let g:ycm_global_ycm_extra_conf = '~/vim/ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_auto_hover = ''
nnoremap <leader>yr   :YcmCompleter GoToReferences<CR>
nnoremap <leader>yt   :YcmCompleter GetType<CR>
nnoremap <leader>yji  :YcmCompleter GoToInclude<CR>
nnoremap <leader>yjde :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>yjdi :YcmCompleter GoToDefinition<CR>
nnoremap <leader>yd   :YcmCompleter GetDoc<CR>
nnoremap <leader>yf   :YcmCompleter FixIt<CR>
nmap <leader>yD <plug>(YCMHover)

" Doxygen setup
let g:load_doxygen_syntax=1
let g:DoxygenToolkit_returnTag = "\\return "
let g:DoxygenToolkit_briefTag_pre = "\\brief "
let g:DoxygenToolkit_paramTag_pre = "\\param "
let g:DoxygenToolkit_throwTag_pre = "\\throws "
let g:DoxygenToolkit_classTag_pre = "\\class "
let g:DoxygenToolkit_startCommentTag="//! "
let g:DoxygenToolkit_startCommentBlock="//! "
let g:DoxygenToolkit_interCommentTag="//! "
let g:DoxygenToolkit_interCommentBlock="//! "
let g:DoxygenToolkit_endCommentTag=""
let g:DoxygenToolkit_endCommentBlock=""
map <leader>d :Dox<CR>

" Syntastic Config
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" Terraform Completion setup
" let g:terraform_completion_keys = 1

" Write before commands
set autowrite

" Terraform
augroup Terraform
	au!
	autocmd FileType terraform setlocal ts=2 sts=2 sw=2 expandtab
augroup END

" Python
augroup Python
	au!
	autocmd BufWritePost *.py call Flake8()
augroup END

" Set up highlight of current line
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END
hi CursorLine cterm=NONE ctermbg=239

augroup JSON
	au!
	autocmd BufNewFile,BufReadPost *.json set filetype=json " foldmethod=indent
	autocmd FileType json setlocal ts=4 sts=4 sw=4 expandtab
augroup END

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

" Recognize SWIG files
augroup swig
  au!
  autocmd BufNewFile,BufRead *.i set filetype=swig
  autocmd BufNewFile,BufRead *.swg set filetype=swig
  autocmd BufNewFile,BufRead *.swig set filetype=swig
augroup END

augroup WrapLineInMarkdownFile
	au!
	autocmd FileType markdown setlocal textwidth=90
    autocmd FileType markdown setlocal wrap
augroup END

" Key bindings for bubbling text
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

let g:markdown_fenced_languages = ['cpp']

" .vimrc editing
" Open .vimrc in new tab
nmap <leader>v :tabedit $MYVIMRC<CR>
" Reload .vimrc after edit
augroup myvimrc
  au!
  " au BufWritePost vimrc,.vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
  au BufWritePost vimrc,.vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') && filereadable('$HOME/.gvimrc') | so expand('$HOME/.gvimrc') | endif
augroup END
