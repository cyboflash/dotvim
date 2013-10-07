" Set the VIM directory based on if it is Windows or other system.
let $VIMHOME = $HOME.'/.vim'
if has('win32')
  let $VIMHOME = $HOME.'/vimfiles'
endif

let mapleader=","
" ==================== Pathogen plugin ==========================
" Make sure this line is before file-type/plugin detection is on.
source $VIMHOME/bundle/pathogen/autoload/pathogen.vim

" Infect the runtime path.
call pathogen#infect()
" Generate help tags for each plugin.
call pathogen#helptags()

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
call InitBackupDir()

" Enable plugins and indentation based on a filetype.
filetype plugin indent on

" Set the backspace
" indent - Allow backspacing over autoindent.
" eol - Allow backspacing over line breaks.
" start - Allow backspacing over the start of insert.
set backspace=indent,eol,start

" Disable vi-compatability
set nocompatible

" Always show the statusline
set laststatus=2

" Necessary to show the Unicode glyphs, needed for the vim-powerline plugin.
set encoding=utf-8

" Set the font
if has('win32')
  set guifont=Consolas:h9:b:cANSI
endif

" Remove Menu from GUI
set guioptions-=m
" Remove Toolbar from GUI
set guioptions-=T

" ===== <Tab> completion =====
" list:longest - List all matches and complete the longest match
" full - complete the next full match.
set wildmode=list:longest,full
" Do not use the menu one can go through by using <Tab>. Simply list all the
" files.
set nowildmenu

" Turn on line numbering.
set number

" Enable syntax highlighting
syntax on

" Remeber 300 last ex-commands
set history=300

" Make a buffer hidden when it is abandoned.
set hidden

" Set the colorscheme
" Note: Keep the colorscheme settings after the syntax on command.
" As it turns out syntax on reloads colorshcheme again.
colorscheme xoria256

" Turn on the highlight of the line with the cursor.
set cursorline
" Set up how to show tabs, end of line, and trailing spaces.
set listchars=tab:►\ ,eol:¬,trail:●

" Make unnamed register to be the cliboard register.
set clipboard=unnamed

" Use tags and dictionary for completion.
set complete=t,k

" --------- Search -----------------
" Highlight the search pattern.
set hlsearch
" Do an incremental search.
set incsearch
" Ignore the case during the search.
set ignorecase

" -------------------- cscope setup --------------------------
set cscopequickfix=s-,g-,d-,c-,t-,e-,f-,i-
" Show msg when any other cscope db added
set cscopeverbose

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

" Make Vim remember where I left off.
autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \  exe "normal g`\"" |
        \  endif

" =============================================================================
" =========================== Plugin setup ====================================
" =============================================================================
"
" -------------------------------- airline----------------------------------
" airline theme
" let g:airline_theme = 'serene'

" enable/disable automatic population of the `g:airline_symbols` dictionary
" with powerline symbols.
" let g:airline_powerline_fonts=1

 " -------------------------------- tcomment ----------------------------------
 "  Setup line comment for .c files
" let g:tcommentLineC = {
 "            \ 'commentstring': '// %s',
  "           \ }

" --------------------------------- project -----------------------------------
" i - Display the filename and the current working directory in the command
"     line when a file is selected for opening.
" m - Turn on the mapping of the CTRL-W_o and CTRL-W_CTRL_O normal mode
"     commands to make the current buffer the only visible buffer, but keep the
"     Project Windows visible too.
"     line when a file is selected for opening.
" s - Use syntax highlighting in the Project Window.
" S - Turn on sorting for refresh and create.
" g - <F12> maps to toggle the project window.
" t - Toggle the size of the window rather than just increase the size wiehn
"     pressing <space> or right-clicking.
" c - When present, the Project Window will automatically close when
"     you select a file.

let g:proj_flags='imsSgtc'

" --------------------------------- tagbar ----------------------------------
" Automatically close tagbar window when a jump is made to a tag
" let g:tagbar_autoclose = 1
" Move the cursor to the tagbar window after it is opened
" let g:tagbar_autofocus = 1
" Sort the tags by name
" let g:tagbar_sort = 1
" Open folds if the tag is inside of it
" let g:tagbar_autoshowtag = 1
" Open all folds
" let g:tagbar_foldlevel = 99
" Set the width of the tagbar window
" let g:tagbar_width = 60

" --------------------------------- ctrlp ----------------------------------
" Show the match window on top, order of matches: top to bottom
" minimum match window height: 1, maximum match window height: 30
" let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30'
" Use a tag extension
" let g:ctrlp_extensions = ['tag']

" ------------------------------- omnicppcomplete -----------------------------
" What to do with an item, after OmniCppComplete menu poped out
" 0 - don't select the first item.
" 1 - select the first itme and insert it to the text.
" 2 - select the first itme but do not insert it to the text.
" let OmniCpp_SelectFirstItem = 2
" Should the scope of the match be shown first when menu pops out?
" 0 - show the scope of the match last
" 1 - show the scope of the match first
" let OmniCpp_ShowScopeInAbbr = 0
" Show prototype of the function in the abbreviation.
" 0 - don't show the prototype of the function in the abbreviation.
" 1 - show the prototype of the function in the abbreviation.
" let OmniCpp_ShowPrototypeInAbbr = 1
" This option allows to show/hide the access information ('+', '#', '-') in the
" popup menu.
" 0 = hide access
" 1 = show access
" let OmniCpp_ShowAccess = 1

" ======================================================================
" ============================ mappings ================================
" ======================================================================
" Toggle listing.
nnoremap <leader>l :set list!<cr>

nnoremap <silent><F8> :nohlsearch<cr>

" inoremap <Tab> <C-x><C-]>
" s: Find this C symbol
nnoremap <leader>cs :call CscopeFind('s', expand('<cword>'))<cr>zz
" g: Find this definition
nnoremap <leader>cg :call CscopeFind('g', expand('<cword>'))<cr>zz
" d: Find functions called by this function
nnoremap <leader>cd :call CscopeFind('d', expand('<cword>'))<cr>zz
" c: Find functions calling this function
nnoremap <leader>cc :call CscopeFind('c', expand('<cword>'))<cr>zz
" t: Find this text string
nnoremap <leader>ct :call CscopeFind('t', expand('<cword>'))<cr>zz
" e: Find this egrep pattern
nnoremap <leader>ce :call CscopeFind('e', expand('<cword>'))<cr>zz
" f: Find this file
nnoremap <leader>cf :call CscopeFind('f', expand('<cword>'))<cr>zz
" i: Find files #including this file
nnoremap <leader>ci :call CscopeFind('i', expand('<cword>'))<cr>zz

nnoremap <F7> :call RebuildCscopeAndCtags()<cr>
nnoremap <silent><F11> :make all<cr>:copen<cr>
nnoremap <silent><C-F11> :make rebuild<cr>:copen<cr>
nnoremap <silent><M-F11> :make final<cr>:copen<cr>

" Toggle the Tlist window using <F4>
" nnoremap <silent><F4> :TagbarToggle<cr>

" nnoremap <leader>fm :CtrlPMixed<cr>
" nnoremap <leader>ff :CtrlP g:prj_root_8dot3<cr>
" nnoremap <leader>ft :CtrlPTag<cr>

" Map sourcing of .vimrc file.
nnoremap <silent><leader>sv :source $VIMHOME/vimrc<cr>
" Map editing of .vimrc file.
nnoremap <silent><leader>ev :edit $VIMHOME/vimrc<cr>

nnoremap <silent><F9> :cprev<cr>zz
nnoremap <silent><F10> :cnext<cr>zz
nnoremap <silent><M-F9> :cfirst<cr>
nnoremap <silent><M-F10> :clast<cr>
nnoremap <silent><leader>mm :set lines=999 columns=999<cr>
nnoremap <silent><leader>mn :set lines=999 columns=80<cr>

nnoremap <leader>v :call VimGrep(expand('<cword>'), g:prj_dirs, 0)<cr>
" command! -nargs=1 VimGrep :call VimGrep("<args>", g:prj_dirs, 0) | copen | cc
" abbreviate Vim VimGrep


