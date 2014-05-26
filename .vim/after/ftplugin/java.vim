
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Physics Analysis Workstation
"
" (c) 2000 by Alexander Wagner, Team OS/2 Franken
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

setlocal makeprg=javac\ %

" Check if we have a makefile in this directory. If so we assume that
" this one contains the necessary steps for the compiler and we'll use
" it instead of direct calls to the compiler.
if filereadable('makefile') || filereadable('Makefile')
  setlocal makeprg=make
  if $HOSTTYPE=="alpha"
     setlocal makeprg=gmake
  endif
  " unmap <buffer>  ,rp
  map   <buffer>  ,rp  :make run<cr>
  map   <buffer>  ,rd  :make debug<cr>
endif

map <buffer> ,m  :wall<cr>:make<cr>
