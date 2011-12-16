if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match

syn keyword pdlInfo     INFO
syn keyword pdlDebug    DEBUG TRACE WARN
syn keyword pdlError    ERROR FATAL

syn match   pdlTimestamp /^\d\+-\d\+-\d\+ \d\+:\d\+:\d\+,\d\+/
syn region  pdlThreadName start="\[" skip="\\$" end="\]"
syn region  pdlExLine start="^[a-zA-Z.]*Exception" end=":" oneline
syn match   pdlDuration /[0-9]\+ \?ms/

command -nargs=+ HiLink hi def link <args>

HiLink pdlTimestamp   Statement
HiLink pdlThreadName  Function
HiLink pdlDuration    Function

HiLink pdlError       Error
HiLink pdlInfo        Delimiter
HiLink pdlDebug       Debug
HiLink pdlExLine      Error

delcommand HiLink

let b:current_syntax = "pd_log"
