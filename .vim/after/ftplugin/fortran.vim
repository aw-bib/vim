" Vim Macrofile for FORTRAN
"

" Tell vim which lines are comments: & is the default continuation
" char. Treat it as comment and you don't need to add it manually ;)
setlocal comments=:C,:c,n:&,:!
setlocal formatoptions=tcqr

" Direct calls to the compiler. Suitable for small programs. (Well who
" wants to write big programs in Fortran?)
if has("os2")
   "
   " g77: switch on all warnings and enable debug code for pmgdb
   setlocal makeprg=g77\ -Wall\ -g\ %
   map <buffer>   ,rp   :!./%<<cr>
   "
   " g77 writes C-type error messages if called with -Wall
   map - :cp<cr>
   map + :cn<cr>
elseif has("unix")
   setlocal makeprg=f77\ %\ -o\ %<
   map <buffer>   ,rp   :!./%<<cr>
   if $HOSTTYPE=="i386"
      setlocal makeprg=g77\ -Wall\ -g\ %\ -o\ %<
   endif
endif

" Check if we have a makefile in this directory. If so we assume that
" this one contains the necessary steps for the compiler and we'll use
" it instead of direct calls to the compiler.
if filereadable('makefile') || filereadable('Makefile')
  setlocal makeprg=make
  if $HOSTTYPE=="alpha"
     setlocal makeprg=gmake
  endif
  "unmap <buffer>  ,rp
  map   <buffer>  ,rp  :make run<cr>
  map   <buffer>  ,rd  :make debug<cr>
endif

syntax off
let fortran_more_precise=1

if has("folding")
   let fortran_fold=1
   let fortran_fold_conditionals=1
   " Create syntax folds
   setlocal foldmethod=syntax
   " Switch to manual folding for sake of speed
   setlocal foldmethod=manual
   setlocal foldlevel=0
endif

syntax on
colors aw

map <buffer>   ,rf   :wall<cr>:make<cr>
map <buffer>   ,m    :wall<cr>:make<cr>
map <buffer>   ,b    :wall<cr>:make clean<cr>:make<cr>
map <buffer>   ,fu   :setlocal foldmethod=syntax<cr>:setlocal foldmethod=manual<cr>
" map the continuation char (&) to insert it at pos 6 by just pressing &
imap <buffer>  &    <esc>:norm 6\|r&A<cr>

" Fotrtan uses ** instead of ^
imap <buffer>  ^    **

" forstubs.vim: stub/abbrevations for fortran
" Ajit J. Thakkar, 2000 May 25 
"  Based on Charles E. Campbell, Jr.'s DrChipCStubs
"  Modified by A. Wagner
"
setlocal autoindent smartindent expandtab
setlocal cinwords=if,else,do,case,where,elsewhere
iab <buffer>  _com        common
iab <buffer>  _par        parameter
iab <buffer>  _int        integer
iab <buffer>  _in         intent(
iab <buffer>  _dp         double precision
iab <buffer>  _dc         double complex
iab <buffer>  _if         if () then<CR><c-d>else<CR><c-d>endif<Esc>lDkkF(li
iab <buffer>  _do         do<cr>continue<esc>kAi
iab <buffer> _sub         subroutine ()<cr>implicit none<cr><cr>return<cr>end<esc>lD4kWi
iab <buffer> _fun         function ()<cr>implicit none<cr><cr>return<cr>end<esc>lD4kWi
iab <buffer> _op          open(unit=, file=, status=, action=, position=)<Esc>lDF=;;;;li

" let isf="@,48-57,/,.,-,_,+,#,^,,$,%,~,="
set efm=%E%.%#rror:\ %f\\,\ line\ %l:\ %m,\%-C%.%#,\%-Z\%p^

