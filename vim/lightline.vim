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
