" vim : foldmethod=marker :
" AUTHOR: Vicente Adolfo Bolea Sanchez
" Dependencies:
"  - It requires to have the following env variables:
"    2. $GIT_AUTHOR_NAME
"
" Quick Predefined leader Maps
" ============================
"
" [a] -> :A
" [s] -> :Git
" [d] -> :Gdiff
" [t] -> :tabnew
" [T] -> :tabdel

" Bundle {{{
set nocp

" Legacy options for version before Vim 8
let b:legacy_file = $HOME . "/.vimrc.legacy"
if filereadable(b:legacy_file)
  execute "source" . b:legacy_file
endif

" }}}
" Essentials {{{
" We drink from the defaults of vim
if filereadable($VIMRUNTIME . "/defaults.vim")
  source $VIMRUNTIME/defaults.vim
else
  set incsearch showcmd wildmenu
endif

" }}}
" Interface settings {{{
"## COLORSCHEME
set term=screen-256color
set background=dark

"## BASE16
try
  let g:solarized_contrast = "high"
  colorscheme solarized
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
else
  hi Folded ctermbg=16
endif
catch
endtry

"Correct broken redraw
set ttyfast
set noerrorbells
set novisualbell
set lazyredraw

" More options
set hlsearch
set wildignore=*.o,*.class,*.pyc
set path+=**
set hidden  " Useful feature, to have multiples buffer open
set mouse=a
"set cursorline
match Error /{{{\|}}}/
set exrc

"Long wrapped line
set showbreak= 
"Set backup off since we are always using git :D
set noswapfile
set nobackup
set nowritebackup

"Indentation
set shiftwidth=2
set expandtab
set tabstop=2
set backspace=2
set foldmethod=marker
set cino=N-s

if v:version >= 800
  set breakindent
endif

" }}}
" filetype settings {{{
autocmd FileType html setlocal sw=2 ts=2 noexpandtab autoindent
autocmd FileType Makefile setlocal sw=2 ts=2 noexpandtab
autocmd FileType java setlocal sw=4 ts=4 expandtab
autocmd FileType Python setlocal sw=2 ts=2 expandtab

autocmd FileType html,markdown,rst,txt,tex setlocal textwidth=80 colorcolumn=81 spell
autocmd BufEnter,BufNew *.log setlocal nowrap

augroup tabsPolicy
  autocmd!
  autocmd BufEnter,BufNew *.tsv setlocal noexpandtab tabstop=6 sw=6
  autocmd BufEnter,BufNew *.tsv,Makefile,*.make,*.html :let b:SuperTabDisabled=1
  autocmd BufEnter,BufNew *.tsv,Makefile,*.make,*.html :silent! iunmap <Tab>
augroup end

highlight BadWhitespace ctermbg=red guibg=darkred
autocmd BufRead,BufNewFile * match BadWhitespace /\s\+$/
" }}}
"Key-binding {{{
" ---------------------------------------------------------------------
let mapleader = " "

" This is VIM we don't need arrow keys
noremap  <Up>     <NOP>
noremap  <Down>   <NOP>
noremap  <Left>   <NOP>
noremap  <Right>  <NOP>
nnoremap Q <Nop>

" Tabs
" nnoremap <silent> <F2> :tabprevious<Enter>
" nnoremap <silent> <F3> :tabnext<Enter>
" nnoremap <silent> <F4> :tabnew<Enter>
" nnoremap <silent> <C-h> :tabprevious<cr>
" nnoremap <silent> <C-l> :tabnext<cr>

nnoremap <silent> <C-S-k> :tabprevious<Enter>
nnoremap <silent> <C-S-j> :tabnext<Enter>

nnoremap <silent> <F5> :!ctags -f .tags -R -Q **/*.c **/*.cpp **/*.h<Enter>
nnoremap <silent> <F8> :TagbarToggle<Enter>
nnoremap <silent> <F9> :NERDTreeToggle<Enter>
try
call togglebg#map("<F7>")
catch
endtry

"Customized shortcuts
"nnoremap <silent><leader>a :A<CR>
"nnoremap <silent><leader>d :Gdiff<CR>
"nnoremap <silent><leader>T :tabclose<CR>
"nnoremap <silent><leader>t :tabnew<CR>

"Great map which saves the file in sudo mode, something like `sudo !!`
cnoremap w!! w !sudo tee >/dev/null %

ab W w
ab Wq wq
ab wQ wq
ab WQ wq
ab Q q
ab WQA wqa
ab Wqa wqa

" let g:tmux_navigator_no_mappings = 1
" 
" nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
" 
"}}}
"Status line (Powerline) {{{
" ---------------------------------------------------------------------

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

if has('python3')
  try
    python3 from powerline.vim import setup as powerline_setup
    python3 powerline_setup()
    python3 del powerline_setup
  catch
  endtry
endif

"}}}
"vim-plug {{{
" --------------------------------------------------------------------
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
"  Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
Plug 'tpope/vim-surround'
Plug 'preservim/vimux'
" Key-binding
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-unimpaired'

" Initialize plugin system
call plug#end()
"}}}
"vim-airline {{{
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='powerlineish'
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#branch#format = 2
let g:airline_skip_empty_sections = 1
let g:airline_section_y = 0
let g:airline#extensions#whitespace#enabled = 0

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
"}}}
"NERDTree "{{{
" ---------------------------------------------------------------------
let g:NERDChristmasTree = 1
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeDirArrows = 0
" }}}
"SuperTab | utisnipts {{{
"let g:UltiSnipsExpandTrigger        = "<C-j>"
"let g:UltiSnipsJumpForwardTrigger   = "<C-k>"
"let g:UltiSnipsJumpBackwardTrigger  = "<C-M-k>"
"let g:SuperTabDefaultCompletionType = "<C-P>"
"}}}
" Signature {{{
let g:snips_author = $GIT_AUTHOR_NAME
" }}}
" Fugitive {{{
set diffopt+=vertical
" }}}
" CtrlP {{{
let g:ctrlp_by_filename = 1
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_extensions = ['tag', 'quickfix']
let g:ctrlp_mruf_relative = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
" }}}
" Local Config {{{
if filereadable($HOME . "/.vimrc.local")
  autocmd BufLeave .vimrc.local normal! mV
  source $HOME/.vimrc.local
endif
" }}}
