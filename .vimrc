
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
" f/p/file-name.js
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' 

" Set general settings

" Turn on spell check
augroup spellcheck 
    autocmd!
    autocmd FileType markdown setlocal spell 
    autocmd BufRead,BufNewFile *.md setlocal spell 
    autocmd Filetype gitcommmit setlocal spell
    inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
augroup END

" Set spellfile to a consistent location to be version controlled
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Set line numbers
set number

" Ceate mapping to allow newline without leaving normal mode
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Set tabs to expand to four spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Track indentation of previous line, but also react to the syntax of 
" the code being written
set autoindent

" Don't be vi compatible
set nocompatible

" Set line length
set wrap
set textwidth=78
set colorcolumn=85

" Prevent wrapping from breaking words
set nolist

" Highlight right margin (>80 chars) in light grey 
highlight ColorColumn ctermbg=235
let &colorcolumn=join(range(81,999),",")

" UTF-8 text encoding by default
set encoding=utf-8

" Turn off audio bell and set as visual
set visualbell

" more powerful backspacing
set backspace=indent,eol,start  

" If searching all lowercase, search case-insensitive. If any 
" characters are uppercase, search case-sensitive.
set ignorecase
set smartcase

" %s/foo/bar/ will assume %s/foo/bar/g
set gdefault

" Highlight results as you search
set incsearch
set showmatch
set hlsearch

" And hit return again after a match to clear highlighting
" Use <silent> to avoid triggering flash
:nnoremap <silent> <CR> :nohlsearch<CR>

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

" Set vim clipboard to be the same as the system clipboard
set clipboard=unnamed

" Set text formatting to auto-wrap text, inserting the current comment leader
" automatically, but not including the comment leader when hitting enter or 'o'
" in normal mode. Also, allow for automatic list formatting.
" http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set fo=tcqwan1
set fo-=cro
" Set options for neomake linting appearance time
call neomake#configure#automake('nw', 750)
