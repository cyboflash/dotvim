" 1. tabstop - Number of spaces that a <Tab> in the file counts for,
"      i.e. if there is a tab or this number of spaces in the file, this is the number
"      of spaces that I will see.
" 2. softtabstop - Number of spaces that is inserted/deleted when
"      a <Tab>/<BS> key is pressed.
" 3. shiftwidth - Number of spaces to use for each step of (auto)indent.
"      Used for 'cindent', >>, <<, etc.
" 4. expandtab - In insert mode replace a 'tab' character with spaces.
setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Enable automatic C program indenting.
setlocal cindent

" Set text width to 100
setlocal textwidth=100

" This is a sequence of letters which describes how automatic
" formatting is to be done.
"   j Where it makes sense, remove a comment leader when joining lines.  For
"     example, joining:
"       int i;   // the index 
"                // in the list 
"     Becomes:
"       int i;   // the index in the list 
setlocal formatoptions+=j

" Replace all sequences of white-space containing a 'tab' with new strings
" of white-space using the tabstop value.
retab
