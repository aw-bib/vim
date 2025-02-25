" Vim
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"
"----------------------------------------------------------------------
" Last change: <Tue, 2025/02/11 13:10:10 arwagner l00lnxaw.desy.de>
"----------------------------------------------------------------------

set titlestring=%f%=\ %(%M%R%)\ %y
if &term == "screen"
  set t_ts=^[k
  set t_fs=^[\
endif
if &term == "screen" || &term == "xterm"
  set title
endif


" backspace:  '2' allows backspacing" over
" indentation, end-of-line, and start-of-line.
set backspace=2

" errorbells: damn this beep!  ;-)
set noerrorbells
set t_vb=
set visualbell

" formatoptions:  Options for the "text format" command ("gq")
set formatoptions=tcrqnj

" hidden:  Allow "hidden" buffers.  A must-have!
set hidden

" hlsearch :  highlight search - show the current search pattern
" This is a nice feature sometimes - but it sure can get in the
" way sometimes when you edit.
set nohlsearch
" Set incremental search, that is highlight search tag while
" typing
set incsearch

" ignorecase:  ignore the case in search patterns?
set ignorecase
" but: not if explicitly typed uppercase so be smart! ;)
set smartcase

" laststatus:  show status line?  Yes, always!
set laststatus=2

" magic:  Use 'magic' patterns  (extended regular expressions)
" in search patterns?  Certainly!  (I just *love* "\s\+"!)
set magic

" sessionoptions: do not store macros, they are loaded by
" filetypes anyway and this shortens and eases up the
" session-file
set sessionoptions=blank,buffers,curdir,folds,winsize,winpos

" shiftwidth:  Number of spaces to use for each
"              insertion of (auto)indent.
set shiftwidth=4
"
" Do no expand tabs by default but leave them. Some filetype plugins
" will overwrite this.
set noexpandtab

" Set tabstob to be equivalent to 4 spaces. Set softtabstop to be the
" same. This is consistent e.g. with Python guidelines.
set tabstop=4
set softtabstop=4

" shortmess:   Kind of messages to show. Abbreviate them all!
set shortmess=at

" showcmd:     Show current uncompleted command?  Absolutely!
set showcmd
"
" showmatch:   Show the matching bracket for the last ')'?
set showmatch
"
" showmode:    Show the current mode? YEEEEEEEEESSSSSSSSSSS!
set showmode

" suffixes:    Ignore filename with any of these suffixes
"              when using the ":edit" command.
"              Most of these are files created by LaTeX.
set suffixes=.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar,.ilg,.bbl,.toc,.ind,.axp,.i386,.hpux,.osf1,.pyc

" Give a visible choice:
set wildmenu
set wildignore=.o,.exe,.dll,.so,.*~

" Enable :find to dive in to subdirs
set path+=**

" startofline:  no:  do not jump to first character with page
" commands, ie keep the cursor in the current column.
set nostartofline

" statusline:  customize contents of the windows' status line.
" Show the current buffer number and filename with info on
" modification, read-only, and whether it is a help buffer
" (show only when applied), on the right hand side show
" [curssorposition, line:lines in buffer] percentage of
" file viewed
" set statusline=[%n]\ %f\ %(\ (%M%R%H)%)%=[%2c%V,%3l:%L]\ %p%%\
set statusline=[%n]\ %f\ %(\(%M%R)\ %)%y\ %{&ff}%=%{fugitive#statusline()}\ [%2c%V,%3l:%L]\ %p%%

" whichwrap:
" Allow jump commands for left/right motion to wrap to previous/next
" line when cursor is on first/last character in the line:
set whichwrap=<,>,h,l,[,]

" do not update screen while executing macros
set lazyredraw

set nocompatible             " Use Vim defaults (much better!)
set ai                       " always set autoindenting on
set backup                   " keep a backup file
set tw=70
set ruler
set autowrite
set cpt=.,b,u

" These chars are utf and should work in general, though they might
" break in some strange terminals. The default ^I is unreadable.
" Paragraph »·↩…↪¶¬↲↳
set listchars=tab:»·,trail:·,eol:↩,extends:…,precedes:↪
set showbreak=↪
set list

" Get rid of the toolbar in GUI version
set guioptions=acegiLrt

" Always use vertical diff
set diffopt+=vertical

"" by default use ,<anything> for maps
""let mapleader = ","
""let maplocalleader = ","
" use ä as leader for mappings. This is not used in vim and convenient
" on German keyboards.
let mapleader = "ä"
let maplocalleader = "ä"

"      Enable syntax highlighting
syntax on

" enable mouse in terminal (if terminal supports it)
set mouse=a

" ----------------------------------------------------------------------
" Version dependend stuff
" ----------------------------------------------------------------------
if (version >= 700)
   " Enable right mouse pop ups for spellcheck
   set mousemodel=popup_setpos
   " Spell checking
   " - british english:
   nnoremap <Leader>Se   :setlocal spell spelllang=en_gb<cr>
   " - gaidhlig
   nnoremap <Leader>Sg   :setlocal spell spelllang=en_gd<cr>
   " - german
   nnoremap <Leader>Sd   :setlocal spell spelllang=de<cr>
   " ,? in normal mode is ctrl-x-s
   nnoremap <Leader>?    is

   " vim 7 introduces undo branches. Map old undo functions to the new ones
   nmap u      g-
   nmap <C-R>  g+

   " Highlight the current line by default only in GUI
   " (consoles get really slow with this...)
   " TODO revisit performance issues seems fixed
   if has("gui_running")
       set cursorline
   endif

endif

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

" highlight column after 'textwidth'
if (version >= 703)
    set colorcolumn=+1
endif

if (version < 703)
    call add(g:pathogen_disabled, 'gundo')
endif

if (version > 704)
    " word count function for the status line
    let g:word_count=wordcount().words
    function WordCount()
        if has_key(wordcount(),'visual_words')
            let g:word_count=wordcount().visual_words."/".wordcount().words " count selected words
        else
            let g:word_count=wordcount().cursor_words."/".wordcount().words " or shows words 'so far'
        endif
        return g:word_count
    endfunction

endif


if has("folding")
   " By default: don't fold text automatically
   set foldmethod=manual
endif

" Collect all the backup and swap files in one dir First try a local
" subdir (intended for very important files to keep backup and swap
" files within the central backup), then the global ones. Add /tmp for
" vim to be able to always open a swap/backup file
set backupdir=./.vimswp,$HOME/tmp,/tmp
set directory=./.vimswp,$HOME/tmp,/tmp

autocmd BufReadPost * if line("'\"")|execute("normal `\"")|endif

" NOTE for autocmd's: vim handles new files not the same like existing
" files, that is, there is A difference between BufRead and
" BufNewFile!  Empty files are _new_ files.
" ADDITIONALLY:
" From v6 on auto commands can be replaced largely by file type
" plugins (which gives a more readable config...)!

" Use the augroups only to define additional filetypes, then
" rely on ftplugins to work and load the settings as expected.
" Note that ftplugins must be located in
" ~/.vim/after/ftplugins/, otherwise system defaults overwrite
" user settings.

filetype plugin on

augroup mail
" use vim as editor for (PM)Mail. PMMailfiles are called .BOD
" also handle mutt and friends as well as other mail clients
" use `autocmd!` to clear already existing defs from vimrc
  autocmd!
  autocmd BufRead     mail*                   set filetype=mail
  autocmd BufRead     *.bod,mutt-*,pico*      set filetype=mail
  autocmd BufNewFile  *.bod,mutt-*,pico*      set filetype=mail
  autocmd BufRead     *.chat                  set filetype=chat
  autocmd BufRead     *.log,*.res             set filetype=log
  autocmd BufNewFile  *.sieve                 set filetype=sieve
  autocmd BufRead     *.sieve                 set filetype=sieve
augroup END

augroup chess
  autocmd!
  autocmd BufRead     *.sor,*.sso             set filetype=scid
  " eng: polyglot's ini-files, using scids syntax is ok here
  autocmd BufRead     *.eng                   set filetype=scid
augroup END

" for historic reasons some Maple Text-Files are called mtx
" Nowadays the canonical name is mpl
augroup maple
  autocmd!
  autocmd BufRead     *.mtx                   set filetype=maple
  autocmd BufNewFile  *.mtx                   set filetype=maple
  autocmd BufRead     *.map                   set filetype=maple
  autocmd BufNewFile  *.map                   set filetype=maple
augroup END

augroup mysql
  autocmd!
  autocmd BufRead     *.dump                  set filetype=mysql
  autocmd BufNewFile  *.dump                  set filetype=mysql
augroup END

augroup MuPAD
  autocmd!
  autocmd BufRead     *.mnb                   set filetype=mupad
  autocmd BufRead     *.mupad                 set filetype=mupad
  autocmd BufNewFile  *.mnb                   set filetype=mupad
  autocmd BufNewFile  *.mupad                 set filetype=mupad
augroup END

augroup Physics
  autocmd!
  autocmd BufRead     *.kumac                 set filetype=paw
  autocmd BufRead     *.dta                   set filetype=parameter
  autocmd BufRead     *.scn                   set filetype=parameter
  autocmd BufRead     *.C                     set filetype=root
  autocmd BufRead     *.input                 set filetype=axiom
  autocmd BufRead     *.mma                   set filetype=mma
  autocmd BufNewFile  *.mma                   set filetype=mma
  autocmd BufRead     *.prc                   set filetype=form
  autocmd BufNewFile  *.prc                   set filetype=form
  autocmd BufRead     *.fh                    set filetype=form
  autocmd BufNewFile  *.fh                    set filetype=form
augroup END

augroup mud
  autocmd!
  autocmd BufRead     *.mg                    set filetype=text
  autocmd BufNewFile  *.mg                    set filetype=text
augroup END

augroup quickfix
  autocmd!
  " handle quickfix and location list windows
  autocmd FileType qf setlocal nowrap
  " jump to the current line by <Enter>
  autocmd FileType qf nmap <buffer> <Enter>  :.cc<cr>
  autocmd FileType qf nmap <buffer> <Enter>  :.ll<cr>
  autocmd FileType qf set nobuflisted
  " autocmd FileType qf syntax match ConcealedDetails /\v^[^|]*\|[^|]*\| / conceal
  " autocmd FileType qf syntax match ConcealedDetails /[^/]*[/]/ conceal
  autocmd FileType qf syntax match ConcealedDetails /\v^[^|]*/ conceal
  autocmd FileType qf set conceallevel=2
  autocmd FileType qf set concealcursor=nvic
augroup end

augroup templates
  autocmd!
  autocmd BufNewFile  *.c       0r $HOME/Templates/C.c
  autocmd BufNewFile  *.h       0r $HOME/Templates/C.h
  autocmd BufNewFile  *.f       0r $HOME/Templates/Fortran.f
  autocmd BufNewFile  *.pl      0r $HOME/Templates/Perl.pl
  autocmd BufNewFile  *.tex     0r $HOME/Templates/latex.tex
  autocmd BufNewFile  *.mp      0r $HOME/Templates/MuPad.mp
  autocmd BufNewFile  *.mupad   0r $HOME/Templates/MuPad.mupad
  autocmd BufNewFile  *.mma     0r $HOME/Templates/math.mma
  autocmd BufNewFile  *.md      0r $HOME/Templates/markdown.md
  autocmd BufNewFile  *.py      0r $HOME/Templates/python.py

  autocmd BufNewFile  *.mysql   0r $HOME/Templates/mysql.mysql
  autocmd BufNewFile  *.sql     0r $HOME/Templates/sql.sql
  autocmd BufNewFile  *.php     0r $HOME/Templates/php4.php

  autocmd BufNewFile  *.m       set ft=mma   | 0r $HOME/Templates/math.mma
  autocmd BufNewFile  *.kumac   set ft=paw   | 0r $HOME/Templates/paw.kumac
  autocmd BufNewFile  *.dump    set ft=mysql | 0r $HOME/Templates/mysql.mysql
augroup END

" omnicomplete from syntax files on by default
" but also respect available more fancy omnicomlete functions
if has("autocmd") && exists("+omnifunc")
   autocmd Filetype *
      \  if &omnifunc == "" |
      \     setlocal omnifunc=syntaxcomplete#Complete |
      \  endif
endif

" ----------------------------------------------------------------------
" Mappings on all platfroms
" ----------------------------------------------------------------------

" Resize windows:
map  <Leader>-        <ESC>:resize -10 <CR>
map  <Leader>+        <ESC>:resize +10 <CR>
map  <Leader>_        <ESC>:vertical resize -20 <CR>
map  <Leader>*        <ESC>:vertical resize +20 <CR>
nnoremap <M-j> :resize -1<CR>
nnoremap <M-k> :resize +1<CR>
nnoremap <M-h> :vertical resize -1<CR>
nnoremap <M-l> :vertical resize +1<CR>
" set the width of the current window to 76 chars (= normal editing width)
map  <Leader>7        :vertical resize 76<cr>
" Jump to tag under cursor (otherwise ugly on german keyboards...)
map  <Leader>,        
" :ptag under cursor
map  <Leader>.        <C-W>}

" Run makeprg
map  <Leader>m        :make<cr>

" :set hlsearch, then select text * will highlight all occurrences
vmap * "yy:let @/='\(' . @y . '\)'<cr>

" "" In normal mode: TAB and Shift-TAB to change buffers
" "nmap <TAB>     :bn<CR>
" "nmap <S-TAB>   :bp<CR>

" Ctrl-C does esc, but doesn't check abbrevieations, C-[ does so remap
" Ctrl-C to real Esc.
inoremap <C-C> <Esc><Esc>

" Don't use Ex mode, use Q for formatting
map  Q         gq

" Change colourschemes
nmap <Leader>ca       :color aw<cr>
nmap <Leader>cd       :color default<cr>
nmap <Leader>ce       :color evening<cr>
nmap <Leader>cm       :color morning<cr>
nmap <Leader>ct       :color xterm16<cr>


" F1 != Help (ThinkPad!!!)
map! <F1>      <ESC>
map  <F1>      <ESC>

" Save
map  <F2>      <ESC>wq
" Load file
nnoremap <silent> <F6> :GundoToggle<CR>

" List buffers
map  <F4>      :ls<cr>:b

" Make the current buffer a scratch buffer
map  <M-F10>   :setlocal buftype=nofile<cr>

" Use %% to expand path of current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Map umlauts to usual keys from US keyboards
" repeat last f, t, F, T
noremap ö   ;
" open command line
noremap Ö   :
" paragraph backwards
noremap ü   {
noremap Ü   [
" ä is used as mapleader
noremap Ä   }
" This is the map leader:
" noremap ä   \

" if vim is called without a file, then set buftype to scratch
" ok, this is like emacs, but handy ;)
if argc() == 0
   setlocal buftype=nofile
endif

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Start an editor session by loading the Session.vim in the current dir
nnoremap <Leader>s    :so Session.vim<cr>

" Let :W behave as :w
nmap :W :w

" insert blank lines with <enter>
" https://stackoverflow.com/questions/37211250
function! NewlineWithEnter()
    if !&modifiable
      execute "normal! \<CR>"
    else
      execute "normal! o\<esc>"
    endif
endfunction
nnoremap <CR> :call NewlineWithEnter()<CR>

" balance braces
inoremap  ( <C-R>=Double("(",")")<CR>
inoremap  [ <C-R>=Double("[","]")<CR>
inoremap  { <C-R>=Double("{","}")<CR>

" also quotes are usually balanced
inoremap  ' <C-R>=Double("'","'")<CR>
inoremap  " <C-R>=Double("\"","\"")<CR>

" -------------------------------------------------------------------
" Abbreviations - General Editing - Inserting Dates and Times
" -------------------------------------------------------------------
"
" First, some command to add date stamps (with and without time).
" [These abbreviations are used with the mapping for ",L".]

" Example: 04.09.00
iab Ydate <C-R>=strftime("%d.%m.%y")<CR>
" Example: 14:28
iab Ytime <C-R>=strftime("%H:%M")<CR>

" man strftime:     %X      locale's appropriate time representation
" Example: 04.09.00 - 09:53
iab YDT           <C-R>=strftime("%d.%m.%y - %H:%M")<CR>
iab YDATE <C-R>=strftime("%a %b %d %T %Z %Y")<CR>

" insert the current filename *with* path:
iab YPATHFILE <C-R>=expand("%:p")<cr>
" insert the current filename *without* path:
iab YFILE <C-R>=expand("%:t:r")<cr>
" insert the path of current file:
iab YPATH <C-R>=expand("%:h")<cr>

" -------------------------------------------------------------------
" timestamp.vim: Timestamping for files, global plugin
" -------------------------------------------------------------------

let g:timstamp_1='\(Last update:)'
let g:timstamp_2='\(Last \?\(changed\?\|modified\):\).*$!\1 <%a, %Y/%m/%d %H:%M:%S #u #h>'
let g:timstamp_automask='*'
let g:timstamp_modelines=40

" -------------------------------------------------------------------
" double brackets...
" -------------------------------------------------------------------

function! Double (left,right)
    if strpart(getline(line(".")),col(".")-2,2) == a:left . a:right
   return "\<C-O>x"
    else
   return a:left . a:right . "\<Left>"
    endif
endfunction

" -------------------------------------------------------------------
" Smart Backspace: For TeX or HTML it removes e.g. Umlauts...
" Thx. to Benji Fisher for pointing this out.
" -------------------------------------------------------------------
fun! SmartBS(pat)
  let init = strpart(getline("."), 0, col(".")-1)
  let len = strlen(matchstr(init, a:pat . "$")) - 1
  if len > 0
    execute "normal!" . len . "X"
  endif
endfun

fun! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfun

" -------------------------------------------------------------------
" tablePandoc: Use pandoc to convert tab or | delimited lists to a
" nicely readable table. Uses pandoc and markdown_github as output
" format. Select block and :tableMarkdown
" Minimal adoptoin of
" http://www.rubenverweij.nl/2016/03/quick-vim-tip-convert-piped-table-to.html
" -------------------------------------------------------------------
function! s:tableMarkdown() range
    exe "'<,'>s/\t/\|/g"
    exe "'<,'>Tabularize /|"
    let hsepline= substitute(getline("."),'[^|]','-','g')
    exe "norm! o" .  hsepline
    exe "'<,'>s/-|/ |/g"
    exe "'<,'>s/|-/| /g"
    exe "'<,'>s/^| \\|\\s*|$\\||//g"
    exe "'<,'>!pandoc -f markdown -t gfm"
endfunction
command! -range=% TablePandoc :call <SID>tableMarkdown()

" initialize lightline global config: this makes it accessible in
" .vimrc.local
let g:lightline = {}

" source the local file once to add potential disable calls for
" pathogen
if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

" Access system clipboard in tmux
" cf. https://unix.stackexchange.com/questions/645475/
let g:clipboard = {
  \   'name': 'Tmux',
  \   'copy': {
  \      '*': ['tmux', 'load-buffer', '-'],
  \    },
  \   'paste': {
  \      '*': ['tmux', 'save-buffer', '-'],
  \   },
  \   'cache_enabled': 1,
  \ }

"----------------------------------------------------------------------
" Package specific configs
"----------------------------------------------------------------------
" enable pathogen to handle external packages we use
" call it here as this allows to disable some plugins based on the
" environment (e.g. higher python version required)
silent! call pathogen#infect()
call pathogen#helptags()

if (version >= 800)
" vim8 introduces package management almost like pathogen
" load them and don't forget to generate the help-tags
    packloadall
endif
silent! helptags ALL

" ALE
let g:ale_sign_error         = ">>"
let g:ale_sign_warning       = "?!"
let g:ale_sign_style_error   = "->"
let g:ale_sign_style_warning = "≈≈"
let g:ale_sign_info          = 'ii'
let g:ale_set_loclist = 1
let g:ale_change_sign_column_color = 0

" Setup solarized colour scheme with light background and high
" contrast diff mode (giving green/red blocks rather than text)
if has('gui_running')
    set background=light
    colorscheme solarized
   " guifonts for coding
   " Listed here are a number of nicely readable monospace fonts for
   " coding. All are `Nerd Fonts` including special chars like
   " powerline etc.
   " https://www.nerdfonts.com/
   "
   " let font = {"name" : "Hack Nerd Font", "size" : "10.5"}
   " let font = {"name" : "SauceCodePro Nerd Font", "size" : "10.5"}
   " let font = {"name" : "RobotoMono Nerd Font", "size" : "10.5"}
   " let font = {"name" : "OverpassMono Nerd Font", "size" : "10.5"}
   " let font = {"name" : "mononoki Nerd Font", "size" : "10.5"}

   let font = {"name" : "BlexMono Nerd Font", "size" : "Medium 10.5"}

   " check if font exist and set it only if it is available
   " Note to quote to handle fonts with spaces.
   call system("fc-list -q \"" . font.name. "\"")
   if has("unix") && !v:shell_error
        let &guifont=join(values(font))
   endif

   if has('win32')
      set guifont=Courier_New:h11:cANSI
   endif

   if has('gui_macvim')
      set guifont=Courier:h14
   endif
else
    if $USER == 'arwagner'
        " This user usually uses a solarized light xterm.
        " (or xfce-term to load solarized light defaults)
        let g:solarized_termtrans = 1
        set background=dark
        colorscheme solarized

        " " For markdown use monokai to distinguish docs from code
        " " TODO This confuses lightline
        " augroup colours
        "     autocmd!
        "     autocmd BufEnter * colorscheme solarized
        "     autocmd BufEnter *.md colorscheme monokai
        "     autocmd BufEnter vimwiki colorscheme monokai
        " augroup END
    else
        set t_Co=16
        colorscheme default
    endif
    " Some Terminals do not support undercurl (eg. xterm). In this
    " case the highlighting is effectively disabled :S
    " Use " underline which is safe.
    " Cf. https://github.com/vim/vim/issues/6174
    highlight SpellBad cterm=underline
    " Force italics for comments, like GUI
    highlight Comment cterm=italic
endif

let g:solarized_diffmode="high"

function! Unite_gitprojectroot()
  " use projectroot#guess() to start recursive file searching wihtin a
  " git project. Adoped from
  " https://johnhamelink.com/2014/10/31/making-unite-use-project-root
  " Consider using file_rec/async instead of file_rec/git to handle
  " more than git
  execute ':Unite  -buffer-name=files -start-insert buffer file_rec/git:'.projectroot#guess().'/'
  endfunction

" non-fancy version without project root:
" nnoremap <silent> ,u :Unite buffer file_rec/git file<CR>
nnoremap <silent> <Leader>u :call Unite_gitprojectroot()<cr>
nnoremap <silent> <Leader>l :Unite line<CR>
nnoremap <silent> <Leader>g :Unite grep:.<CR>
call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'winheight': 10,
\   'direction': 'botright',
\   'prompt': '> ',
\ })

" Enable silver searcher for unite if it is available
if executable('ag')
    let g:unite_source_grep_command="ag"
    let g:unite_source_grep_default_opts="-i --nocolor --nogroup"
    set grepprg=ag\ --nogroup\ --nocolor
endif

" allow .. to go up one level in a fugtive tree buffer
" from vimcasts #34
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

" Autoclean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Explore the history of the current file
abbr Ghistory  :Gclog -- %<cr>:copen<cr>

" Customize lightline
" - Drop mode marker as we have a full line for it
" - Give location as x:y, ie. char and line
" - Display the git branch, fileformat and encoding
" - give a bit more information for inactive buffers
" Note that separators and stuff require a good terminal font,
" preferably one of the Nerd fonts. Otherwise, reset this to something
" available via vimrc.local
let g:lightline = {
  \   'colorscheme': 'solarized',
  \   'active': {
  \     'left':[ [ 'gitbranch', 'paste' ],
  \              [ 'readonly', 'filename'],
  \              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
  \     ],
  \     'right': [ [ 'lineinfo' ],
  \              [ 'percent', 'wordcount' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ]
  \            ]
  \   },
  \   'inactive': {
  \     'left':[ [ 'gitbranch' ],
  \              [ 'readonly', 'filename' ]
  \     ]
  \   },
  \   'component': {
  \     'lineinfo': '%2v:%3l',
  \   },
  \   'component_function': {
  \     'wordcount': 'WordCount',
  \     'gitbranch': 'LightlineFugitive',
  \     'filename': 'LightlineFilename',
  \     'fileformat': 'LightlineFileformat',
  \     'filetype': 'LightlineFiletype',
  \   },
  \   'separator': { 'left': '', 'right': '' },
  \   'subseparator': { 'left': '', 'right': '' }
  \ }


" configure lightline-ale
let g:lightline.component_expand = {
    \  'linter_checking': 'lightline#ale#checking',
    \  'linter_infos': 'lightline#ale#infos',
    \  'linter_warnings': 'lightline#ale#warnings',
    \  'linter_errors': 'lightline#ale#errors',
    \  'linter_ok': 'lightline#ale#ok',
    \ }

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }


function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : 'No Name'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction
function! LightlineFileformat()
  if exists("g:loaded_webdevicons")
      return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol()) : ''
  else
      return winwidth(0) > 70 ? &fileformat : ''
  endif
endfunction
function! LightlineFiletype()
    if exists("g:loaded_webdevicons")
      return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
    else
        return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
    endif
endfunction
function! LightlineFugitive()
    " let branch = fugitive#head()
    " Fugitive changed the API from fugitive#head() -> FugitiveHead()
    let branch = FugitiveHead()
    " shorten branch names to max 10 chars
    if len(branch) > 10
       let branch = ''.branch[0:9].'…'
    endif
    return branch !=# '' ? branch.':' : ''
endfunction

" vimwiki - personalized wikis for vim
let g:vimwiki_listsyms = ' ○◐●x'"
let g:vimwiki_hl_headers = 1
" use usual syntax hightlighting for code blocks marked like github
let automatic_nested_syntaxes = 1
" define wikis available, switch with <Leader>ws
" use symlinks in case they should live on some cloud storage etc.
let g:vimwiki_list = [
    \{'path': "$HOME/vimwiki/work", 'syntax': 'markdown', 'ext': '.md'},
    \{'path': "$HOME/vimwiki/priv", 'syntax': 'markdown', 'ext': '.md'},
    \{'path': "$HOME/vimwiki/man",  'syntax': 'markdown', 'ext': '.md'}
    \]

command! Diary VimwikiDiaryIndex
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks
    autocmd FileType vimwiki map c :call ToggleCalendar()<cr>
augroup end

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Load local changes to the above to adopt to user specific local
" needs. This is the second call
if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

