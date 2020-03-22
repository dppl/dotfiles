" ----------------------------------------------------------------------------
" Plugins
" ----------------------------------------------------------------------------
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'SirVer/ultisnips'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'plasticboy/vim-markdown'
Plug 'hashivim/vim-terraform'
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'protocolbuffers/protobuf', {'rtp': '/editors/'}
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
call plug#end()

" ----------------------------------------------------------------------------
" Settings
" ----------------------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","

syntax enable
filetype plugin indent on

if has('nvim')
  let g:python_host_prog='/usr/bin/python2'
  let g:python3_host_prog='/usr/local/bin/python3'
endif


set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

set number
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
set list listchars=tab:»\ ,trail:·,nbsp:.
set nobackup
set nowritebackup
set shortmess+=c

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
endif

if !has('nvim')
  set ttymouse=sgr
endif

colorscheme nord

imap jk <ESC>l

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>c :cclose<bar>lclose<CR>

" ----------------------------------------------------------------------------
" Statusline
" ----------------------------------------------------------------------------

" Nord
hi StatusLine ctermbg=0  guibg=#3B4252 guifg=#D8DEE9
hi StatusLineNC ctermbg=0  guibg=#3B4252 guifg=#D8DEE9

hi StatusLineBase ctermbg=0 ctermfg=15 guibg=#3B4252 guifg=#D8DEE9
hi StatusLineBaseNC ctermbg=0 ctermfg=15 guibg=#3B4252 guifg=#D8DEE9

hi CocStatusColor cterm=bold ctermbg=0 ctermfg=1 guibg=#3B4252 guifg=#BF616A
hi GitInfoColor ctermbg=0 ctermfg=15 guibg=#3B4252 guifg=#D8DEE9

hi LineInfoColor ctermbg=0 ctermfg=15 guibg=#3B4252 guifg=#D8DEE9

let s:modes={
  \'n' : 'Normal',
  \'no' : 'N-Operator Pending',
  \'v' : 'Visual',
  \'V' : 'V-Line',
  \'^V' : 'V-Block',
  \'s' : 'Select',
  \'S': 'S-Line',
  \'^S' : 'S-Block',
  \'i' : 'Insert',
  \'R' : 'Replace',
  \'Rv' : 'V-Replace',
  \'c' : 'Command',
  \'cv' : 'Vim Ex',
  \'ce' : 'Ex',
  \'r' : 'Prompt',
  \'rm' : 'More',
  \'r?' : 'Confirm',
  \'!' : 'Shell',
  \'t' : 'Terminal'
  \}

function! CurrentMode() abort
  let l:currentMode =toupper(get(s:modes, mode(), 'NORMAL'))
  if l:currentMode == 'NORMAL'
    hi ModeColor cterm=bold ctermbg=0 ctermfg=4 guibg=#3B4252 guifg=#88C0D0
  elseif currentMode == 'INSERT'
    hi ModeColor cterm=bold ctermbg=0 ctermfg=2 guibg=#3B4252 guifg=#A3BE8C
  elseif currentMode == "VISUAL" || currentMode == "V-LINE" || currentMode == "V-BLOCK"
    hi ModeColor cterm=bold ctermbg=0 ctermfg=3 guibg=#3B4252 guifg=#B48EAD
  else
    hi ModeColor cterm=bold ctermbg=0 ctermfg=4 guibg=#3B4252 guifg=#8FBCBB
  endif
  return currentMode
endfunction

function! FileInfo() abort
  let l:filename =  '' != expand('%:F') ? expand('%:F') : '[No Name]'
  if !&modifiable
    hi FileInfoColor cterm=bold ctermbg=0 ctermfg=1 guibg=#3B4252 guifg=#BF616A
    return l:filename . ' [-]'
  endif

  if &modified
    hi FileInfoColor ctermbg=0 ctermfg=8 guibg=#3B4252 guifg=#EBCB8B
    return l:filename . ' [+]'
  else
    hi FileInfoColor ctermbg=0 guibg=#3B4252 guifg=#D8DEE9
    return l:filename
  endif
endfunction

function! GitInfo() abort
  let l:branch = FugitiveHead()
  if l:branch == ''
    return ''
  else
    return '| ' . l:branch
  endif
endfunction

function! FileType()
  if &filetype == ''
    return '-'
  else
    return &filetype
  endif
endfunction

function! LinePercent()
  return (100 * line('.') / line('$')) . '%'
endfunction

function! CocStatus() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E:' . info['error'].'(L'.info['lnums'][0].')')
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W:' . info['warning'].'(L'.info['lnums'][1].')')
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', ''). ' '
endfunction

function! ActiveStatusline()
  let statusline=''
  let statusline.='%#ModeColor#'
  let statusline.=' %{CurrentMode()} '

  let statusline.='%#FileInfoColor#'
  let statusline.=' %{FileInfo()}'

  let statusline.='%#GitInfoColor#'
  let statusline.=' %{GitInfo()}'

  let statusline.='%#StatuslineBase#'
  let statusline.='%='

  let statusline.='%#CocStatusColor#'
  let statusline.='%{CocStatus()} '

  let statusline.='%#LineInfoColor#'
  let statusline.=' %{FileType()}'

  let statusline.='%#StatuslineBase#'
  let statusline.=' | '

  let statusline.='%#LineInfoColor#'
  let statusline.='%{LinePercent()} %l:%v %*'

  return statusline
endfunction

function! InactiveStatusline()
  let statusline=''
  let statusline.='%#FileInfoColor#'
  let statusline.=' %{FileInfo()}'
  let statusline.='%#StatuslineBaseNC#'
  let statusline.='%='
  let statusline.='%#LineInfoColor#'
  let statusline.='%{FileType()}'

  return statusline
endfunction

function! NERDLine()
  return ''
endfunction

augroup Statusline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveStatusline()
  autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveStatusline()
  autocmd FileType nerdtree setlocal statusline=%!NERDLine()
augroup END

" ----------------------------------------------------------------------------
" TabLine
" ----------------------------------------------------------------------------
hi TabLine ctermbg=8 guibg=#2E3440 guifg=#616E88
hi TabLineSel ctermbg=8 guibg=#2E3440 guifg=#88C0D0
hi TabLineFill ctermbg=8 guibg=#2E3440 guifg=#BF616A

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

" ----------------------------------------------------------------------------
" File Type settings
" ----------------------------------------------------------------------------
augroup fileTypes
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab softtabstop=8 shiftwidth=8
  autocmd BufNewFile,BufRead *.vim setlocal noexpandtab softtabstop=4 shiftwidth=4 
  autocmd BufNewFile,BufRead *.txt setlocal noexpandtab softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.md setlocal noexpandtab softtabstop=4 shiftwidth=4 spell 
  autocmd BufNewFile,BufRead *.yml,*.yaml setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.cpp setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.hpp setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.json setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.jade setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
  autocmd BufNewFile,BufReadPost *.md setl shiftwidth=4 softtabstop=4 expandtab
  autocmd BufNewFile,BufRead *.py setlocal  expandtab softtabstop=4 shiftwidth=4 textwidth=80
  autocmd FileType dockerfile set noexpandtab
  autocmd FileType gitcommit setlocal spell
augroup END

" ----------------------------------------------------------------------------
" coc
" ----------------------------------------------------------------------------
let g:coc_global_extensions = [ 'coc-yaml', 'coc-clangd', 'coc-json',
  \ 'coc-lists', 'coc-snippets', 'coc-python']

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" ----------------------------------------------------------------------------
" vim-go
" ----------------------------------------------------------------------------

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

" I like these more!
augroup go
  autocmd!
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
  
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <leader>b  <Plug>(go-build)
  autocmd FileType go nmap <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <leader>dt  <Plug>(go-test-compile)
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)
  
  autocmd FileType go nmap <Leader>rn <Plug>(go-rename)

  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

" ----------------------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------------------
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

nmap <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ----------------------------------------------------------------------------
" vim-markdown
" ----------------------------------------------------------------------------

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

" ----------------------------------------------------------------------------
" FZF
" ----------------------------------------------------------------------------
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

augroup FZF
if has('nvim')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif
augroup END

" vim:set ft=vim et sw=2 sts=2:
