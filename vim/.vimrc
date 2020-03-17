call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'protocolbuffers/protobuf', {'rtp': '/editors/'}
Plug 'hashivim/vim-terraform'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
call plug#end()

"
" Settings
"

let mapleader = ","
let g:mapleader = ","

syntax enable
filetype plugin indent on

set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

set number
set relativenumber
set noerrorbells
set showcmd
set hidden
set noshowmatch
set noshowmode
set ignorecase
set smartcase
set updatetime=300
set pumheight=10
set clipboard^=unnamed
set clipboard^=unnamedplus
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set expandtab
set softtabstop=4
set shiftwidth=4
set nrformats-=octal
set incsearch
set hlsearch
set laststatus=2
set ruler
set wildmenu
set wildmode=full
set scrolloff=5
set display+=lastline
set encoding=utf-8
set autowrite
set autoread
set fileformats=unix,dos,mac
set undofile
set signcolumn=yes
set notimeout
set ttimeout
set ttimeoutlen=100
set ttyfast
set lazyredraw
set list
set listchars=tab:\|\ ,
set colorcolumn=80
"set re=1

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_dirhistmax=0


set formatoptions+=1
if has('patch-7.3.541')
  set formatoptions+=j
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &history < 1000
  set history=1000
endif

if &tabpagemax < 50
  set tabpagemax=50
endif

if !empty(&viminfo)
    set viminfo^=!
endif

set sessionoptions-=options
set viewoptions-=options

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if has('mouse')
  set mouse=a
  set ttymouse=sgr
endif

colorscheme nord

imap jk <ESC>l

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>c :cclose<bar>lclose<cr>

" ----------------------------------------------------------------------------
" Statusline
" ----------------------------------------------------------------------------
"
function! CocErrors()
  let info = get(b:, 'coc_diagnostic_info', {})
  let msgs = []
  if get(info, 'error', 0)
    return 'E:' . info['error'].'(L'.info['lnums'][0].')'
  endif
  return ''
endfunction

function! CocWarnings()
  let info = get(b:, 'coc_diagnostic_info', {})
  let msgs = []
  if get(info, 'warning', 0)
    return 'W:' . info['warning'].'(L'.info['lnums'][1].')'
  endif
  return ''
endfunction

function! CocStatus()
  return get(g:, 'coc_status', '')
endfunction

let g:lightline = {'colorscheme': 'nord'}

let g:lightline.active = {
            \ 'left': [
            \  [ 'mode', 'paste' ],
            \  [ 'readonly', 'filename', 'modified', 'gitbranch' ],
            \ ],
            \ 'right': [
            \   [ 'cocerrors', 'cocwarnings', 'cocstatus', 'currentfunction'],
            \   [ 'lineinfo' ],
            \   [ 'filetype' ],
            \ ]
            \ }

let g:lightline.inactive = {
            \ 'left': [
            \  [],
            \  [ 'filename' , 'modified' ]
            \ ],
            \ 'right': [
            \   [ 'lineinfo' ],
            \   [ 'fileformat' ],
            \ ]
            \ }

let g:lightline.tabline = {
            \ 'left': [ [ 'tabs' ] ],
            \ 'right': [ ]
            \ }

let g:lightline.tab = {
            \ 'active': [ 'tabnum', 'filename', 'modified' ],
            \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }

let g:lightline.component = {
            \ 'lineinfo': '%2p%% %3l:%-2v',
            \ }

let g:lightline.component_function = {
            \ 'gitbranch': 'FugitiveHead',
            \ 'currentfunction': 'CocCurrentFunction',
            \ }

let g:lightline.component_expand = {
            \ 'cocerrors': 'CocErrors',
            \ 'cocwarnings': 'CocWarnings',
            \ 'cocstatus': 'CocStatus',
            \ }

let g:lightline.component_type = {
            \ 'cocerrors': 'error',
            \ 'cocwarnings': 'warning',
            \ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" ----------------------------------------- "
" File Type settings 			    		"
" ----------------------------------------- "

au BufNewFile,BufRead *.go setlocal noexpandtab softtabstop=8 shiftwidth=8
au BufNewFile,BufRead *.vim setlocal noexpandtab softtabstop=4 shiftwidth=4 
au BufNewFile,BufRead *.txt setlocal noexpandtab softtabstop=4 shiftwidth=4
au BufNewFile,BufRead *.md setlocal noexpandtab softtabstop=4 shiftwidth=4 spell 
au BufNewFile,BufRead *.yml,*.yaml setlocal expandtab softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.cpp setlocal expandtab softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.hpp setlocal expandtab softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.json setlocal expandtab softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.jade setlocal expandtab softtabstop=2 shiftwidth=2
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
au BufNewFile,BufReadPost *.md setl shiftwidth=4 softtabstop=4 expandtab
au BufNewFile,BufRead *.py setlocal  expandtab softtabstop=4 shiftwidth=4 textwidth=80
au FileType dockerfile set noexpandtab
au FileType gitcommit setlocal spell

" ----------------------------------------- "
" Plugin configs 			    			"
" ----------------------------------------- "

" ==================== CoC  ====================

set nobackup
set nowritebackup
set shortmess+=c
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

command! -nargs=0 Format :call CocAction('format')

" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" ==================== Vim-go ====================

let g:go_gopls_options = ['-remote=auto']

let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"

let g:go_autodetect_gopath = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint']

let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1

au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>l <Plug>(go-metalinter)

au FileType go nmap <leader>r  <Plug>(go-run)
au FileType go nmap <leader>b  <Plug>(go-build)
au FileType go nmap <leader>t  <Plug>(go-test)
au FileType go nmap <leader>dt  <Plug>(go-test-compile)
au FileType go nmap <Leader>d <Plug>(go-doc)

au FileType go nmap <Leader>rn <Plug>(go-rename)

" I like these more!
augroup go
  autocmd!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

" ==================== delimitMate ====================
"let g:delimitMate_expand_cr = 1
"let g:delimitMate_expand_space = 1
"let g:delimitMate_smart_quotes = 1
"let g:delimitMate_expand_inside_quotes = 0
"let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

"==================== NerdTree ====================
" For toggling
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

nmap <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ========= vim-markdown ==================

" disable folding
let g:vim_markdown_folding_disabled = 1

" Allow for the TOC window to auto-fit when it's possible for it to shrink.
" It never increases its default size (half screen), it only shrinks.
let g:vim_markdown_toc_autofit = 1

" Disable conceal
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" Allow the ge command to follow named anchors in links of the form
" file#anchor or just #anchor, where file may omit the .md extension as usual
let g:vim_markdown_follow_anchor = 1

" highlight frontmatter
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

" vim:set ft=vim et sw=2 sts=2:
