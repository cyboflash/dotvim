" my filetype file
augroup filetypedetect
  au! BufRead,BufNewFile *.mot  setf srec
  au! BufRead,BufNewFile *.src,*.asm,*.lst  setf asm8051
  au! BufRead,BufNewFile *.md setf mdl
augroup END

