set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Bundle 'Rykka/riv.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
call vundle#end()

set term=builtin_ansi
filetype plugin indent on
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set modeline
set modelines=5

set viminfo='10,\"100,:20,%,n~/.viminfo
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

match ErrorMsg '\s\+$'
set ruler
set t_Co=256
set background=dark
set number
set bs=2
set et
set hlsearch
set incsearch
set showmatch
set ai
set mps+=<:>


let g:delimitMate_autoclose = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:riv_disable_folding = 1
let g:riv_highlight_code = 'lua,python,cpp,javascript,vim,sh,c'
