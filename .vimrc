
" Map comma to leader
:let mapleader = ","

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'neomake/neomake'
Plug 'eigenfoo/stan-vim'
Plug 'preservim/nerdtree'

call plug#end()
			
" Set plugin options

" Set neomake options for linting
let g:neomake_python_enabled_makers = ['pylint']

" Set options for Black formatter
let g:black_linelength = 79

" Set the options for Airline theme 
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " f/p/file-name.js


" Ceate mapping to allow newline without leaving normal mode
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Set tabs to expand to four spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Don't be vi compatible
set nocompatible

" Set line length
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" UTF-8 text encoding by default
set encoding=utf-8

" Turn off audio bell and set as visual
set visualbell

" more powerful backspacing
set backspace=indent,eol,start  

" If searching all lowercase, search case-insensitive. If any characters are 
" uppercase, search case-sensitive.
set ignorecase
set smartcase

" %s/foo/bar/ will assume %s/foo/bar/g
set gdefault

" Highlight results as you search
set incsearch
set showmatch
set hlsearch

" Map leader n to open NerdTree
nnoremap <leader>n :NERDTree<CR>

" And remap standard vim-grep to use ripgrep instead
 set grepprg=rg\ --vimgrep\ --smart-case\ --follow\ --no-heading
 set grepformat=%f:%l:%c:%m,%f:%l:%m

" Search down into subfolders
" Provides tab completion for folder-related tasks
set path+=**

" Display all matching files when tab completing
set wildmenu

" Set options for neomake linting appearance time
call neomake#configure#automake('nw', 750)
