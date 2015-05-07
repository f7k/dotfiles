"
" WARNING!
"
" I'm a VIM starter so don't use parts of this configuration, it can be broken.
"

"
" Basic options
"
set noeb vb t_vb=
set autowrite
set autowriteall
set nobackup
set noswapfile
set encoding=utf-8
set autoindent
set copyindent
set nowrap
set number
set diffopt+=vertical
set splitbelow
set splitright
set foldlevel=99
set foldmethod=syntax
set backspace=indent,eol,start
set expandtab
set shiftwidth=4
set smarttab
set tabstop=4
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

"
" Autocomplete filenames
"
set wildmenu
set wildmode=longest:full,full
set wildignore+=.git
set wildignore+=*.bmp,*.gif,*.jpeg,*.jpg,*.png
set wildignore+=*.orig

"
" Syntax and filetypes
"
syntax enable

filetype plugin indent on

au Syntax markdown setlocal wrap linebreak nolist nofoldenable colorcolumn=80

au Filetype coffee     setlocal ts=2 sw=2
au Filetype cucumber   setlocal ts=2 sw=2
au Filetype html*      setlocal ts=2 sw=2
au Filetype javascript setlocal ts=2 sw=2
au Filetype json       setlocal ts=2 sw=2
au Filetype ruby       setlocal ts=2 sw=2
au Filetype vim        setlocal ts=2 sw=2
au Filetype racc       setlocal ts=2 sw=2
au Filetype yaml       setlocal ts=2 sw=2

au BufNewFile,BufRead .bowerrc       set filetype=json
au BufNewFile,BufRead .jshintrc      set filetype=json
au BufNewFile,BufRead .vagrant-shell set filetype=sh
au BufNewFile,BufRead *.ejs          set filetype=html
au BufNewFile,BufRead *.es6          set filetype=javascript
au BufNewFile,BufRead *.md           set filetype=markdown
au BufNewFile,BufRead *.reek         set filetype=yaml

"
" Keyboard layout
"
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

"
" Color scheme
"
colorscheme bubblegum-256-dark

set t_Co=256
set cursorline
set colorcolumn=120

hi clear CursorLine
augroup CLClear
  au! ColorScheme * hi clear CursorLine
augroup END

"
" Plugins
"
source ~/.vimrc.bundles

" Airline
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:airline_theme='bubblegum'
let g:airline#extensions#branch#enabled=1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''

" Handlebars
let g:mustache_abbreviations=1

" Instant Markdown
let g:instant_markdown_autostart=0
let g:instant_markdown_browser="google-chrome"

" NERDTree
let NERDTreeDirArrows=0
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeWinSize=50
let NERDTreeIgnore=['\.git$']

au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | let g:nerdtree_tabs_open_on_console_startup = 1 | endif

command! RefreshNERDTree call RefreshNerdTree()

" Sessions
let g:session_autosave='no'

" Syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=1
let g:syntastic_cucumber_checkers=[""]

" TagList
let Tlist_Compact_Format=1
let Tlist_WinWidth=50
let Tlist_Use_Right_Window=1

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"
" Functions
"

" Incrementing selected number
function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction

" Refreshing NERDTree root
function! RefreshNerdTree()
  if g:NERDTree.ExistsForTab()
    let curbufnr = bufnr('%')
    exec bufwinnr(bufnr("NERD*")) . " wincmd w"
    exec "normal R"
    exec bufwinnr(curbufnr) . " wincmd w"
  endif
endfunction

"
" Mappings (global)
"
let mapleader = ","
set pastetoggle=<F12>

"
" Mappings (normal mode)
"
noremap <f3>  :Autoformat<cr>
noremap <f4>  :TlistToggle<cr>
noremap <f5>  :RefreshNERDTree<cr>
noremap <f10> :setlocal spell! spelllang=ru_yo,en_us<cr>
noremap <f11> <nop>
noremap <tab> %
noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>
noremap <silent> <C-n> :NERDTreeTabsToggle<cr>

" Quicker window movement
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" Quicker window resizing
noremap <leader>v+ :vertical resize +10<cr>
noremap <leader>v- :vertical resize -10<cr>
noremap <leader>h+ :resize +10<cr>
noremap <leader>h- :resize -10<cr>

" Gemfile
noremap <leader>gf  :e Gemfile<cr>
noremap <leader>sgf :sp Gemfile"<cr>
noremap <leader>vgf :vsp Gemfile<cr>

" Markdown
noremap <leader>mkd :InstantMarkdownPreview<cr>

" RSpec
noremap <leader>t :call RunCurrentSpecFile()<cr>
noremap <leader>s :call RunNearestSpec()<cr>
noremap <leader>l :call RunLastSpec()<cr>
noremap <leader>a :call RunAllSpecs()<cr>

"
" Mappings (insert mode)
"

" Change keyboard layout
imap <silent> <c-f> <c-^>

"
" Mappings (others)
"
vnoremap <leader>inc :call Incr()<cr>

"
" Auto commands
"

" Remove trailing whitespace when saving
au  BufWritePre * %s/\s\+$//e

" Autoreload .vimrc
au! BufWritePost .vimrc source %

" Resize splits when the window is resized
au VimResized * :wincmd =
