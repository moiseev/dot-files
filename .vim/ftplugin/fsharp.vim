" Vim filetype plugin
" Language:     F#
" Last Change:  Fri 26 Aug 2011 09:15:22 PM CEST
" Maintainer:   Gregor Uhlenheuer <kongo2002@googlemail.com>

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let s:candidates = [ 'fsi',
            \ 'fsi.exe',
            \ 'fsharpi',
            \ 'fsharpi.exe' ]

if !exists('g:fsharp_interactive_bin')
    let g:fsharp_interactive_bin = ''
    for c in s:candidates
        if executable(c)
            let g:fsharp_interactive_bin = c
        endif
    endfor
endif

if !executable(g:fsharp_interactive_bin)
    echohl WarningMsg
    echom 'fsharp.vim: no fsharp interactive binary found'
    echom 'fsharp.vim: set g:fsharp_interactive_bin appropriately'
    echohl None
    finish
endif

function! s:launchInteractive(from, to)
    let tmpfile = tempname()
    echo tmpfile
    exec a:from . ',' . a:to . 'w! ' . tmpfile
    exec '!' . g:fsharp_interactive_bin '--gui- --nologo --use:"'.tmpfile.'"'
endfunction

com! -buffer -range=% Interactive call s:launchInteractive(<line1>, <line2>)

let &cpo = s:cpo_save

map <F5> :!fsi /r:FSharp.PowerPack.dll /r:System.Core.dll %<RETURN>
map <F9> :make<RETURN>

if has("gui_win32") && !exists("b:browsefilter")
    let b:browsefilter = "F# Source Files (*.fs)\t*.fs\nF# Script Files (*.fsx)\t*.fsx\nF# Interface Files (*.fsi)\t*.fsi\n" .
		       \ "All Files (*.*)\t*.*\n"
endif

" vim: sw=4 et sts=4
