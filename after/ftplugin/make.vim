" 1. tabstop - Number of spaces that a <Tab> in the file counts for.
"      i.e. if there is a tab in the file when I read it, this is the number
"      of spaces that I will see.
" 2. softtabstop - Number of spaces that a <Tab> counts for while performing
"      editing operations, like inserting <Tab> or using <BS>,
"      i.e. when I press <Tab> this is how many spaces will be inserted.
"      Also when I press <BS> if there was a <Tab>, this is how many spaces
"      will be removed.
" 3. shiftwidth - Number of spaces to use for each step of (auto)indent.
"      Used for 'cindent', >>, <<, etc.
" 4. expandtab - Convert tabs to spaces.
setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

" Replace all sequences of white-space containing a
" <Tab> with new strings of white-space using the new
" tabstop value given.  If you do not specify a new
" tabstop size or it is zero, Vim uses the current value
" of 'tabstop'.
" The current value of 'tabstop' is always used to
" compute the width of existing tabs.
" With !, Vim also replaces strings of only normal
" spaces with tabs where appropriate.
" With 'expandtab' on, Vim replaces all tabs with the
" appropriate number of spaces.
retab
