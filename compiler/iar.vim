" Vim compiler file
" Compiler: iar
" Maintainer: rail.shafigulin@mgail.com <rail.shafigulin@gmail.com>
" URL:    
" Last Change:  2013 Apr 04 

let current_compiler = "iar"

if exists(":CompilerSet") != 2    " older Vim always used :setlocal
  command! -nargs=* CompilerSet setlocal <args>
endif

" 
" Setup error message format.
"
" Generic pattern for a single line compiler error message.
" Match the filename, line number, and white space.
let s:c_line = '"%f"\,%l%*\s'
" Match first character of error type, the rest of the characters
" of the error type, white space, error number, column (:), and white space.
let s:c_line .= '%t%*\w%*\s%n:%*\s'
"Match the actual error message.
let s:c_line .= '%m'

" Match multi-line compiler error message, type 1.
" Line 1. Start of the mulit-line error message (%A),
"   %p~ means a string of spaces and then ~ to get a column number.
let s:c_err_fmt = '%A%p~'.','
" Line 2. Continuation of the error line, %C, followed by generic pattern for
" a single line error message.
let s:c_err_fmt .= '%C'.s:c_line.','

" Line 3, last line. End of the multi-line error message and white space.
let s:c_err_fmt .= '%Z%*\s'

" Add another pattern for the error message.
let s:c_err_fmt .= ','

" Match multi-line compiler error message, type 2.
" Line 1. Start of the mulit-line error message, %A,
"   %p^ means a string of spaces and then ^ to get a column number.
let s:c_err_fmt .= '%A%p^'.','
" Line 2, last line. Match quoted filename, comma, line number and white space
let s:c_err_fmt .= '%Z"%f"\,%l%*\s'
" Match first character of the error type, the rest of the characters of the
" error message, and the message itself.
let s:c_err_fmt .= '%t%*\w%m'

" Add another pattern for the error message.
let s:c_err_fmt .= ','

" Single line error message.
let s:c_err_fmt .= s:c_line

" Linker error format.
let s:l_err_fmt = ''

" Full error format message.
let s:err_fmt = s:c_err_fmt.','.s:l_err_fmt

execute 'CompilerSet errorformat='.escape(s:err_fmt,'"\')
CompilerSet makeprg=make
