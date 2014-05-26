" Vim highlighting file
"
" Last change: <Wed, 2010/06/02 13:03:51  ZB0134>
" 
" Based upon the file from Dr. Charles E. Campbell, Jr. <cec@gryphon.gsfc.nasa.gov>
" WebSite:      http://www.erols.com/astronaut/vim/
"
" First of all invert screen: black text on white background. But only in the
" GUI. For terminals this is not suitable as not allways the whole line is
" redrawn. So leave the background as it is (otherwise it will give trouble
" with the cursors visibility...)
"
hi clear

let g:colors_name="aw"
hi Normal guifg=black
hi Normal guibg=white 

" Syntax Highlighting Overrides
hi Normal      term=NONE cterm=NONE      gui=NONE     start=<Esc>[m<Esc>[1;32m      stop=t_me     guifg=black             
                                                                                                  
hi Comment     term=NONE cterm=NONE      gui=italic   start=<Esc>[m<Esc>[31;37m     stop=t_me     guifg=Gray50                         ctermfg=cyan
hi Constant    term=NONE cterm=NONE      gui=bold     start=<Esc>[m<Esc>[1;33m      stop=t_me     guifg=darkmagenta                    ctermfg=darkmagenta
hi Error       term=NONE cterm=NONE      gui=bold     start=<Esc>[m<Esc>[1;37;41m   stop=t_me     guifg=yellow      guibg=red          ctermfg=yellow        ctermbg=lightred
hi ErrorMsg    term=NONE cterm=NONE      gui=bold     start=<Esc>[m<Esc>[1;37;41m   stop=t_me     guifg=yellow      guibg=red          ctermfg=yellow        ctermbg=lightred
hi Identifier  term=NONE cterm=NONE      gui=NONE     start=<Esc>[m<Esc>[1;45m      stop=t_me     guifg=magenta                        ctermfg=darkmagenta
" In TeX PreProc means e.g. \section etc.                                                                                 
hi PreProc     term=NONE cterm=NONE      gui=NONE     start=<Esc>[m<Esc>[1;37;44m   stop=t_me     guifg=Black       guibg=yellow       ctermfg=black         ctermbg=yellow
" In TeX Special means input in mathmode e.g. that is normal text                                                  
hi Special     term=NONE cterm=NONE      gui=italic   start=<Esc>[m<Esc>[1;32;44m   stop=t_me     guifg=red                                ctermfg=darkred
hi Statement   term=NONE cterm=NONE      gui=NONE     start=<Esc>[m<Esc>[1;36m      stop=t_me     guifg=blue                           ctermfg=blue
hi Todo        term=NONE cterm=NONE      gui=NONE     start=<Esc>[m<Esc>[1;37;45m   stop=t_me     guifg=white       guibg=magenta      ctermfg=white         ctermbg=magenta
" In TeX this means Fontdirectives etc.                                                                                       
hi Type        term=NONE cterm=NONE      gui=NONE     start=<Esc>[m<Esc>[1;4;32m    stop=t_me     guifg=Red                            ctermfg=darkred
                                                                                                                   
" Editor Groups []                                                                                                 
hi Directory     term=NONE cterm=NONE    gui=NONE     start=<Esc>[m<Esc>[1;33m      stop=t_me     guifg=yellow      guibg=black        ctermfg=yellow         ctermbg=black
hi Question      term=NONE cterm=NONE    gui=NONE     start=<Esc>[m<Esc>[1;33m      stop=t_me     guifg=yellow      guibg=blue         ctermfg=yellow         ctermbg=blue
hi Search        term=NONE cterm=NONE    gui=NONE     start=<Esc>[m<Esc>[1;34m      stop=t_me     guifg=black       guibg=lightgreen   ctermfg=black          ctermbg=lightgreen
hi SpecialKey    term=NONE cterm=NONE    gui=NONE     start=<Esc>[m<Esc>[1;35;7m    stop=t_me     guifg=DarkGray                       ctermfg=darkcyan
hi NonText       term=NONE cterm=NONE    gui=NONE     start=<Esc>[m<Esc>[1;35;7m    stop=t_me     guifg=DarkGray                       ctermfg=darkcyan
                                                                                                                   
hi Title         term=NONE cterm=NONE    gui=NONE     start=<Esc>[m<Esc>[1;37m      stop=t_me     guifg=white       guibg=black        ctermfg=white          ctermbg=black
hi WarningMsg    term=NONE cterm=reverse gui=reverse  start=<Esc>[m<Esc>[1;33;7m    stop=t_me     guifg=yellow      guibg=black        ctermfg=yellow         ctermbg=black
                                                                                                                   
" Bram's Common Groups -- DrChip's overrides
hi String        term=NONE cterm=bold    gui=bold     start=<Esc>[m<Esc>[1;33m      stop=t_me     guifg=darkgreen                       ctermfg=green 

" Hightlighting of regions within vim                                                                              
hi Folded        term=NONE cterm=NONE gui=NONE        start=<Esc>[m<Esc>[1;33;7m    stop=t_me     guifg=magenta                        ctermfg=magenta        ctermbg=black
hi StatusLine    term=NONE cterm=NONE gui=bold        start=<Esc>[m<Esc>[1;33;7m    stop=t_me     guifg=white       guibg=blue         ctermfg=white          ctermbg=blue
hi StatusLineNC  term=NONE cterm=NONE gui=NONE        start=<Esc>[m<Esc>[1;33;7m    stop=t_me     guifg=darkgray    guibg=darkblue     ctermfg=gray           ctermbg=darkblue
hi LineNr        term=NONE cterm=NONE gui=NONE        start=<Esc>[m<Esc>[1;33;7m    stop=t_me     guifg=magenta     guibg=gray95       ctermfg=magenta        ctermbg=gray
hi FoldColumn    term=NONE cterm=NONE gui=NONE        start=<Esc>[m<Esc>[1;33;7m    stop=t_me     guifg=blue        guibg=gray90       ctermfg=blue           ctermbg=gray

hi Visual        term=reverse cterm=reverse gui=reverse  start=<Esc>[m<Esc>[1;33;7m stop=t_me     guibg=LightGray   ctermbg=Gray

" spell checking options
hi SpellBad         term=reverse    ctermbg=1  gui=bold,undercurl guisp=Red      guifg=Red
hi SpellCap         term=reverse    ctermbg=4  gui=bold,undercurl guisp=Blue     guifg=Blue
hi SpellLocal       term=underline  ctermbg=6  gui=bold,undercurl guisp=DarkCyan guifg=DarkCyan
hi SpellRare        term=reverse    ctermbg=5  gui=bold,undercurl guisp=Magenta  guifg=Magenta


" My Groups
hi Debug         term=NONE cterm=NONE gui=NONE        start=<Esc>[m<Esc>[1;31m      stop=t_me     guifg=magenta                        ctermfg=1
" Delimiters are brackets like (){}[] etc.                                                                   
hi Delimiter     term=NONE cterm=NONE gui=bold        start=<Esc>[m<Esc>[1;33;44m   stop=t_me     guifg=Green                                                 ctermfg=green
hi Tags          term=NONE cterm=NONE gui=NONE        start=<Esc>[m<Esc>[1;33;44m   stop=t_me     guifg=yellow      guibg=green        ctermfg=yellow         ctermbg=green
hi Unique        term=NONE cterm=NONE gui=NONE        start=<Esc>[m<Esc>[1;34;47m   stop=t_me     guifg=blue                                                  ctermfg=blue
hi Unique2       term=NONE cterm=NONE gui=NONE        start=<Esc>[m<Esc>[1;35;47m   stop=t_me     guifg=magenta                                               ctermfg=magenta
hi Unique3       term=NONE cterm=NONE gui=NONE        start=<Esc>[m<Esc>[1;30;47m   stop=t_me     guifg=black                                                 ctermfg=black
hi Subtitle      term=NONE cterm=NONE gui=NONE        start=<Esc>[m<Esc>[1;35m      stop=t_me     guifg=magenta                                               ctermfg=magenta

hi link Character    Constant
hi link Number       Constant
hi link Float        Constant
hi link Function     Statement
hi link Conditional     Statement
hi link Repeat       Statement
hi link Label        Statement
hi link Operator     Statement
hi link Keyword         Statement
hi link Include         PreProc
hi link Define       PreProc
hi link Macro        PreProc
hi link PreCondit    PreProc
hi link StorageClass Type
hi link Structure    Type
hi link Typedef         Type
hi link Tag          Tags

" Gui groups
hi Scrollbar    term=NONE         cterm=NONE         gui=NONE          guifg=gray80  guibg=gray70
hi Menu         term=NONE         cterm=NONE         gui=NONE          guifg=black   guibg=gray75
hi Cursor       term=reverse,bold cterm=reverse,bold gui=reverse,bold  guifg=blue    guibg=yellow 
hi CursorLine   term=underline    cterm=NONE         gui=NONE          guibg=Gray95  ctermbg=7
hi CursorColumn cterm=reverse     cterm=NONE         gui=NONE          guibg=Gray95  ctermbg=7

" Matching Parentesis in vim7
hi MatchParen  term=NONE cterm=bold gui=bold  start=<Esc>[m<Esc>[1;37;41m  stop=t_me   guifg=blue      guibg=white   ctermfg=blue

" color-based highlighting groups
hi Red         term=NONE cterm=NONE gui=NONE  start=<Esc>[m<Esc>[1;31m     stop=t_me   guifg=red       ctermfg=red
hi Green       term=NONE cterm=NONE gui=NONE  start=<Esc>[m<Esc>[1;32m     stop=t_me   guifg=green     ctermfg=green
hi Yellow      term=NONE cterm=NONE gui=NONE  start=<Esc>[m<Esc>[1;33m     stop=t_me   guifg=yellow    ctermfg=yellow
hi Blue        term=NONE cterm=NONE gui=NONE  start=<Esc>[m<Esc>[1;34m     stop=t_me   guifg=blue      ctermfg=blue
hi Magenta     term=NONE cterm=NONE gui=NONE  start=<Esc>[m<Esc>[1;35m     stop=t_me   guifg=magenta   ctermfg=magenta
hi Cyan        term=NONE cterm=NONE gui=NONE  start=<Esc>[m<Esc>[1;36m     stop=t_me   guifg=cyan      ctermfg=cyan
hi White       term=NONE cterm=NONE gui=NONE  start=<Esc>[m<Esc>[1;37m     stop=t_me   guifg=white     ctermfg=white

" sh.vim highlighting overrides
if exists("did_sh_syntax_inits")
  hi shOperator         term=NONE gui=NONE cterm=NONE start=<Esc>[m<Esc>[1;37m ctermfg=7 guifg=white
  hi shShellVariables   term=NONE gui=NONE cterm=NONE start=<Esc>[m<Esc>[1;37m ctermfg=7 guifg=white
  hi shFunction         term=NONE gui=NONE cterm=NONE start=<Esc>[m<Esc>[1;37m ctermfg=7 guifg=white
     hi Quote1          term=NONE gui=NONE cterm=NONE start=<Esc>[m<Esc>[1;31;40m   stop=t_me   ctermfg=red    ctermbg=black  guifg=red      guibg=black
  endif

   " asm.vim highlighting overrides
if exists("did_asm_syntax_inits")
  hi asmSpecialComment  term=NONE gui=NONE cterm=NONE ctermfg=lightred  start=<Esc>[m<Esc>[1;37;40m   stop=t_me
  hi asmIdentifier      term=NONE gui=NONE cterm=NONE ctermfg=green     start=<Esc>[m<Esc>[1;32m      stop=t_me
  hi asmType         term=NONE gui=NONE cterm=NONE ctermfg=brown     start=<Esc>[m<Esc>[1;32;40m   stop=t_me
  endif

" mail.vim highlighting overrides
" if exists("did_mail_syntax_inits")
  hi link mailQuoted2 Cyan
  hi link mailQuoted3 Yellow
" endif


