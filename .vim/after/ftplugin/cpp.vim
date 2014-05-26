" VIM Macrofile for use with FORM
"

" define the "compiler" to use
setlocal makeprg=g++\ -Wall\ -g\ %\ -o\ %<

map <buffer> ,m  :wall<cr>:make<cr>
map <buffer>   ,rp   :!./%<<cr>

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

" define folding
:set foldmethod=indent
:set foldlevel=1
