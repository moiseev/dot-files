" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
 
" Don't load another plugin for this buffer
let b:did_ftplugin = 1

setlocal syntax=sh

if has("gui_win32") && !exists("b:browsefilter")
    let b:browsefilter = "Powershell scripts (*.ps1)\t*.ps1\n"
endif
