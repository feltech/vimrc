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
" Git merge conflict shortcuts (:Conflicted, :GitNextConflict, dgu, dgl)
Plugin 'christoomey/vim-conflicted'
" Extra keyboard shortcuts (e.g. ]q == :cnext)
Plugin 'tpope/vim-unimpaired'
" More intelligent buffer closing (keeps layout)
Plugin 'moll/vim-bbye'
" Enable use of vim 8 aync running of commands
Plugin 'skywind3000/asyncrun.vim'
" Shortcuts to add surrouding quotes, brackets, etc
Plugin 'tpope/vim-surround'
" Snippet support
Plugin 'SirVer/ultisnips'
" Test runners
Plugin 'janko-m/vim-test'
" Python virtualenv support
Plugin 'plytophogy/vim-virtualenv'
" Work/home specific plugins
source ~/.vim/plugins.vim
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" >>>>>>>>>> BEGIN PLUGIN CONFIG
" Enable syntax highlighting
syntax enable
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
" File tree show hidden files
let NERDTreeShowHidden = 1
" Autoclose file browser when file selected
let NERDTreeQuitOnOpen = 1
" Set session file to a hidden file
let g:session_default_name = '.session'
" Set session file directory to working directory.
let g:session_directory = getcwd()
" Auto load/save sessions
let g:session_autosave = "yes"
let g:session_autoload = 'yes'
" Autoclose autocomplete when pressing ESC
let g:ycm_autoclose_preview_window_after_insertion = 1
" Autoload autocompletion config in project
let g:ycm_confirm_extra_conf = 0
" Have autocomplete also use ctags
let g:ycm_collect_identifiers_from_tags_files = 1
" Disable YCM's diagnostics - ALE will do that instead
let g:ycm_show_diagnostics_ui = 0
" Fix the tag file searched for
set tags=./tags,tags;/
" Add cscope module to auto tag generation
let g:gutentags_modules = ['gtags_cscope']
" Enable trace logging for gutentags
"let g:gutentags_trace = 1
" Use global eslint (required since eslint breaks if project is in Dropbox
" because Dropbox breaks symlinks)
let g:ale_javascript_eslint_use_global = 1
" Integrate linter with status bar
let g:airline#extensions#ale#enabled = 1
" Tolerate block comments with space after tab, i.e /** -style.
let g:airline#extensions#whitespace#mixed_indent_algo = 1
" Tell ALEFix command to use eslint
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
" Fix linting errors on save
let g:ale_fix_on_save = 1
" Close tag sidebar when item selected
let g:tagbar_autoclose = 1
" Show diffs in vertical split rather than horizontal.
set diffopt+=vertical
" Set snippets save directory for :UltiSnipEdit (must be somewhere on search  path)
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
" Set snippet expansion trigger (conflicts with YouCompleteMe otherwise)
let g:UltiSnipsExpandTrigger = "<c-j>"
" Show git history
command Ghist silent Glog -100 -- | cwindow
" Show git status in new tab
command Gtabstatus tab split | Gstatus | wincmd o
" Shortcut: close buffer and switch to previous
command Bd Bdelete
" Shorter command to bring up file browser
command Tree NERDTree
" Shortcut: open tag sidebar
map <F10> :Tagbar<CR>
" Use Tern for js go to definition on click
":nnoremap <buffer> <C-LeftMouse> <LeftMouse>:TernDef<CR>
" Shortcut: open file browser
map <F9> :NERDTreeToggle<CR>
" Shortcut: search tags in current buffer
nmap <leader>o :CtrlPBufTag<CR>
" Shortcut: search all tags in project
nmap <leader>ta :CtrlPTag<CR>
" Shortcut: search tags in all open files
nmap <leader>tb :CtrlPBufTagAll<CR>
" Shortcut: go to definition
nnoremap <F2> :YcmCompleter GoTo<CR>
" Use nosetests as the python test runner.
let test#python#runner = 'nose'
" Make test commands execute using async support in vim 8.
let test#strategy = "asyncrun"
" >>>>>>>>>> BEGIN BASE CONFIG
" Colour scheme (for colourblind)
colorscheme evolution
" Keep command history
set history=1000
" Enable line numbers
set number relativenumber
" Toggle relative numbering off when it doesn't make sense.
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
" Enable mouse support
set mouse=a
" Save files when switching between buffers, amongst others (required to prevent ctrlp from
" opening in a new pane for unsaved files).
set autowriteall
" Open new vertical splits to the right
set splitright
" Keep a few lines above/below cursor when moving through file
set scrolloff=5
" Set tab width to 4 spaces
set tabstop=4
set shiftwidth=4
" Intelligently switch between tabs and spaces for indentation
set smarttab
" Show bar at 100 chars
set colorcolumn=100
highlight ColorColumn ctermbg=darkgray guibg=darkgray
" Highlight search results
set hlsearch
" Show whitespace
set list
" Recursively search using e.g. `find`
set path+=**
" Show all matching files when tab completing
set wildmenu
" Set whitespace character
set listchars=eol:\ ,tab:»\ ,trail:~,extends:>,precedes:<
" Enable built-in autocomplete
"set omnifunc=syntaxcomplete#Complete
" Trim whitespace from all files on save
autocmd BufWritePre * %s/\s\+$//e
" Set whitespace character colour
hi SpecialKey ctermfg=238
augroup pythonindent
  autocmd!
  " Allow tabs in python and display them as 4, not 8, chars
  autocmd FileType python setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
augroup END
" Show file text on final line instead of '@'
set display+=lastline
" Set to auto read when a file is changed from the outside
set autoread
" Jump to search results whilst typing search
set incsearch
" Highlight the cursor line
set cursorline
" Mute the cursor line highlight colours
hi CursorLine ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
" Enable folding by indent (for navigation between blocks)
set foldmethod=syntax
set foldlevelstart=99
" Better matching parens highlight for colourblind eyes
hi MatchParen cterm=bold ctermbg=none ctermfg=green
" Use GNU Global for search by definition
set csprg=gtags-cscope
" Use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetag
" Check cscope for definition of a symbol before checking ctags.
set csto=0
if filereadable("GTAGS")
	cs add GTAGS
" else add the database pointed to by environment variable
elseif $CSCOPE_DB != ""
	cs add $CSCOPE_DB
endif
" show msg when any other cscope db added
set cscopeverbose
" Shortcut: keybindings for cscope
nmap <leader>ts :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>tj :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>tc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>tt :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>te :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>tf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>ti :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>td :cs find d <C-R>=expand("<cword>")<CR><CR>
" Use quickfix window for cscope results. Clear previous results before the search.
set cscopequickfix=g-,s-,c-,f-,i-,t-,d-,e-
" Shortcut: insert a single character (rather than replace as with 'r')
nmap <silent> <space> "=nr2char(getchar())<cr>P
" Shortcut: binding for vim-test
nmap <silent> tn :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
nmap <silent> ts :TestSuite<CR>
nmap <silent> tl :TestLast<CR>
nmap <silent> tg :TestVisit<CR>
" Shortcut: grep recursively
command -nargs=1 Grep silent execute 'grep -Er <args> *' | redraw! | copen
" Close buffers not open in any window (https://stackoverflow.com/a/30101152/535103)
function! DeleteHiddenBuffers()
  let tpbl=[]
  let closed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let closed += 1
    endif
  endfor
  echo "Closed ".closed." hidden buffers"
endfunction
command Bdh call DeleteHiddenBuffers()
