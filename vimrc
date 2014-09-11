" Set the VIM directory based on if it is Windows or other system.
let $VIMHOME = $HOME.'/.vim'
if has('win32')
  let $VIMHOME = $HOME.'/vimfiles'
endif
let bundle_root = $VIMHOME.'/bundle'
let vundle_root = bundle_root.'/vundle'

" ================= Required Vundle Setup =======================
" Disable vi-compatability.
set nocompatible
" Disable file type detection
filetype off
" Set 'runtime' path to include vundle and initialize
let &runtimepath .= ','.vundle_root
call vundle#begin(bundle_root)

" Required: let Vunldle manage vundle.
Plugin 'gmarik/vundle'

" List of the plugins

" L9 library
Plugin 'eparreno/vim-l9'
" Better status line
Plugin 'bling/vim-airline'
" Fuzzy file, buffer, most recently used (mru) and tag finder.
Plugin 'kien/ctrlp.vim', {'name': 'ctrlp'}
" Visualize Vim undo tree
Plugin 'sjl/gundo.vim', {'name': 'gundo'}
" Project manager
Plugin 'vimplugin/project.vim', {'name': 'project'}
" Populate the argument list from the files in the quickfix list
Plugin 'nelstrom/vim-qargs'
" Quoting/parenthesizing made simple
Plugin 'tpope/vim-surround'
" Display tags in a window
Plugin 'majutsushi/tagbar'
" An extensible & universal commenting plugin that also handles embedded filetypes
Plugin 'tomtom/tcomment_vim'
" Start a * or # search from a visual block
Plugin 'nelstrom/vim-visual-star-search'
" Maintains a history of previous yanks, changes and deletes
Plugin 'vim-scripts/YankRing.vim', {'name': 'yankring'}
" Better highlight search
Plugin 'cyboflash/hlnext'

" ATTENTION: All of the plugins must be added before the following line
call vundle#end()
" Required: enable plugins and indentation based on the file type.
filetype plugin indent on

let mapleader=","

source $VIMHOME/myutils.vim
" Create a backup directory
call InitBackupDir()

" Set the backspace
" indent - Allow backspacing over autoindent.
" eol - Allow backspacing over line breaks.
" start - Allow backspacing over the start of insert.
set backspace=indent,eol,start

" Always show the statusline
set laststatus=2

" Necessary to show the Unicode glyphs, needed for the vim-powerline plugin.
set encoding=utf-8

" Make sure this setting is after 'encoding' setting
" Specify character encoding used in the script. This is needed to make sure
" that 'listchars' setting displays all the glyphs. If this setting is
" specified before the 'encoding' setting then glyphs are not displayed
" properly, vimrc needs to be sourced again.
scriptencoding utf-8

" Set the font
if has('win32')
  set guifont=Powerline_Consolas:h9:b:cANSI
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
set listchars=tab:►►,eol:●,trail:◄

" Make unnamed register to be the cliboard register.
set clipboard=unnamed

" Use tags and dictionary for completion.
set complete=t,k

" --------- Search -----------------
" Highlight the search pattern.
set hlsearch
" Do an incremental search.
set incsearch
" Ignore case during search
set ignorecase
" Override the 'ignorecase' option if the search pattern contains upper
" case characters.
set smartcase

" Print line numbers in the hardcopy
set printoptions=left:3pc,number:y,syntax:n

" -------------------- cscope setup --------------------------
set cscopequickfix=s-,g-,d-,c-,t-,e-,f-,i-
" Show msg when any other cscope db added
set cscopeverbose

if has("autocmd")
  " Make Vim remember where I left off.
  autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \  exe "normal g`\"" |
          \  endif

  " Remove trailing whtiespace upon saving
  autocmd BufWritePre *
        \ if &ft == "c"      ||
        \    &ft == "make"   ||
        \    &ft == "python" ||
        \    &ft == "cpp"    ||
        \    &ft == "mdl"    ||
        \    &ft == "vim"
        \ | call StripTrailingWhitespaces() | endif

endif

" =============================================================================
" =========================== Plugin setup ====================================
" =============================================================================
"
" -------------------------------- airline----------------------------------
" theme
let g:airline_theme = 'jellybeans'

" enable/disable automatic population of the `g:airline_symbols` dictionary
" with powerline symbols.
let g:airline_powerline_fonts=1

" 'f' Display the full hierarchy of the tag, not just the tag itself.
let g:airline#extensions#tagbar#flags = 'f'

" Enable iminsert detection.
let g:airline_detect_iminsert=1

 " -------------------------------- tcomment ----------------------------------
 "  Setup line comment for .c files
let g:tcommentLineC = {
            \ 'commentstring': '// %s',
            \ }

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
let g:tagbar_autoclose = 1
" Move the cursor to the tagbar window after it is opened
let g:tagbar_autofocus = 1
" Sort the tags by name
let g:tagbar_sort = 1
" Open folds if the tag is inside of it
let g:tagbar_autoshowtag = 1
" Open all folds
let g:tagbar_foldlevel = 99
" Set the width of the tagbar window
let g:tagbar_width = 60

" --------------------------------- ctrlp ----------------------------------
" Show the match window on top, order of matches: top to bottom
" minimum match window height: 1, maximum match window height: 30
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30'
" Use a tag extension
let g:ctrlp_extensions = ['tag']

" ------------------------------- clang_complete -----------------------------
" 0 - Select nothing
" 1 - Automatically select the first entry in the popup menu, but do not
" insert it into the code.
" 2 - Automatically select the first entry in the popup menu, and insert it
" into the code.
" let g:clang_auto_select = 1
" 0 - do not complete after ->, ., ::
" 1 - automatically complete after ->, ., ::
" let g:clang_complete_auto = 1
" 0 - do not open quickfix window on error.
" 1 - open quickfix window on error.
" let g:clang_complete_copen = 1
" 0 - do not highlight the warnings and errors
" 1 - highlight the warnings and errors the same way clang does it
" let g:clang_hl_errors = 0
" 0 - do not do some snippets magic on code placeholders like function argument,
"     template argument, template parameters, etc.
" 1 - do some snippets magic on code placeholders like function argument,
"     template argument, template parameters, etc.
" let g:clang_snippets = 1
" The snippets engine (clang_complete, ultisnips... see the snippets
" subdirectory).
" let g:clang_snippets_engine = "clang_complete"

" let g:clang_library_path = "C:\\Program\ Files\ (x86)\\LLVM\ 3.4.svn\\bin"

" ------------------------------- omnicppcomplete -----------------------------
" What to do with an item, after OmniCppComplete menu poped out
" 0 - don't select the first item.
" 1 - select the first itme and insert it to the text.
" 2 - select the first itme but do not insert it to the text.
let OmniCpp_SelectFirstItem = 2
" Should the scope of the match be shown first when menu pops out?
" 0 - show the scope of the match last
" 1 - show the scope of the match first
let OmniCpp_ShowScopeInAbbr = 0
" Show prototype of the function in the abbreviation.
" 0 - don't show the prototype of the function in the abbreviation.
" 1 - show the prototype of the function in the abbreviation.
let OmniCpp_ShowPrototypeInAbbr = 1
" This option allows to show/hide the access information ('+', '#', '-') in the
" popup menu.
" 0 = hide access
" 1 = show access
let OmniCpp_ShowAccess = 1

" Autoclose the preview window after the match is found.
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


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
nnoremap <silent><F4> :TagbarToggle<cr>

nnoremap <leader>fb :CtrlPBuffer<cr>
nnoremap <leader>fm :CtrlPMixed<cr>
nnoremap <leader>ff :CtrlP g:prj_root_8dot3<cr>
nnoremap <leader>ft :CtrlPTag<cr>

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

nnoremap <silent><F6> :YRShow<CR>

nnoremap <silent><F5> :GundoToggle<CR>

nnoremap <leader>v :call VimGrep(expand('<cword>'), g:prj_dirs, 0, 1)<cr>
command! -nargs=1 VimGrep :call VimGrep("<args>", g:prj_dirs, 0, 0) | copen | cc
" abbreviate Vim VimGrep


