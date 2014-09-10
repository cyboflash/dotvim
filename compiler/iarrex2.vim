" Vim compiler file
" Compiler: iarrex2
" Maintainer: rail.shafigulin@mgail.com <rail.shafigulin@gmail.com>
" URL:
" Last Change:  2013 Apr 04

let current_compiler = "iarrex2"

if exists(":CompilerSet") != 2    " older Vim always used :setlocal
  command! -nargs=* CompilerSet setlocal <args>
endif

"
" Setup error message format.
"
let s:c_err_fmt  = '%A'.'%p~'.','
let s:c_err_fmt .= '%Z'.'"%f"\,%l%\s%#%t%\w%#%\s%#%n:%m'.','

let s:c_err_fmt .= '%A'.'%p^'.','
let s:c_err_fmt .= '%Z'.'"%f"\,%l%\s%#%t%\w%#%m'.','

let s:c_err_fmt .= '"%f"\,%l%\s%#%t%\w%#%\s%#%n:%m'.','

" let s:c_err_fmt .= '%A'.'%p~'.','
" let s:c_err_fmt .= '%C'.'"%f"\,%l'.','
" let s:c_err_fmt .= '%C'.'%m'.','
" let s:c_err_fmt .= '%Z'.'%m'



" let s:c_err_fmt .= ','

" Type 1 Messgage
" Line 1.
" Start of the mulit-line error message, '%A',
"   '%p~' means a string of spaces followed by '~'. This allows vim to find a
"   column number
" let s:c_err_fmt .= '%E'.'%p~'.','
" Line 2.
" Continue multiline error message, '%C',
"   followed by quoted file path , '"%f"', followed by a comma, '\,',
"   followed by 0 or more whitespace , '%\s%#',
"   followed by error message type, '%t',
"   followed by 0 or more characters, '%\w%#'
" let s:c_err_fmt .= '%C'.'"%f"\,%l%\s%#%sError,'
" Line 3.
" Last line of the milti-line error message, '%Z'
"   followed by 0 or more whitespace, '%\s%#',
"   followed by message number, '%n',
"   followed by the actuaal message
" let s:c_err_fmt .= '%Z'.'%\s%#%n:%m'






" Match multi-line compiler error message, type 0.
" Line 1. Start of the mulit-line error message, %A,
"   %p~ means a string of spaces followed by '~'. This allows vim to find a
"   column number
" let s:c_err_fmt = '%A'.'%p~'.','

" Line 2. Coninuation of aline, %C, followed by a quoted filepath, "%f", comma, ',',
" line number, %l, and any number of whitespace %*\s
" let s:c_err_fmt .= '%C'.'"%f"\,%l%*\s'.','

" Line 3. Coninuation of aline, %C, followed by any number of whitespace %*\s,
" first character of the error type, %t, followed by any character, %*\w,
" followed by any number of whitespace %*\s, followed by an error message, %m
" let s:c_err_fmt .= '%C'.'%*\s%t%*\w%*\s%n:%*\s%m'.','

" Line 4. Last line, %Z, followed by an error message.
" let s:c_err_fmt .= '%Z'.'%m'

" Add another format string
" let s:c_err_fmt .= ','

" Line 1. Start of the mulit-line error message, %A, followed by any
" number of whitespaces, %*\s, followed by a quoted filepath, "%f", comma, ',',
" line number, %l, and any at leas one whitespace %*\s, followed by the first
" character of the error type, %t, followed by at least one character, %*\w

" let s:c_err_fmt .= '%A'.'%p~'.','
" let s:c_err_fmt .= '%C'.'"%f"\,%l%\s%#%t%\w%#'.','
" let s:c_err_fmt .= '%Z'.'%\s%#%n:%\s%#%m'


" Line 3. Coninuation of aline, %C, followed by any number of whitespace %*\s,
" first character of the error type, %t, followed by any character, %*\w,
" followed by any number of whitespace %*\s, followed by an error message, %m
" let s:c_err_fmt .= '%C'.'%*\s%t%*\w%*\s%n:%*\s%m'.','
" " Line 4. Last line, %Z, followed by an error message.
" let s:c_err_fmt .= '%Z'.'%m'

" Full error format message.
let s:err_fmt = s:c_err_fmt

execute 'CompilerSet errorformat='.escape(s:err_fmt,'"\')
CompilerSet makeprg=make
