" Create tmp and backup directories.
" Taken from http://vim.wikia.com/wiki/Automatically_create_tmp_or_backup_directories
function! InitBackupDir()
  let l:parent = $VIMHOME . '/'
  let l:backup = l:parent . 'backup/'
  let l:tmp = l:parent . 'tmp/'
  if exists('*mkdir')
    if !isdirectory(l:parent)
      call mkdir(l:parent)
    endif
    if !isdirectory(l:backup)
      call mkdir(l:backup)
    endif
    if !isdirectory(l:tmp)
      call mkdir(l:tmp)
    endif
  endif
  let l:missing_dir = 0
  if isdirectory(l:tmp)
    execute 'set backupdir=' . escape(l:backup, ' ') . '/,.'
  else
    let l:missing_dir = 1
  endif
  if isdirectory(l:backup)
    execute 'set directory=' . escape(l:tmp, ' ') . '/,.'
  else
    let l:missing_dir = 1
  endif
  if l:missing_dir
    echo 'Warning: Unable to create backup directories:' l:backup 'and' l:tmp
    echo 'Try: mkdir -p' l:backup
    echo 'and: mkdir -p' l:tmp
    set backupdir=.
    set directory=.
  endif
endfunction

function! BuildFileList(file_out, dir_list, pattern, is_quote)
  " Create a comma seperated list of directory names
  let l:dir_str = ''
  for dir in a:dir_list
    let l:dir_str .= dir.','
  endfor

  " From the inside out:
  " 1. Find all files mathcin a pattern in the l:dir_str (globpath).
  "    vim returns those parameters as string seperated by a ^@ symbol
  "    (<c-v><c-2>), which is interpreted as a new line.
  " 2. Split the string returned by a globpath on a new line, creating a list
  "    (split).
  " 3. Create a new list from an existing one. If is_quote is True then
  "    each element will be surrouded with the qotation marks (map). Otherwise
  "    the element will stay as is (map). Quotation marks allow cscope the
  "    use of whitespace in the file path.
  " 4. Write the list of files into the a:file_out (writefile).

  let l:str = '"\"" . v:val . "\""'
  if !a:is_quote
    let l:str = 'v:val'
  endif
  call writefile(
        \ map(
        \   split(
        \     globpath(l:dir_str, a:pattern),
        \     '\n'),
        \   l:str),
        \ a:file_out)
endfunction

function! RebuildCscope()
  " Kill all csope connections
  exe 'silent cs kill -1'
  " Build a file list
  call BuildFileList(g:cscope_files, g:src_dirs, g:file_re, 1)
  " Rebuild the database.
  exe g:cscope.' '.g:cscope_opts
  " Add a csope connections
  exe 'silent cs add '.g:cscope_out
endfunction

function! RebuildCtags()
  " Build a file list
  call BuildFileList(g:ctags_files, g:src_dirs, g:file_re, 0)
  " Build the database
  exe g:ctags.' '.g:ctags_opts
endfunction

function! RebuildCscopeAndCtags()
  " Kill all csope connections so that cscope database could be deleted.
  exe 'silent cs kill -1'
  " Delete file lists and databases
  silent call DeleteFile(g:cscope_files, g:cscope_out, g:ctags_files, g:ctags_out)
  silent call RebuildCscope()
  silent call RebuildCtags()
endfunction

function! CscopeFind(action, word)
  try
    exe ':cs f '.a:action.' '.a:word
    copen
    cc
    " Put the line with a cursor on the center of the screen
    normal zz
  catch
    echohl WarningMsg | echo 'Can not find '.a:word.' with querytype as '.a:action.'.' | echohl None
  endtry
endfunction

" Adapted from from http://vim.wikia.com/wiki/Delete_files_with_a_Vim_command
function! DeleteFile(...)
  let delStatus = 0
  for myfile in a:000
    if(!filereadable(myfile))
      echohl WarningMsg
      echo myfile.' either does not exists or is a directory.'
      echohl None
      continue
    endif
    let delStatus=delete(myfile)
    if(delStatus == 0)
      echo "Deleted " . myfile
    else
      echohl WarningMsg
      echo "Failed to delete " . myfile
      echohl None
    endif
  endfor
  return delStatus
endfunction

" pattern - pattern to search for
" dir_list - list of directories to use for the search of the pattern
" is_recursive - if 1 each directory in the dir_list will be searched
" recursively
function! VimGrep(pattern, dir_list, is_recursive)
  let l:dir_str = ''
  if a:is_recursive
    let l:dir_str .= a:dir_list.'/**'
  endif
  for dir in a:dir_list
    let l:dir_str .= dir.'/*.* '
  endfor
  exe ':vim /'.a:pattern.'/g '.l:dir_str
  " Put the screen with a cursor on the center of the screen
  normal zz
endfunction

" Taken from http://vimcasts.org/episodes/tidying-whitespace/
function! StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
