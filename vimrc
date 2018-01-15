" >>>>>>>>>> BEGIN VUNDLE CONFIG
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" File browser
Plugin 'scrooloose/nerdtree'
" Status bar + tabs
Plugin 'vim-airline/vim-airline'
" File search
Plugin 'ctrlpvim/ctrlp.vim'
" Support .lvimrc files in local (project) directory.
Plugin 'embear/vim-localvimrc'
" Add session save/restore support
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
" Show git info next to line numbers
Plugin 'airblade/vim-gitgutter'
" Linting
Plugin 'w0rp/ale'
" Autocomplete
Plugin 'Valloric/YouCompleteMe'
" Javascript syntax highlighting
Plugin 'pangloss/vim-javascript'
" Auto generate CTags
" Plugin 'xolox/vim-easytags'
Plugin 'ludovicchabant/vim-gutentags'
" Tern (javascript) integration
Plugin 'ternjs/tern_for_vim'
" Program structure
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" >>>>>>>>>> BEGIN PLUGIN CONFIG
" Add tabline (buffers as tabs on top)
let g:airline#extensions#tabline#enabled = 1
" Show buffer number in tabline
let g:airline#extensions#tabline#buffer_nr_show = 1
" Work around bug https://github.com/vim-airline/vim-airline/issues/399
autocmd BufDelete * call airline#extensions#tabline#buflist#invalidate()
" Save choice for warning that .lvimrc is being used
let g:localvimrc_persistent = 1
" Shorter command to bring up file browser
command Tree NERDTree
" Locate currently selected file in file browser
"nmap <C-i> :NERDTreeFind<CR>
" File tree show hidden files
let NERDTreeShowHidden = 1
let g:session_autosave = "yes"
let g:session_autoload = 'yes'
" Autoclose autocomplete when pressing ESC
let g:ycm_autoclose_preview_window_after_insertion = 1
" Shortcut: go to definition
nnoremap <F2> :YcmCompleter GoTo<CR>
" Shortcut: search by tag
nmap <leader>t :CtrlPBufTagAll<CR>
" Fix the tag file searched for
set tags=./tags,tags;/
" Use Tern for js go to definition on click
":nnoremap <buffer> <C-LeftMouse> <LeftMouse>:TernDef<CR>
" Use global eslint (required since eslint breaks if project is in Dropbox
" because Dropbox breaks symlinks)
let g:ale_javascript_eslint_use_global = 1
" Integrate linter with status bar
let g:airline#extensions#ale#enabled = 1
" Tell ALEFix command to use eslint
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
" Fix linting errors on save
let g:ale_fix_on_save = 1

" >>>>>>>>>> BEGIN BASE CONFIG
" Enable line numbers
set number
" Enable mouse support
set mouse=a
" Save files when switching between buffers, amongst others (required to prevent ctrlp from
" opening in a new pane for unsaved files).
set autowrite
" Open new vertical splits to the right
set splitright
" Keep a few lines above/below cursor when moving through file
set scrolloff=5
" Set tab width to 4 spaces
set tabstop=4
set shiftwidth=0
" Show whitespace
set list
" Set whitespace character
set listchars=eol:\ ,tab:»\ ,trail:~,extends:>,precedes:<
" Set whitespace character colour
hi SpecialKey ctermfg=00
" Trim whitespace from all files on save
autocmd BufWritePre * %s/\s\+$//e
