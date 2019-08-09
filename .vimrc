" obligatory first line set
set nocompatible
" Plugins setup
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle Bundles
Plugin 'VundleVim/Vundle.vim'
"Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()
filetype plugin indent on

" YCM
let g:ycm_python_binary_path = '/usr/bin/python3'

" NerdTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Dont let NERDTree hang your vim if its the only window remaining

" Powerline setup
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set guifont=PowerlineSymbols\ Medium
set laststatus=2

"ConqueTerm
set splitbelow
set splitright
"call conque_term#open('bash', ['10sp'], 0)

" OTHER SETTINGS
syntax on
set autoread
set gdefault
set hidden
set number
set nowrap
set hlsearch
set incsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set splitbelow
set splitright
set smarttab
colo default

" Undo, Clipboard
set history=999         " remember more commands and search history
set undolevels=999      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set clipboard=unnamed    " normal OS clipboard interaction

" Mouse Support
set mouse=a

" Python Specific
autocmd filetype python set expandtab

" C++
set exrc
set secure

augroup project
	autocmd!
	autocmd BufRead,BufNewFile *.h,*.c,*.cpp set filetype=c.doxygen
augroup END

let &path.="src/include,/usr/include/AL,"
set includeexpr=substitute(v:fname,'\\.','/','g')
