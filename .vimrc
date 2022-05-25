""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""

" Map comma to leader
let mapleader = ","

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
Plug 'vim-scripts/ReplaceWithRegister'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
" Set plugin options
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""
" Neomake
""""""""""""""""""""

" Set neomake options for Python so that shows only pylint and not also pep8
let g:neomake_python_enabled_makers = ['pylint']
" Set options for neomake linting appearance time
call neomake#configure#automake('nw', 750)
" Set options for Black formatter
let g:black_linelength = 79

""""""""""""""""""""
" Airline
""""""""""""""""""""

" Set the options for Airline theme 
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled = 1
" f/p/file-name.js
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' 

""""""""""""""""""""
" netrw
""""""""""""""""""""

" enable syntax and plugins (for netrw)
syntax enable
filetype plugin on
" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Set files with ".md" extension to be of type markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown

""""""""""""""""""""
" Spelling
""""""""""""""""""""

" Turn on spell check
set spell spelllang=en_us

" Specify colors for spellcheck
highlight SpellBad ctermbg=001 " Dark red
highlight SpellRare ctermbg=140  " Light purple
highlight SpellLocal ctermbg=068 " Light blue 
highlight SpellCap ctermbg=103 " Dark grey 

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

" If in a markdown file, autocomplete with dictionary words when 
" spell check is on
if &filetype ==# 'markdown'
  setlocal complete+=kspell
endif

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

" Deactivate line length/wrapping in bash because it's whitespace sensitive 
if &filetype ==# 'sh'
 set textwidth=500 
endif

" Prevent wrapping from breaking words
set linebreak
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

