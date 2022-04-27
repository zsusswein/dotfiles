

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
Plug 'psf/black', { 'branch': 'stable' }
Plug 'neomake/neomake'
Plug 'eigenfoo/stan-vim'

call plug#end()
			
" Set plugin options
let g:neomake_python_enabled_makers = ['pylint']
let g:black_linelength = 79

call neomake#configure#automake('nw', 750)
