" See http://vimcasts.org/episodes/minpac/ for the techniques used here

command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
command! PackUpdate packadd minpac | source $MYVIMRC | redraw | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" Drew Neil uses if !exists('*minpac#init'), but that doesn't work
" consistently in both MacVim and terminal Vim
if !exists('g:loaded_minpac')
  finish
endif

call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('nvie/vim-flake8')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-ragtag')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-abolish')
call minpac#add('tpope/vim-scriptease')
call minpac#add('scrooloose/nerdtree')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('artoj/qmake-syntax-vim')
call minpac#add('Raimondi/delimitMate')
call minpac#add('godlygeek/tabular')
call minpac#add('mileszs/ack.vim')
call minpac#add('SirVer/ultisnips')
call minpac#add('mkitt/tabline.vim')
call minpac#add('haya14busa/is.vim')
call minpac#add('rizzatti/dash.vim')
call minpac#add('hashivim/vim-terraform')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
call minpac#add('morhetz/gruvbox')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('cespare/vim-toml')
call minpac#add('kevinoid/vim-jsonc')
call minpac#add('puremourning/vimspector')
call minpac#add('airblade/vim-rooter')
