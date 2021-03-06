﻿" Section: Must be done first 
" Set the VIM directory based on if it is Windows or other system.
let $VIMHOME = $HOME.'/.vim'
if has('win32') || has('win64')
  let $VIMHOME = $HOME.'/vimfiles'
endif
let bundle_root = $VIMHOME.'/bundle'
let vundle_root = bundle_root.'/vundle'

" Section: Required Vundle Setup
" Disable vi-compatibility.
set nocompatible
" Disable file type detection
filetype off
" Set 'runtime' path to include vundle and initialize
let &runtimepath .= ','.vundle_root

" Section: Plugins 
call vundle#begin(bundle_root)

" Required: let Vunldle manage vundle.
Plugin 'gmarik/vundle'

" Easy motion
Plugin 'easymotion/vim-easymotion.git'
" Scratch buffer
Plugin 'mtth/scratch.vim'
" Adjust Gvim font size via keypresses
Plugin 'drmikehenry/vim-fontsize.git'
" text objects for various C and C++ blocks with power of clang
Plugin 'rhysd/vim-textobj-clang.git'
" Vim scripting interface to clang. Needed by other plugins.
Plugin 'rhysd/libclang-vim.git'
" Create your own text objects
Plugin 'kana/vim-textobj-user.git'
" Line text object
Plugin 'kana/vim-textobj-line.git'
" Vim plugin for copying to the system clipboard with text-objects and motions
Plugin 'christoomey/vim-system-copy.git'
" L9 library
Plugin 'eparreno/vim-l9'
" Better status line
Plugin 'bling/vim-airline'
" Status line themes
Plugin 'vim-airline/vim-airline-themes'
" Fonts for airline/powerline
Plugin 'powerline/fonts.git'
" Fuzzy file, buffer, most recently used (mru) and tag finder.
Plugin 'ctrlpvim/ctrlp.vim', {'name': 'ctrlp'}
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
" An extensible & universal commenting plugin that also handles embedded file types
Plugin 'tomtom/tcomment_vim'
" Start a * or # search from a visual block
" Plugin 'bronson/vim-visual-star-search.git'
" Maintains a history of previous yanks, changes and deletes
Plugin 'vim-scripts/YankRing.vim', {'name': 'yankring'}
" Vim syntax highlighting for c, bison, flex
Plugin 'justinmk/vim-syntax-extra'
" Git from Vim
Plugin 'tpope/vim-fugitive'
" Allow to execute :make in the background.
Plugin 'tpope/vim-dispatch'
" Very nice auto completion engine for C/C++
Plugin 'Valloric/YouCompleteMe'
" Configuration generator for YouCompleteMe
Plugin 'rdnetto/YCM-Generator'
" Better grep
Plugin 'mileszs/ack.vim', {'name': 'ack'}
" Indentation text objects
Plugin 'michaeljsmith/vim-indent-object'
" Trace syntax highlight
Plugin 'gerw/vim-HiLinkTrace'
" Bracket mappings
Plugin 'tpope/vim-unimpaired'
" Easily search for, substitute, and abbreviate multiple variants of a word
Plugin 'tpope/vim-abolish.git', {'name': 'vim-abolish'}
" Text filtering and alignment.
Plugin 'godlygeek/tabular.git', {'name': 'tabular'}
" Easy text exchange operator
Plugin 'tommcdo/vim-exchange.git', {'name': 'vim-exchange'}
" Code snippets
Plugin 'SirVer/ultisnips.git', {'name': 'ultisnips'}
" Insert or delete brackets, parens, quotes in pair.
Plugin 'jiangmiao/auto-pairs.git'
" Syntax checking
Plugin 'scrooloose/syntastic.git'
" Improvements to the handling of Django related files in Vim
Plugin 'tweekmonster/django-plus.vim.git', {'name': 'django_plus'}

" ATTENTION: All of the plugins must be added before the following line
call vundle#end()

" Required: enable plugins and indentation based on the file type.
filetype plugin indent on

" start using matching plugin
packadd! matchit

" Section: Plugin Setup 
" Syntastic
let g:syntastic_python_checkers = ['python']

" fontsize 
let g:fontsize#defaultSize = 13
let g:fontsize#timeout = 0

" UltiSnips 
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsSnippetsDir=$VIMHOME.'/UltiSnips'

" YouCompleteMe 
" 0 - disable diagnositcs us
" 1 - enable diagnositcs us
" let g:ycm_show_diagnostics_ui = 1

" Ask once per '.ycm_extra_conf.py' file
" if it is safe to be loaded. This is to prevent execution of malicious code from
" a '.ycm_extra_conf.py' file you didn't write
let g:ycm_confirm_extra_conf = 0

let g:ycm_key_list_select_completion = ['<C-j>']
let g:ycm_key_list_previous_completion = ['<C-k>']

" When this option is set to '1', YCM's identifier completer will also collect
" identifiers from tags files. The list of tags files to examine is retrieved
" from the 'tagfiles()' Vim function which examines the 'tags' Vim option.
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
" Show completion suggestions in comments
let g:ycm_complete_in_comments = 1

" Do not show diagnostic signs
let g:ycm_enable_diagnostic_signs = 0

" Do not enable diagnostic highlighting
let g:ycm_enable_diagnostic_highlighting = 0

" Do not enable diagnostic highlighting
let g:ycm_server_keep_logfiles = 1


" airline 

let g:airline_theme = 'molokai'

" enable/disable automatic population of the `g:airline_symbols` dictionary
" with powerline symbols.
let g:airline_powerline_fonts=1

" 'f' Display the full hierarchy of the tag, not just the tag itself.
let g:airline#extensions#tagbar#flags = 'f'

" Enable iminsert detection.
let g:airline_detect_iminsert=1

" project 
" i - Display the filename and the current working directory in the command
"     line when a file is selected for opening.
" m - Turn on the mapping of the CTRL-W_o and CTRL-W_CTRL_O normal mode
"     commands to make the current buffer the only visible buffer, but keep the
"     Project Windows visible too.
"     line when a file is selected for opening.
" s - Use syntax highlighting in the Project Window.
" S - Turn on sorting for refresh and create.
" g - <F12> maps to toggle the project window.
" t - Toggle the size of the window rather than just increase the size when
"     pressing <space> or right-clicking.
" c - When present, the Project Window will automatically close when
"     you select a file.

let g:proj_flags='imsSgtc'

" tagbar 
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

" ctrlp 
" Show the match window on top, order of matches: top to bottom
" minimum match window height: 1, maximum match window height: 30
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30'
" Use a tag extension
let g:ctrlp_extensions = ['tag']

" Ack 
" Configure Ack to use ag, the sliver searcher.
let g:ackprg = 'ag --nogroup --nocolor --column'
" let g:ackprg = 'ack-grep -s -H --nocolor --nogroup --column'


" Section: Options 
 
" r - Automatically insert the current comment leader after hitting
"     <Enter> in Insert mode.
" j - Where it makes sense, remove a comment leader when joining lines
set formatoptions+=rj

let mapleader="\<Space>"

set cscopeprg=gtags-cscope

set relativenumber

source $VIMHOME/myutils.vim
" Create a backup directory
call InitBackupDir()

" Set the backspace
" indent - Allow backspacing over auto indent.
" eol - Allow backspacing over line breaks.
" start - Allow backspacing over the start of insert.
set backspace=indent,eol,start

" Always show the statusline
set laststatus=2

" Necessary to show the Unicode glyphs, needed for the vim-airline plugin.
set encoding=utf-8

" Make sure this setting is after 'encoding' setting
" Specify character encoding used in the script. This is needed to make sure
" that 'listchars' setting displays all the glyphs. If this setting is
" specified before the 'encoding' setting then glyphs are not displayed
" properly, vimrc needs to be sourced again.
scriptencoding utf-8

" String to put at the start of lines that have been wrapped. Must be set
" after the 'encoding' option
set showbreak=…

" Wrap long lines at a character in 'breakat' rather than at the last character that fits on the
" screen.
set linebreak
" Set the font
if has('win32') || has('win64')
  set guifont=Source\ Code\ Pro\ for\ Powerline:h9
else
  set guifont=Source\ Code\ Pro\ for\ Powerline\ 9
endif

" Remove Menu from GUI
set guioptions-=m
" Remove Toolbar from GUI
set guioptions-=T

" Don't show preview windows for auto completion
set completeopt=menu,menuone

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

" Remember 1000 last ex-commands
set history=1000

" Make a buffer hidden when it is abandoned.
set hidden

" Set the colorscheme
" Note: Keep the colorscheme settings after the syntax on command.
" As it turns out syntax on reloads colorshcheme again.
colorscheme xoria256

" Turn on the highlight of the line with the cursor.
set cursorline

" Set up how to show tabs, end of line, and trailing spaces.
set listchars=tab:►-,eol:¬,trail:●

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

" tabstop - Number of spaces that a <Tab> in the file counts for.
"   i.e. if there is a tab in the file when I read it, this is the number
"   of spaces that I will see.
" softtabstop - Number of spaces that a <Tab> counts for while performing
"   editing operations, like inserting <Tab> or using <BS>,
"   i.e. when I press <Tab> this is how many spaces will be inserted.
"   Also when I press <BS> if there was a <Tab>, this is how many spaces
"   will be removed.
" shiftwidth - Number of spaces to use for each step of (auto)indent.
"   Used for 'cindent', >>, <<, etc.
" expandtab - Convert tabs to spaces.
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

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

" Section: Autocommands 
if has("autocmd")
  augroup mygroup
    " Remove ALL autocommands for the current group.
    autocmd!

    " Make Vim remember where I left off.
    autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

    " Trim empty lines at the end of the file.
    autocmd BufWritePre * call TrimEndLines()

    autocmd BufRead,BufNewFile *.mot  setfiletype srec
    autocmd BufRead,BufNewFile *.src,*.asm,*.lst  setfiletype asm8051
    autocmd BufRead,BufNewFile *.md setfiletype mdl

    " Remove trailing whitespace for specific file types.
    autocmd FileType c,cpp,python,asm8051,make,md
            \ autocmd BufWritePre <buffer> call StripTrailingWhitespaces()

    " This is a temprorary solution for the Ack plugin.
    " As Vim creates the quickfix list, it adds a buffer for each file. That
    " autocommand executes :cd to the current working directory for each file
    " added and causes the file names to be resolved (from full path to
    " relative). Executing :cd like that is a no-op in this case.
    autocmd BufAdd * execute 'cd' fnameescape(getcwd())

  augroup END

endif

" Section: Mappings 
" Remap redraw to Alt-l
nnoremap <A-l> <C-l>

"Better window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Get to the command mode
nnoremap <leader>, :

" Toggle listing.
nnoremap <leader>l :set list!<cr>

nnoremap <silent><F8> :nohlsearch<cr>

nnoremap <leader>vv :vsp<cr>
nnoremap <leader>ss :sp<cr>

" Toggle the Tlist window using <F4>
nnoremap <silent><F4> :TagbarToggle<cr>

nnoremap <leader>fb :CtrlPBuffer<cr>
nnoremap <leader>fm :CtrlPMixed<cr>
nnoremap <leader>ff :CtrlP getcwd()<cr>
nnoremap <leader>ft :CtrlPTag<cr>

" Map sourcing of .vimrc file.
nnoremap <silent><leader>sv :source $VIMHOME/vimrc<cr>
" Map editing of .vimrc file.
nnoremap <silent><leader>ev :edit $VIMHOME/vimrc<cr>

nnoremap <silent><F9> :cprev<cr>zz
nnoremap <silent><F10> :cnext<cr>zz
nnoremap <silent><C-F9> :lprev<cr>zz
nnoremap <silent><C-F10> :lnext<cr>zz
nnoremap <silent><M-F9> :cfirst<cr>
nnoremap <silent><M-F10> :clast<cr>
nnoremap <silent><leader>mm :set lines=10000 columns=1000<cr>
nnoremap <silent><leader>mn :set lines=999 columns=90<cr>

nnoremap <silent><F6> :YRShow<CR>

nnoremap <silent><F5> :GundoToggle<CR>

nnoremap <C-S-P> :call SynStack()<cr>

" Bubbling commands are taken from  http://vimcasts.org/episodes/bubbling-text/
" Bubble single lines
nnoremap <C-Up> [e
nnoremap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
