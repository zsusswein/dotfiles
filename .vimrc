""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""

" Map comma to leader
:let mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin loading
"""""""""""""""""""""""""""""""""""""""""""""""""""

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

""""""""""""""""""""""""""""""""""""""""""""""""""
" Set plugin options
""""""""""""""""""""""""""""""""""""""""""""""""""

" Set neomake options for linting
let g:neomake_python_enabled_makers = ['pylint']

" Set options for neomake linting appearance time
call neomake#configure#automake('nw', 750)

" Set options for Black formatter
let g:black_linelength = 79

" Set the options for Airline theme 
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled = 1
" f/p/file-name.js
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' 

" Map leader n to open NerdTree
nnoremap <leader>n :NERDTree<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""
" Spelling
""""""""""""""""""""

" Turn on spell check
set spell spelllang=en_us

" Specify colors for spellcheck
highlight SpellBad ctermbg=001 " Dark red
highlight SpellRare ctermbg=140  " Light purple
highlight SpellLocal ctermbg=068 " Light blue 
highlight SpellCap ctermbg=222 " Dark green 

" Map Leader-L to go back to last misspelled word and pick first suggestion.
" But set an undo marker so that hitting `u` will undo the word and jump back
inoremap <leader>l <C-G>u<Esc>[s1z=`]a<C-G>u

" Select last misspelled word (typing will edit).
" Best used for short words because vim's built in spellcheck performs poorly
" on these
nnoremap <leader>k <Esc>[sve<C-G>
inoremap <leader>k <Esc>[sve<C-G>
snoremap <leader>k <Esc>b[sviw<C-G>

" Set spellfile to a consistent location to be version controlled
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

set spellsuggest='fast'

""""""""""""""""""""
" Line settings
""""""""""""""""""""

" Set line numbers
set number

" Create mapping to allow newline without leaving normal mode
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

" Set line length
set wrap
set textwidth=78
set colorcolumn=85

" Prevent wrapping from breaking words
set nolist

" Highlight right margin (>80 chars) in light grey 
highlight ColorColumn ctermbg=235
let &colorcolumn=join(range(81,999),",")

" Set text formatting to auto-wrap text, inserting the current comment leader
" automatically, but not including the comment leader when hitting enter or 'o'
" in normal mode. Also, allow for automatic list formatting.
" http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set fo=tcqwan1
set fo-=cro

""""""""""""""""""""
" Search
""""""""""""""""""""

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

" When toggling between search results, center those results in the window
nnoremap N Nzz
nnoremap n nzz

" Search down into subfolders
" Provides tab completion for folder-related tasks
set path+=**

" And remap standard vim-grep to use ripgrep instead
 set grepprg=rg\ --vimgrep\ --smart-case\ --follow\ --no-heading
 set grepformat=%f:%l:%c:%m,%f:%l:%m

""""""""""""""""""""
" Miscellaneous
""""""""""""""""""""

" Display all matching files when tab completing
set wildmenu

" Set vim clipboard to be the same as the system clipboard
set clipboard=unnamed

" UTF-8 text encoding by default
set encoding=utf-8

" Don't be vi compatible
set nocompatible

" Turn off audio bell and set as visual
set visualbell

" more powerful backspacing
set backspace=indent,eol,start  
