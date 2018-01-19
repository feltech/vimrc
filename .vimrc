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
" Autocomplete. NOTE requires building in bundle dir.
Plugin 'Valloric/YouCompleteMe'
" Javascript syntax highlighting
Plugin 'pangloss/vim-javascript'
" Auto generate CTags
" Plugin 'xolox/vim-easytags'
Plugin 'ludovicchabant/vim-gutentags'
" Tern (javascript) integration. NOTE requires `npm install` in bundle dir.
Plugin 'ternjs/tern_for_vim'
" Program structure
Plugin 'majutsushi/tagbar'
" Git integration
Plugin 'tpope/vim-fugitive'
" Extra keyboard shortcuts (e.g. ]q == :cnext)
Plugin 'tpope/vim-unimpaired'
" Work/home specific plugins
source ~/.vim/plugins.vim
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" >>>>>>>>>> BEGIN PLUGIN CONFIG
" Add tabline (buffers as tabs on top)
let g:airline#extensions#tabline#enabled = 1
" Show buffer number in tabline
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
" Enable icons.
let g:airline_powerline_fonts=1
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
" Autoload autocompletion config in project
let g:ycm_confirm_extra_conf = 0
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
" Show git history
command Ghist silent Glog -100 -- | cwindow

" >>>>>>>>>> BEGIN BASE CONFIG
" Shortcut: close buffer and switch to previous
command Bd bp|bd#
" Colour scheme (for colourblind)
colorscheme evolution
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
" Intelligently switch between tabs and spaces for indentation
set smarttab
" Show bar at 100 chars
set textwidth=100
set colorcolumn=100
highlight ColorColumn ctermbg=darkgray guibg=darkgray
" Highlight search results
set hlsearch
" Show whitespace
set list
" Set whitespace character
set listchars=eol:\ ,tab:»\ ,trail:~,extends:>,precedes:<
" Trim whitespace from all files on save
autocmd BufWritePre * %s/\s\+$//e
" Set whitespace character colour
hi SpecialKey ctermfg=00
" Allow tabs in python and display them as 4, not 8, chars
autocmd FileType python setlocal noexpandtab shiftwidth=0 softtabstop=4 tabstop=4
" Show file text on final line instead of '@'
set display+=lastline
" Set to auto read when a file is changed from the outside
set autoread
" Jump to search results whilst typing search
set incsearch
" Highlight the cursor line
set cursorline
