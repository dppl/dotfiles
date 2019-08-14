call plug#begin('~/.local/share/nvim/plugged')

" Completion / Linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'

" Languages
Plug 'fatih/vim-go', {'for' : 'go'}

" Syntax
Plug 'vim-python/python-syntax', {'for' : 'python'}
Plug 'chemzqm/vim-jsx-improve', {'for' : 'javascript'}
Plug 'cespare/vim-toml', {'for' : 'toml'}
Plug 'stephpy/vim-yaml', {'for' : 'yaml'}
Plug 'plasticboy/vim-markdown', {'for' : 'markdown'}
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/', 'for' : 'dockerfile'}
Plug 'elzr/vim-json' , {'for' : 'json'}

" tpope
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

" Util
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'

" Themes
Plug 'arcticicestudio/nord-vim'

call plug#end()

set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin indent on     " required

"=====================================================
"===================== SETTINGS ======================

let g:python_host_prog='/Users/dappel/.local/share/virtualenvs/neovim2-GXHv1prk/bin/python'
let g:python3_host_prog='/Users/dappel/.local/share/virtualenvs/neovim3-toqV01_M/bin/python'
let g:python_highlight_all = 1

set laststatus=2
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically reread changed files without asking me anything
set autoindent
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set mouse=a                     "Enable mouse mode
set signcolumn=yes
set cmdheight=2
set noruler
set clipboard=unnamed

set noerrorbells             " No beeps
set number                   " Show line numbers
set relativenumber
set showcmd                  " Show me what I'm typing
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set hidden
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set noshowmatch              " Do not show matching brackets by flickering
set noshowmode               " We show the mode with airline or lightline
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case
set completeopt=menu,menuone
set nocursorcolumn           " speed up syntax highlighting
set cursorline
set updatetime=300
set pumheight=10             " Completion window max size

set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion

set lazyredraw

" increase max memory to show syntax highlighting for large files
set maxmempattern=20000
set viminfo='1000

set wrap
set textwidth=79
set display+=lastline


au FocusLost * :wa              " Set vim to save the file on focus out.

if has('mouse')
  set mouse=a
endif

syntax on
set termguicolors

let g:nord_underline = 1
color nord
" let g:material_terminal_italics = 1
" let g:material_theme_style = 'darker'
" colorscheme material

"=====================================================
"===================== MAPPINGS ======================

" This comes first, because we have mappings that depend on leader
" With a map leader it's possible to do extra key combinations
" i.e: <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Some useful quickfix shortcuts for quickfix
map <C-n> :cn<CR>
map <C-m> :cp<CR>
nnoremap <leader>a :cclose<CR>

" put quickfix window always to the bottom
augroup quickfix
  autocmd!
  autocmd FileType qf wincmd J
  autocmd FileType qf setlocal wrap
augroup END

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

" Automatically resize screens to be equally the same
" autocmd VimResized * wincmd =

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<CR>

" Center the screen
nnoremap <space> zz

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" Just go out in insert mode
imap jk <ESC>l

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Act like D and C
nnoremap Y y$

" trim all whitespaces away
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Act like D and C
nnoremap Y y$

" Do not show stupid q: window
map q: :q

map :Vs :vs
map :Sp :sp

" dont save .netrwhist history
let g:netrw_dirhistmax=0

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" set 80 character line limit
"if exists('+colorcolumn')
"  set colorcolumn=80
"else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif

com! -nargs=1 -complete=file Breplace edit <args>| bdelete #

function! DeleteInactiveBufs()
  "From tabpagebuflist() help, get a list of all buffers in all tabs
  let tablist = []
  for i in range(tabpagenr('$'))
    call extend(tablist, tabpagebuflist(i + 1))
  endfor

  "Below originally inspired by Hara Krishna Dara and Keith Roberts
  "http://tech.groups.yahoo.com/group/vim/message/56425
  let nWipeouts = 0
  for i in range(1, bufnr('$'))
    if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
      "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
      silent exec 'bwipeout' i
      let nWipeouts = nWipeouts + 1
    endif
  endfor
  echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

command! Ball :call DeleteInactiveBufs()

nnoremap <leader>qf :copen<CR>

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Buffer prev/next
nnoremap <C-x> :bnext<CR>
nnoremap <C-z> :bprev<CR>

"=====================================================
"================ FILE TYPE SETTINGS =================
augroup filetypedetect
  command! -nargs=* -complete=help Help vertical belowright help <args>
  autocmd FileType help wincmd L
  autocmd FileType markdown setl conceallevel=0

  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.hcl setf conf
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.cpp setlocal expandtab ts=4 sw=4 colorcolumn=100 textwidth=99
  autocmd BufNewFile,BufRead *.hpp setlocal expandtab ts=4 sw=4
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80 smarttab expandtab

  autocmd BufRead,BufNewFile *.gotmpl set filetype=gotexttmpl

  autocmd BufNewFile,BufRead *.ino setlocal noet ts=4 sw=4 sts=4
  autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.html setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.proto setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.js,*.jsx,*.ts,*.tsx setlocal tabstop=2 shiftwidth=2 smarttab expandtab

  autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufReadPost *.tsx setfiletype typescript.tsx
  autocmd BufNewFile,BufReadPost *.jsx setfiletype javascript.jsx
augroup END

set wildmenu
set wildmode=list:full

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=go/pkg                           " Go static files
set wildignore+=go/bin                           " Go bin files
set wildignore+=go/bin-vagrant                   " Go bin-vagrant files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files


"=====================================================
"====================== PLUGINS ======================
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" ==================== Fugitive ====================
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
vnoremap <leader>gb :Gblame<CR>

"==================== NerdTree ====================
" For toggling
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden = 1

let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '.DS_Store']

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ==================== gitgutter ====================
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_max_signs = 1500
let g:gitgutter_diff_args = '-w'

"highlight clear SignColumn
highlight GitGutterAdd ctermfg=green ctermbg=0
highlight GitGutterChange ctermfg=yellow ctermbg=0
highlight GitGutterDelete ctermfg=red ctermbg=0
highlight GitGutterChangeDelete ctermfg=red ctermbg=0

" ==================== vim-json ====================
let g:vim_json_syntax_conceal = 0

" ==================== Completion =========================

set nobackup
set nowritebackup
set updatetime=100
set shortmess+=c

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)


" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

let g:ale_linters = {
      \   'go': ['golint', 'govet'],
      \}
let g:ale_fixers = {
      \   'go': ['goimports'],
      \}

" ==================== vim-go ====================
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_term_enabled = 1
let g:go_snippet_engine = "ultisnips"

let g:go_fmt_autosave = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 0
let g:go_highlight_functions = 1



autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)

" neovim specific
if has('nvim')
  au FileType go nmap <leader>rt <Plug>(go-run-tab)
  au FileType go nmap <Leader>rs <Plug>(go-run-split)
  au FileType go nmap <Leader>rv <Plug>(go-run-vertical)
endif

" I like these more!
augroup go
  autocmd!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

" ==================== utilsnips ====================
let g:SuperTabDefaultCompletionType = "context"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" =================== status line ========================
let g:lightline = {}
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.active = { 
      \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \              [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ }

" let g:lightline.colorscheme = 'material_vim'
let g:lightline.colorscheme = 'nord'

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
" vim:ts=2:sw=2:et
