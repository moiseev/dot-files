if exists('g:erlang_ftplugin_after') && g:erlang_ftplugin_after
    finish
endif

let g:erlang_ftplugin_after = 1

if executable('erlfmt')
    nnoremap <silent> \ef :!erlfmt -w %<CR><CR>
endif
