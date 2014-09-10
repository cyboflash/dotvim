" 1. tabstop - Number of spaces that a <Tab> in the file counts for.
"      i.e. if there is a tab in the file when I read it, this is the number
"      of spaces that I will see.
" 2. softtabstop - Number of spaces that a <Tab> counts for while performing
"      editing operations, like inserting <Tab> or using <BS>.
" 3. shiftwidth - Number of spaces to use for each step of (auto)indent.
"      Used for 'cindent', >>, <<, etc.
" 4. expandtab - Convert tabs to spaces.
setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

" Replace all sequences of white-space containing a
" <Tab> with new strings of white-space using the new
" tabstop value given.
retab
