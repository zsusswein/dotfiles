""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""

" Map comma to leader
let mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin loading
""""""""""""""""""""""""""""""""""""""""""""""""""

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
Plug 'sillybun/vim-repl'
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-surround' 
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
" Set plugin options
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""
" Airline
""""""""""""""""""""
" Only show the tail of the git branch: 'feature/foo' becomes 'foo'
let g:airline#extensions#branch#format = 1
" Allow vim-fugitive to show VCS status airline
let g:airline#extensions#branch#enabled = 1
" Turn off the warning section
let g:airline_section_warning = ''
" Have airline expect utf-8 encoding on unix and only display if otherwise
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" Set a fun theme
let g:airline_theme='wombat'
" Show buffers in tabline
let g:airline#extensions#tabline#enabled = 1
" f/p/file-name.js
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' 

""""""""""""""""""""
" Neomake
""""""""""""""""""""
" Set neomake options for Python so that shows only pylint and not also pep8
let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_python_pylint_args = ['--output-format=text',
            \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg} [{msg_id}]"',
            \'--reports=no',
            \'--good-names=x,y',
            \'--include-naming-hint=y']
" Set options for neomake linting appearance time
call neomake#configure#automake('nw', 750)
" Set options for Black formatter
let g:black_linelength = 79

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
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

""""""""""""""""""""
" vim-repl
""""""""""""""""""""
nnoremap <leader>t :REPLToggle<enter>
let g:repl_program = {
            \   'python': 'python3',
            \   }

""""""""""""""""""""
" jedi-vim
""""""""""""""""""""
let g:jedi#show_call_signatures = "1" " Show function call signature in a popup

""""""""""""""""""""
" vim-tmux-navigator
""""""""""""""""""""
" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""
" Miscellaneous
""""""""""""""""""""

" Show leading tabs and whitespace
set list lcs=trail:·,tab:»·

" Display all matching files when tab completing
set wildmenu

" Set vim clipboard to be the same as the system clipboard
set clipboard=unnamed

" UTF-8 text encoding by default
set encoding=utf-8

" Don't be vi compatible
set nocompatible

" Disable the default Vim startup message.
set shortmess+=I

" Hide buffers with unsaved changes rather than forgetting about them and reloading
set hidden

" Turn off audio bell and set as visual
set visualbell

" more powerful backspacing
set backspace=indent,eol,start  

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Set files with ".md" extension to be of type markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Default to python3
let g:pymode_python = 'python3'

""""""""""""""""""""
" Spelling
""""""""""""""""""""

" Turn on spell check
set spell spelllang=en_us

" Specify colors for spellcheck
highlight clear SpellBad
highlight clear SpellRare
highlight clear SpellLocal
highlight clear SpellCap

highlight SpellBad cterm=underline
highlight SpellBad ctermfg=160 " Dark red
highlight SpellCap  cterm=underline
highlight SpellCap ctermfg=102 " Dark grey 

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
set textwidth=120
set wrap
set colorcolumn=85

" Deactivate line length/wrapping in bash because it's whitespace sensitive 
if &filetype ==# 'sh'
 set textwidth=500 
endif

" Prevent wrapping from breaking words
set linebreak

" Highlight right margin (>80 chars) in light grey 
highlight ColorColumn ctermbg=235
let &colorcolumn=join(range(85,999),",")

" Set text formatting to auto-wrap text, inserting the current comment leader
" automatically, but not including the comment leader when hitting enter or 'o'
" in normal mode. Also, allow for automatic list formatting.
" http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set fo=tcqwn1c
set fo-=roa

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
" Formatting
""""""""""""""""""""
" Add a Vim header block
nnoremap <leader><C-v> <esc>0o<esc>020i"<esc>0o<esc>i"<esc>0o<esc>019i"<esc>0o<esc>2k$a<space>

" Add a standard header block
nnoremap <C-b> <esc>0o<esc>020i#<esc>0o<esc>i#<esc>0o<esc>020i#<esc>0o<esc>2k$a<space>

