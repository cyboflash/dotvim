" vim: foldmethod=marker foldcolumn=4

" Section: Variable Setup {{{1
" Set the VIM directory based on if it is Windows or other system.
let $VIMHOME = $HOME.'/.vim'
if has('win32') || has('win64')
  let $VIMHOME = $HOME.'/vimfiles'
endif
let bundle_root = $VIMHOME.'/bundle'
let vundle_root = bundle_root.'/vundle'

" Section: Required Vundle Setup {{{1
" Disable vi-compatability.
set nocompatible
" Disable file type detection
filetype off
" Set 'runtime' path to include vundle and initialize
let &runtimepath .= ','.vundle_root

" Section: Plugins {{{1
call vundle#begin(bundle_root)

" Required: let Vunldle manage vundle.
Plugin 'gmarik/vundle'

" L9 library
Plugin 'eparreno/vim-l9'
" Better status line
Plugin 'bling/vim-airline'
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
" An extensible & universal commenting plugin that also handles embedded filetypes
Plugin 'tomtom/tcomment_vim'
" Start a * or # search from a visual block
Plugin 'nelstrom/vim-visual-star-search'
" Maintains a history of previous yanks, changes and deletes
Plugin 'vim-scripts/YankRing.vim', {'name': 'yankring'}
" Vim syntax highlighting for c, bison, flex
Plugin 'justinmk/vim-syntax-extra'
" Git from Vim
Plugin 'tpope/vim-fugitive'
" Allow to execute :make in the background.
Plugin 'tpope/vim-dispatch'
" Very nice autocompletion engine for C/C++
Plugin 'Valloric/YouCompleteMe'
" Toggle between the relative and absolute line numbering
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
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

" ATTENTION: All of the plugins must be added before the following line
call vundle#end()

" Section: Plugin Setup {{{1

" UltiSnips {{{2
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<C-k>"
let g:UltiSnipsJumpBackwardTrigger="<C-j>"

" airline {{{2
let g:airline_theme = 'molokai'

" enable/disable automatic population of the `g:airline_symbols` dictionary
" with powerline symbols.
let g:airline_powerline_fonts=1

" 'f' Display the full hierarchy of the tag, not just the tag itself.
let g:airline#extensions#tagbar#flags = 'f'

" Enable iminsert detection.
let g:airline_detect_iminsert=1

" tcomment {{{2
" Setup line comment for .c files
let g:tcommentLineC = {
            \ 'commentstring': '// %s',
            \ }

" project {{{2
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

" tagbar {{{2
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

" ctrlp {{{2
" Show the match window on top, order of matches: top to bottom
" minimum match window height: 1, maximum match window height: 30
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30'
" Use a tag extension
let g:ctrlp_extensions = ['tag']

" YouCompleteMe {{{2
" 0 - disable diagnositcs us
" 1 - enable diagnositcs us
" let g:ycm_show_diagnostics_ui = 1

" Ask once per '.ycm_extra_conf.py' file
" if it is safe to be loaded. This is to prevent execution of malicious code from
" a '.ycm_extra_conf.py' file you didn't write
let g:ycm_confirm_extra_conf = 0

" When this option is set to '1', YCM's identifier completer will also collect
" identifiers from tags files. The list of tags files to examine is retrieved
" from the 'tagfiles()' Vim function which examines the 'tags' Vim option.
let g:ycm_collect_identifiers_from_tags_files = 1

" Do not show diagnostic signs
let g:ycm_enable_diagnostic_signs = 0

" Do not enable diagnostic highlighting
let g:ycm_enable_diagnostic_highlighting = 0

" Do not enable diagnistic highlighting
let g:ycm_server_keep_logfiles = 1

" Section: Options {{{1

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

" Wrap long lines at a character in 'breakat' rather than at the last haracter that fits on the
" screen.
set linebreak
" Set the font
if has('win32') || has('win64')
  set guifont=Powerline_Consolas:h9:b:cANSI
elseif has("gui_gtk2")
  set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 10
endif

" Remove Menu from GUI
set guioptions-=m
" Remove Toolbar from GUI
set guioptions-=T

" Don't show preview windows for autocompletion
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

" Remeber 1000 last ex-commands
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

" Make unnamed register to be the cliboard register.
if has('linux')
  set clipboard=unnamedplus
elseif has('win32') || has('win64')
  set clipboard=unnamed
endif


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

" Section: Autocommands {{{1
if has("autocmd")
  augroup mygroup
    " Remove ALL autocommands for the current group.
    autocmd!

    " Make Vim remember where I left off.
    autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \  exe "normal g`\"" |
            \  endif

    " Trim empty lines at the end of the file.
    autocmd BufWritePre * call TrimEndLines()

    autocmd BufRead,BufNewFile *.mot  setfiletype srec
    autocmd BufRead,BufNewFile *.src,*.asm,*.lst  setfiletype asm8051
    autocmd BufRead,BufNewFile *.md setfiletype mdl

    " Remove trailing whtiespace
    autocmd BufWritePre *.c,*.cpp,*.py,*.md,*.mtd,*.asm,*.lst,*.src :call StripTrailingWhitespaces()

    " tabstop - Number of spaces that a <Tab> in the file counts for.
    "   i.e. if there is a tab in the file when I read it, this is the number
    "   of spaces that I will see.
    " softtabstop - Number of spaces that a <Tab> counts for while performing
    "   editing operations, like inserting <Tab> or using <BS>.
    " shiftwidth - Number of spaces to use for each step of (auto)indent.
    "   Used for 'cindent', >>, <<, etc.
    " expandtab - Convert tabs to spaces.
    autocmd FileType * setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

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
    retab!

  augroup END

endif

" Section: Mappings {{{1
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
nnoremap <silent><C-F9> :lprev<cr>zz
nnoremap <silent><C-F10> :lnext<cr>zz
nnoremap <silent><M-F9> :cfirst<cr>
nnoremap <silent><M-F10> :clast<cr>
nnoremap <silent><leader>mm :set lines=999 columns=999<cr>
nnoremap <silent><leader>mn :set lines=999 columns=80<cr>

nnoremap <silent><F6> :YRShow<CR>

nnoremap <silent><F5> :GundoToggle<CR>

nnoremap <C-S-P> :call SynStack()<cr>

nnoremap <Space> za

" Bubbling commands are taken from  http://vimcasts.org/episodes/bubbling-text/
" Bubble single lines
nnoremap <C-Up> [e
nnoremap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
