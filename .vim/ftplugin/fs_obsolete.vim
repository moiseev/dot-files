" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
 
" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

" Set 'comments' to format dashed lists in comments.
"setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,:///,://
setlocal syntax=fs
compiler fs

map <F5> :!fsi /r:FSharp.PowerPack.dll /r:System.Core.dll %<RETURN>
map <F9> :make<RETURN>

if has("gui_win32") && !exists("b:browsefilter")
    let b:browsefilter = "F# Source Files (*.fs)\t*.fs\nF# Script Files (*.fsx)\t*.fsx\nF# Interface Files (*.fsi)\t*.fsi\n" .
		       \ "All Files (*.*)\t*.*\n"
endif
