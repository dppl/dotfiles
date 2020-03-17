let s:modes = {
      \ 'n': 'NORMAL', 
      \ 'i': 'INSERT', 
      \ 'R': 'REPLACE', 
      \ 'v': 'VISUAL', 
      \ 'V': 'V-LINE', 
      \ "\<C-v>": 'V-BLOCK',
      \ 'c': 'COMMAND',
      \ 's': 'SELECT', 
      \ 'S': 'S-LINE', 
      \ "\<C-s>": 'S-BLOCK', 
      \ 't': 'TERMINAL'
      \}

exe 'hi! StatusLine ctermbg=8 guibg=#434C5E guifg=#D8DEE9'
exe 'hi! StatusLineNC ctermbg=8 guibg=#434C5E guifg=#D8DEE9'
exe 'hi! cocStatusColor cterm=bold ctermbg=8 ctermfg=1 guibg=#434C5E guifg=#BF616A'
exe 'hi! fileInfoColor ctermbg=8 guibg=#434C5E guifg=#D8DEE9'
exe 'hi! gitInfoColor ctermbg=8 guibg=#434C5E guifg=#D8DEE9'

let s:prev_mode = ""
function! StatusLineMode()
  let cur_mode = get(s:modes, mode(), '')

  " do not update higlight if the mode is the same
  if cur_mode == s:prev_mode
    return cur_mode
  endif

  if cur_mode == "NORMAL"
    exe 'hi! myModeColor cterm=bold ctermbg=8 ctermfg=2 guibg=#434C5E guifg=#A3BE8C'
  elseif cur_mode == "INSERT"
    exe 'hi! myModeColor cterm=bold ctermbg=NONE ctermfg=4 guibg=#434C5E guifg=#81A1C1'
  elseif cur_mode == "VISUAL" || cur_mode == "V-LINE" || cur_mode == "V_BLOCK"
    exe 'hi! myModeColor cterm=bold ctermbg=NONE ctermfg=3 guibg=#434C5E guifg=#EBCB8B'
  endif

  let s:prev_mode = cur_mode
  return cur_mode
endfunction

function! StatusLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! StatusLinePercent()
  return (100 * line('.') / line('$')) . '%'
endfunction

function! StatusLineGetModified()
  if &modifiable
    if &modified
      exe 'hi! modifiableColor ctermbg=8 guibg=#434C5E guifg=#D8DEE9'
      return '[+] '
    endif
  else
    exe 'hi! modifiableColor cterm=bold ctermbg=8 ctermfg=1 guibg=#434C5E guifg=#BF616A'
    return '[-] '
  endif
  return ''
endfunction

function! StatusLineLeftInfo()
  return '' != expand('%:t') ? expand('%:t') : '[No Name]'
endfunction

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E:' . info['error'].'(L'.info['lnums'][0].')')
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W:' . info['warning'].'(L'.info['lnums'][1].')')
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction


set statusline=

set statusline+=%#myModeColor#
set statusline+=%{StatusLineMode()}
set statusline+=\ %*

set statusline+=%#modifiableColor#
set statusline+=%{StatusLineGetModified()}
set statusline+=%*

set statusline+=%#fileInfoColor#
set statusline+=%{StatusLineLeftInfo()}
set statusline+=%#gitInfoColor#
set statusline+=\ %{FugitiveHead()}
set statusline+=\ %*

set statusline+=%#goStatuslineColor#
set statusline+=%{go#statusline#Show()}
set statusline+=%*

set statusline+=%=

set statusline+=%#myInfoColor#
set statusline+=\ %{StatusLineFiletype()}\ %{StatusLinePercent()}\ %l:%v
set statusline+=\ %*
set statusline+=%#cocStatusColor#
set statusline+=%{StatusDiagnostic()}
set statusline+=%*

