" Vim
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"
"--------------------------------------------------
" Last change: <Wed, 2014/08/06 17:18:48 awagner invenio.mlz-garching.de>
"--------------------------------------------------

let &titlestring = expand ("%:p:~:.:h")

" backspace:  '2' allows backspacing" over
" indentation, end-of-line, and start-of-line.
set backspace=2

" errorbells: damn this beep!  ;-)
set noerrorbells
set t_vb=
set visualbell

" formatoptions:  Options for the "text format" command ("gq")
set formatoptions=tcrqn

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
" same. This is consistent e.g. with Python guidlines.
set tabstop=4
set softtabstop=4

" shortmess:   Kind of messages to show.   Abbreviate them all!
set shortmess=at

" showcmd:     Show current uncompleted command?  Absolutely!
set showcmd
"
" showmatch:   Show the matching bracket for the last ')'?
set showmatch
"
" showmode:    Show the current mode?  YEEEEEEEEESSSSSSSSSSS!
set showmode

" suffixes:    Ignore filename with any of these suffixes
"              when using the ":edit" command.
"              Most of these are files created by LaTeX.
set suffixes=.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar,.ilg,.bbl,.toc,.ind,.axp,.i386,.hpux,.osf1,.pyc

" Give a visible choice:
set wildmenu
set wildignore=.o,.exe,.dll,.so,.*~

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
set statusline=[%n]\ %f\ %(\(%M%R)\ %)%y\ %{&ff}%=%{fugitive#statusline()}\ [%2c%V,%3l:%L]\ %p%%\ 

" whichwrap:
" Allow jump commands for left/right motion to wrap to previous/next
" line when cursor is on first/last character in the line:
set whichwrap=<,>,h,l,[,]

" do not update screen while executing macros
set lazyredraw

set nocompatible             " Use Vim defaults (much better!)
set ai                       " always set autoindenting on
set backup                   " keep a backup file
set viminfo=%,'50,\"100,:100,n~/.viminfo
set tw=70
set ruler
set autowrite
set cpt=.,b,u

" Get rid of the toolbar in GUI version
set guioptions-=T
set guioptions+=c

" by default use ,<anything> for maps
let mapleader = ","
let maplocalleader = ","

"      Enable syntax highlighting
syntax on

" ----------------------------------------------------------------------
" Version dependend stuff
" ----------------------------------------------------------------------
if (version >= 700)
   " Enable right mouse popups for spellcheck
   set mousemodel=popup_setpos
   " Spell checking
   nnoremap ,Se   :setlocal spell spelllang=en_gb<cr>
   nnoremap ,Sg   :setlocal spell spelllang=en_gd<cr>
   " de_20: new german - de_19: old german
   nnoremap ,Sd   :setlocal spell spelllang=de_20<cr>
   " ,? in normal mode is ctrl-x-s
   nnoremap ,?    is

	" :te for tabedit (:te is normally tearoff in w32-gui
   nmap :te    :tabe 

	" vim 7 introduces undo branches. map old undo functions to the new ones
	nmap u      g-
	nmap <C-R>  g+

	" Highlight the current line by default only in GUI
	" (consoles get really slow with this...)
	if has("gui_running")
		set cursorline
	endif
	
endif

if has("folding")
   " By default: don't fold text automatically
   set foldmethod=manual
endif

" vsplit opens window on the right hand side
if has("vertsplit")
   set splitright
endif

" Collect all the backup and swap files in one dir
" First try a local subdir (intended for very important files to
" keep backup and swapfiles within the central backup), then the
" golbal ones. Add /tmp for vim to be able to always open a
" swap/backup file
set backupdir=./.vimswp,$HOME/tmp,/tmp
set directory=./.vimswp,$HOME/tmp,/tmp

" ----------------------------------------------------------------------
" Platformdependend stuff: Care for OS/2 and Unix
" ----------------------------------------------------------------------
" Note about $HOSTTYPE
"      has("os2")            = OS/2 Warp
"      i.86                  = Linux   (Intel)
"      alpha                 = True64  (Alpha)

if has("os2")
  " On OS/2: 
  " - Use mode command to resize terminal winodws to Small, Big, Normal
  map  ,ws       <ESC>:!mode 80,25<CR><CR>
  map  ,wb       <ESC>:!mode 160,50<CR><CR>
  map  ,wn       <ESC>:!mode 80,50<CR><CR>
  " Copy backups to save the EA's
  set backupcopy=yes
  set term=builtin_os2ansi
  " 'list' + 'listchars': Great new feature of vim-5.3!
  " This tells Vim which characters to show for expanded TABs,
  " trailing whitespace, and end-of-lines.  VERY useful!!
  set list
  set listcharo=tab:¯\ ,trail:ú,eol:þ
else
   " on Unix
   " To get colors with a color xterminal.
   if has("terminfo")
     set t_Co=8
     set t_Sf=[3%p1%dm
     set t_Sb=[4%p1%dm
   else
     set t_Co=8
     set t_Sf=[3%dm
     set t_Sb=[4%dm
   endif
   " These chars are utf and should work in general, though they might
   " break in some strange terminals. The default ^I is unreadable.
   set listchars=tab:»·,trail:·,eol:¬
   set list
   if $HOSTTYPE == "alpha"
   " For using Vim with xterm or vt100;  BS and Delete keys
      if  &term == "xterm" || &term == "xterm-color"
         set t_kb=
         set t_kD=
      endif
      fixdel
      map <M-F12>    :winpos -6 -6<cr>:set lines=55 columns=115<cr>
      map <C-F12>    :winpos -6 -6<cr>:set lines=25 columns=80<cr>
    endif
    if ($HOSTTYPE =~ "86")
       " All PC's are 86* like i?86 or x86_64
       " open a Filer window for the current directory
       map <F7>       <esc>:!nav&<cr><cr>
       map <M-F12>    :winpos 0 26<cr>:set lines=55 columns=130<cr>
       map <C-F12>    :winpos 0 26<cr>:set lines=25 columns=80<cr>
    endif
endif

" use own color map DO NOT MOVE to earlier line!!
color aw

" Using viminfo to cause each invocation of vim to return to
" previous position Note: you may have to change ~/.viminfo to
" point to a directory/file of your choice.  By Dr. Charles
" Campbell.
set viminfo='10,\"100,:20,n~/.viminfo 
au BufReadPost * if line("'\"")|execute("normal `\"")|endif


" NOTE for autocmd's: vim handle new files not the same like
" existing files, that is, there is a diffrence between BufRead
" and BufNewFile!  Empty files are _new_ files.  ADDITIONALLY:
" from V6 on autocommands can be replaced largely by filetpype
" plugins (which gives a more readable config...)!

" Use the augroups only to define additional filetypes, then
" rely on ftplugins to work and load the settings as expected.
" Note that ftplugins must be located in
" ~/.vim/after/ftplugins/, otherwise systemdefaults overwrite
" usersettings.

filetype plugin on

augroup mail
" use vim as editor for (PM)Mail. PMMailfiles are called .BOD
  au!
  autocmd BufRead     *.bod,mutt-*,pico*              set filetype=mail
  autocmd BufNewFile  *.bod,mutt-*,pico*              set filetype=mail
  autocmd BufRead     *.chat                          set filetype=chat
  autocmd BufRead     *.log,*.res                     set filetype=log
  autocmd BufNewFile  *.sieve                         set ft=sieve
  autocmd BufRead     *.sieve                         set ft=sieve
augroup END

augroup chess
  au!
  autocmd BufRead     *.sor,*.sso                     set filetype=scid
  " eng: polyglot's ini-files, using scids syntax is ok here
  autocmd BufRead     *.eng                           set filetype=scid
augroup END

" for historic reasons some Maple Text-Files are called mtx
" Nowadays the canonical name is mpl
augroup maple
  au!
  autocmd BufRead     *.mtx                           set filetype=maple
  autocmd BufNewFile  *.mtx                           set filetype=maple
  autocmd BufRead     *.map                           set filetype=maple
  autocmd BufNewFile  *.map                           set filetype=maple
augroup END

augroup mysql
  au!
  autocmd BufRead     *.dump                          set filetype=mysql
  autocmd BufNewFile  *.dump                          set filetype=mysql
augroup END

augroup MuPAD
  au!
  autocmd BufRead     *.mnb                           set filetype=mupad
  autocmd BufRead     *.mupad                         set filetype=mupad
  autocmd BufNewFile  *.mnb                           set filetype=mupad
  autocmd BufNewFile  *.mupad                         set filetype=mupad
augroup END

augroup Physics
  autocmd BufRead     *.kumac                         set filetype=paw
  autocmd BufRead     *.dta                           set filetype=parameter
  autocmd BufRead     *.scn                           set filetype=parameter
  autocmd BufRead     *.C                             set filetype=root
  autocmd BufRead     *.input                         set filetype=axiom
  autocmd BufRead     *.mma                           set filetype=mma
  autocmd BufNewFile  *.mma                           set filetype=mma
  autocmd BufRead     *.prc                           set filetype=form
  autocmd BufNewFile  *.prc                           set filetype=form
  autocmd BufRead     *.fh                            set filetype=form
  autocmd BufNewFile  *.fh                            set filetype=form
augroup END

augroup wiki
  autocmd BufRead     wwwzb.fz-juelich.de*            set filetype=mediawiki
augroup END

augroup mud
  autocmd BufRead     *.mg                            set filetype=text
  autocmd BufNewFile  *.mg                            set filetype=text
augroup END

" omnicomplete from syntax files on by default
" but also respect available more fancy omnicomlete functions
if has("autocmd") && exists("+omnifunc")
   autocmd Filetype *
      \  if &omnifunc == "" |
      \     setlocal omnifunc=syntaxcomplete#Complete |
      \  endif
endif

augroup skeletons
  :autocmd BufNewFile  *.c       0r $CHOICESPATH/Templates/C.c
  :autocmd BufNewFile  *.h       0r $CHOICESPATH/Templates/C.h
  :autocmd BufNewFile  *.f       0r $CHOICESPATH/Templates/Fortran.f
  :autocmd BufNewFile  *.pl      0r $CHOICESPATH/Templates/Perl.pl
  :autocmd BufNewFile  *.tex     0r $CHOICESPATH/Templates/latex.tex
  :autocmd BufNewFile  *.mp      0r $CHOICESPATH/Templates/MuPad.mp
  :autocmd BufNewFile  *.mupad   0r $CHOICESPATH/Templates/MuPad.mupad
  :autocmd BufNewFile  *.mma     0r $CHOICESPATH/Templates/math.mma

  :autocmd BufNewFile  *.mysql   0r $CHOICESPATH/Templates/mysql.mysql
  :autocmd BufNewFile  *.sql     0r $CHOICESPATH/Templates/sql.sql
  :autocmd BufNewFile  *.php     0r $CHOICESPATH/Templates/php4.php

  :autocmd BufNewFile  *.m       set ft=mma   | 0r $CHOICESPATH/Templates/math.mma
  :autocmd BufNewFile  *.kumac   set ft=paw   | 0r $CHOICESPATH/Templates/paw.kumac
  :autocmd BufNewFile  *.dump    set ft=mysql | 0r $CHOICESPATH/Templates/mysql.mysql
augroup END

" ----------------------------------------------------------------------
" Mappings on all platfroms
" ----------------------------------------------------------------------

" Resize windows:
map  ,-        <ESC>:resize -10 <CR>
map  ,+        <ESC>:resize +10 <CR>
map  ,_        <ESC>:vertical resize -20 <CR>
map  ,*        <ESC>:vertical resize +20 <CR>
" set the width of the current window to 76 chars (= normal edition width)
map  ,7        :vertical resize 76<cr>
" Jump to tag under cursor (otherwise ugly on german keyboards...)
map  ,,        
" :ptag under cursor
map  ,.        <C-W>}

" Run makeprg
map  ,m        :make<cr>

" In visual mode: TAB and Shift-TAB for indenting
vmap <TAB>     >
vmap <S-TAB>   <

" :set hlsearch, then select text * will highlight all occurences
vmap * "yy:let @/='\(' . @y . '\)'<cr>

" In normal mode: TAB and Shift-TAB to change buffers
nmap <TAB>     :bn<CR>
nmap <S-TAB>   :bp<CR>

" In insert mode: If cursor on whitespace insert tab, otherwise
" do completion (via ^P)
imap <C-Space>  <c-p>
"imap <C-Space>     <c-r>=InsertTabWrapper()<cr>

" CTRL-Tab is Next window (works only for gvim)
noremap  <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
noremap  <C-S-Tab> <C-W>W
inoremap <C-S-Tab> <C-O><C-W>W
cnoremap <C-S-Tab> <C-C><C-W>W

" Don't use Ex mode, use Q for formatting
map  Q         gq

" Change colourschemes
nmap ,ca       :color aw<cr>
nmap ,cd       :color default<cr>
nmap ,ce       :color evening<cr>
nmap ,cm       :color morning<cr>
nmap ,ct       :color xterm16<cr>

" Setup solarized colour scheme with light background and high
" contrast diff mode (giving green/red blocks rathern than text)
set background=light
colorscheme solarized
let g:solarized_diffmode="high"

if has('gui_running')
   if has('win32')
      set guifont=Courier_New:h11:cANSI
   endif
   set background=light
else
   set t_Co=16
   " seems to be inverted on xfce-term?
   " need xfce-term to load solarized light defaults
   set background=dark
endif

" Switch to UTF-8
nmap ,u        :set encoding=utf-8<cr>
set encoding=utf-8

" F1 != Help (ThinkPad!!!)
map! <F1>      <ESC>
map  <F1>      <ESC>

" Save
map  <F2>      <ESC>wq
" Load file
map  <F3>      :Sexplore<cr>
" List buffers
map  <F4>      :ls<cr>:b
" Make the current buffer a scratch buffer
map  <M-F10>   :setlocal buftype=nofile<cr>

" Call vimcommander on F11
noremap <silent> <F11> :cal VimCommanderToggle()<CR>

" if vim is called without a file, then set buftype to scratch
" ok, this is like emacs, but handy ;)
if argc() == 0
   setlocal buftype=nofile
endif

" Start a Window-Command by CTRL-W in insert mode
inoremap <C-W> <C-O><C-W>
" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Start an editor session by loading the Session.vim in the current dir
nnoremap ,s    :so Session.vim<cr>

" Let :W behave as :w
  nmap :W :w

" Quick insertion of an empty line:
"if ("b:modifiable")
   nmap <CR> o
"endif

inoremap  ( <C-R>=Double("(",")")<CR>
inoremap  [ <C-R>=Double("[","]")<CR>
inoremap  { <C-R>=Double("{","}")<CR>

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
"
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
" let g:timstamp_hostname
" let g:timstamp_Hostname
" let g:timstamp_ignorecase
" let g:timstamp_language
let g:timstamp_modelines=40
" let g:timstamp_userid
" let g:timstamp_username
"
"

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

if filereadable("$HOME/.vimrc.local")
    source $HOME/.vimrc.local
endif
