" Vim
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"
"----------------------------------------------------------------------
" Last change: <Wed, 2019/02/06 12:16:54 arwagner l00lnxwagner.desy.de>
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

" Do not set encoding anymore to display file encoding properly and
" prevent vim from recoding on the fly.
"-" set encoding=utf-8

" These chars are utf and should work in general, though they might
" break in some strange terminals. The default ^I is unreadable.
" Paragraph »·↩…↪¶¬↲↳
set listchars=tab:»·,trail:·,eol:↩,extends:…,precedes:↪
set showbreak=↪
set list

" Get rid of the toolbar in GUI version
set guioptions-=T
set guioptions+=c
set guioptions=aegimrLtc
set guioptions=aegirLtc

" Always use vertical diff
set diffopt+=vertical

" by default use ,<anything> for maps
let mapleader = ","
let maplocalleader = ","

"      Enable syntax highlighting
syntax on

" ----------------------------------------------------------------------
" Version dependend stuff
" ----------------------------------------------------------------------
if (version >= 700)
   " Enable right mouse pop ups for spellcheck
   set mousemodel=popup_setpos
   " Spell checking
   " - british english:
   nnoremap ,Se   :setlocal spell spelllang=en_gb<cr>
   " - galelic
   nnoremap ,Sg   :setlocal spell spelllang=en_gd<cr>
   " - german
   nnoremap ,Sd   :setlocal spell spelllang=de<cr>
   " ,? in normal mode is ctrl-x-s
   nnoremap ,?    is

   " :te for tabedit (:te is normally tear-off in w32-gui
   nmap :te    :tabe

   " vim 7 introduces undo branches. Map old undo functions to the new ones
   nmap u      g-
   nmap <C-R>  g+

   " Highlight the current line by default only in GUI
   " (consoles get really slow with this...)
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

if (version < 702)
    call add(g:pathogen_disabled, 'tagbar')
endif

if (version < 703)
    call add(g:pathogen_disabled, 'gundo')
endif

if has("folding")
   " By default: don't fold text automatically
   set foldmethod=manual
endif

" Collect all the backup and swap files in one dir First try a local
" subdir (intended for very important files to keep backup end swap
" files within the central backup), then the global ones. Add /tmp for
" vim to be able to always open a swap/backup file
set backupdir=./.vimswp,$HOME/tmp,/tmp
set directory=./.vimswp,$HOME/tmp,/tmp

" Using viminfo to cause each invocation of vim to return to
" previous position Note: you may have to change ~/.viminfo to
" point to a directory/file of your choice.  By Dr. Charles
" Campbell.
""" set viminfo='10,\"100,:20,n~/.viminfo
""" set shada=%,'50,\"100,:100,n~/.nviminfo

au BufReadPost * if line("'\"")|execute("normal `\"")|endif


" NOTE for autocmd's: vim handle new files not the same like existing
" files, that is, there is A difference between BufRead and
" BufNewFile!  Empty files are _new_ files.
" ADDITIONALLY:
" from V6 on auto commands can be replaced largely by file type
" plugins (which gives a more readable config...)!

" Use the augroups only to define additional filetypes, then
" rely on ftplugins to work and load the settings as expected.
" Note that ftplugins must be located in
" ~/.vim/after/ftplugins/, otherwise system defaults overwrite
" user settings.

filetype plugin on

augroup mail
" use vim as editor for (PM)Mail. PMMailfiles are called .BOD
" also handle mutt and friends as well as other mail clients like
" Zimbar (mail*)
  au!
  autocmd BufRead     mail*                   set filetype=mail
  autocmd BufRead     *.bod,mutt-*,pico*      set filetype=mail
  autocmd BufNewFile  *.bod,mutt-*,pico*      set filetype=mail
  autocmd BufRead     *.chat                  set filetype=chat
  autocmd BufRead     *.log,*.res             set filetype=log
  autocmd BufNewFile  *.sieve                 set filetype=sieve
  autocmd BufRead     *.sieve                 set filetype=sieve
augroup END

augroup chess
  au!
  autocmd BufRead     *.sor,*.sso             set filetype=scid
  " eng: polyglot's ini-files, using scids syntax is ok here
  autocmd BufRead     *.eng                   set filetype=scid
augroup END

" for historic reasons some Maple Text-Files are called mtx
" Nowadays the canonical name is mpl
augroup maple
  au!
  autocmd BufRead     *.mtx                   set filetype=maple
  autocmd BufNewFile  *.mtx                   set filetype=maple
  autocmd BufRead     *.map                   set filetype=maple
  autocmd BufNewFile  *.map                   set filetype=maple
augroup END

augroup mysql
  au!
  autocmd BufRead     *.dump                  set filetype=mysql
  autocmd BufNewFile  *.dump                  set filetype=mysql
augroup END

augroup MuPAD
  au!
  autocmd BufRead     *.mnb                   set filetype=mupad
  autocmd BufRead     *.mupad                 set filetype=mupad
  autocmd BufNewFile  *.mnb                   set filetype=mupad
  autocmd BufNewFile  *.mupad                 set filetype=mupad
augroup END

augroup Physics
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

augroup wiki
  autocmd BufRead     wwwzb.fz-juelich.de*    set filetype=mediawiki
  " We hardly ever come across Modula-2, however we have a lot of
  " markdown => prefer Markdown
  autocmd BufNewFile,BufReadPost *.md         set filetype=markdown
  autocmd BufNewFile,BufReadPost github.com*  set filetype=markdown
augroup END

augroup mud
  autocmd BufRead     *.mg                    set filetype=text
  autocmd BufNewFile  *.mg                    set filetype=text
augroup END

augroup quickfix
    " handle quickfix and location list windows
    autocmd FileType qf setlocal nowrap
    " jump to the current line by <Enter>
    autocmd FileType qf nmap <buffer> <Enter>  :.cc<cr>
    autocmd FileType qf nmap <buffer> <Enter>  :.ll<cr>
    autocmd FileType qf set nobuflisted
augroup end

" omnicomplete from syntax files on by default
" but also respect available more fancy omnicomlete functions
if has("autocmd") && exists("+omnifunc")
   autocmd Filetype *
      \  if &omnifunc == "" |
      \     setlocal omnifunc=syntaxcomplete#Complete |
      \  endif
endif

augroup skeletons
  :autocmd BufNewFile  *.c       0r $HOME/Templates/C.c
  :autocmd BufNewFile  *.h       0r $HOME/Templates/C.h
  :autocmd BufNewFile  *.f       0r $HOME/Templates/Fortran.f
  :autocmd BufNewFile  *.pl      0r $HOME/Templates/Perl.pl
  :autocmd BufNewFile  *.tex     0r $HOME/Templates/latex.tex
  :autocmd BufNewFile  *.mp      0r $HOME/Templates/MuPad.mp
  :autocmd BufNewFile  *.mupad   0r $HOME/Templates/MuPad.mupad
  :autocmd BufNewFile  *.mma     0r $HOME/Templates/math.mma
  :autocmd BufNewFile  *.md      0r $HOME/Templates/markdown.md
  :autocmd BufNewFile  *.py      0r $HOME/Templates/python.py

  :autocmd BufNewFile  *.mysql   0r $HOME/Templates/mysql.mysql
  :autocmd BufNewFile  *.sql     0r $HOME/Templates/sql.sql
  :autocmd BufNewFile  *.php     0r $HOME/Templates/php4.php

  :autocmd BufNewFile  *.m       set ft=mma   | 0r $HOME/Templates/math.mma
  :autocmd BufNewFile  *.kumac   set ft=paw   | 0r $HOME/Templates/paw.kumac
  :autocmd BufNewFile  *.dump    set ft=mysql | 0r $HOME/Templates/mysql.mysql
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

" :set hlsearch, then select text * will highlight all occurrences
vmap * "yy:let @/='\(' . @y . '\)'<cr>

" In normal mode: TAB and Shift-TAB to change buffers
nmap <TAB>     :bn<CR>
nmap <S-TAB>   :bp<CR>

" Ctrl-C does esc, but doesn't check abbrevieations, C-[ does so remap
" Ctrl-C to real Esc.
inoremap <C-C> <Esc><Esc>

" Don't use Ex mode, use Q for formatting
map  Q         gq

" Change colourschemes
nmap ,ca       :color aw<cr>
nmap ,cd       :color default<cr>
nmap ,ce       :color evening<cr>
nmap ,cm       :color morning<cr>
nmap ,ct       :color xterm16<cr>


" F1 != Help (ThinkPad!!!)
map! <F1>      <ESC>
map  <F1>      <ESC>

" Save
map  <F2>      <ESC>wq
" Load file
" Toggle tagbar
nnoremap <silent> <F5> :TagbarToggle<CR>
nnoremap <silent> <F6> :GundoToggle<CR>

" List buffers
map  <F4>      :ls<cr>:b

" Make the current buffer a scratch buffer
map  <M-F10>   :setlocal buftype=nofile<cr>

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
    exe "'<,'>!pandoc -f markdown -t markdown_github"
endfunction
command! -range=% TablePandoc :call <SID>tableMarkdown()

" source the local file once to add potential disable calls for
" pathogen
if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

"----------------------------------------------------------------------
" Package specific configs
"----------------------------------------------------------------------
" enable pathogen to handle external packages we use
" call it here as this allows to disable some plugins based on the
" environment (e.g. higher python version required)
silent! call pathogen#infect()
call pathogen#helptags()

" syntastic
let g:syntastic_error_symbol             =  "↯↯"
let g:syntastic_warning_symbol           =  "?!"
let g:syntastic_style_error_symbol       =  "->"
let g:syntastic_style_warning_symbol     =  "≈≈"

let g:syntastic_always_populate_loc_list =  1
let g:syntastic_auto_loc_list            =  1
let g:syntastic_check_on_open            =  0
let g:syntastic_check_on_wq              =  0
let g:syntastic_javascript_checkers = ['jshint']
let g:tagbar_compact                     =  1

" shorten syntastic statusline output using marker symbols
let g:syntastic_stl_format = "[%E{↯↯%fe #%e}%B{, }%W{?! %fw #%w}]"

" adopt hight to match the number of errors This avoids a empty space
" in case of only one or two messages.
" cf. https://github.com/scrooloose/syntastic/issues/1678
function! SyntasticCheckHook(errors)
    if !empty(a:errors)
        let g:syntastic_loc_list_height = min([len(a:errors), 5])
    endif
endfunction

" Setup solarized colour scheme with light background and high
" contrast diff mode (giving green/red blocks rather than text)
if has('gui_running')
    set background=light
    colorscheme solarized
else
    if $USER == 'arwagner'
        " This user usually uses a solarized light xterm.
        " (or xfce-term to load solarized light defaults)
        let g:solarized_termtrans = 1
        set background=dark
        colorscheme solarized
    else
        set t_Co=16
        colorscheme default
    endif
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
nnoremap <silent> ,u :call Unite_gitprojectroot()<cr>
nnoremap <silent> ,l :Unite line<CR>
nnoremap <silent> ,g :Unite grep:.<CR>
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
abbr Ghistory  :Glog -- %<cr>:copen<cr>

" Customize airline statusbar
" Disable syntastics integration to save space
let g:airline#extensions#syntastic#enabled = 0
" shorten long branch names to 10 chars
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#whitespace#trailing_format = 't[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'i[%s]'
" Global powerline requires to use the terminal to use some poper font
let g:airline_powerline_fonts=1

" shorten mode indicators
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }

" Customize lightline.
" - Drop mode marker as we have a full line for it
" - Give location as x:y, ie. char and line
" - Display the git branch, fileformat and encoding
" - give a bit more information for inactive buffers
let g:lightline = {
  \   'colorscheme': 'solarized',
  \   'active': {
  \     'left':[ [ 'gitbranch', 'paste' ],
  \              [ 'readonly', 'filename', 'syntastic' ]
  \     ]
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
  \     'gitbranch': 'LightlineFugitive',
  \     'filename': 'LightlineFilename',
  \     'fileformat': 'LightlineFileformat',
  \     'filetype': 'LightlineFiletype',
  \     'syntastic': 'SyntasticStatuslineFlag',
  \   }
  \ }

  function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : 'No Name'
    let modified = &modified ? ' +' : ''
    return filename . modified
  endfunction
  function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction
  function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
  endfunction
  function! LightlineFugitive()
      if exists('*fugitive#head')
          let branch = fugitive#head()
          return branch !=# '' ? '['.branch.']' : ''
      endif
      return ''
  endfunction

if has('gui_running')
   " guifont for coding
   let font = {"name" : "Hack Nerd Font", "size" : "10.5"}

    let g:airline_theme="papercolor"

   " check if font exist and set it only if it is available
   call system("fc-list -q " . font.name)
   if has("unix") && !v:shell_error
       let g:airline_powerline_fonts=1
       let &guifont=join(values(font))
    endif

   if has('win32')
      set guifont=Courier_New:h11:cANSI
   endif

   if has('gui_macvim')
      set guifont=Courier:h14
   endif

   set background=light
else
    let g:airline_theme="base16"
    let g:airline_symbols_ascii = 1
endif

" Load local changes to the above to adopt to user specific local
" needs. This is the second call
if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif
