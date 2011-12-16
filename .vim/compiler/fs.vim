if exists("current_compiler")
  finish
endif
let current_compiler = "fs"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" default errorformat
CompilerSet errorformat&

" default make
CompilerSet makeprg=fsc\ %
