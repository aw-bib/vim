" VIM Macrofile for use with Mathematica
"
" Unse more lines to check syntax; expressions are long...
syn sync minlines=200
syn sync maxlines=500

" define the "compiler" to use
set makeprg=time\ math\ <\ %\ >\ %<.res

" Check if we have a makefile in this directory. If so we assume that
" this one contains the necessary steps for the compiler and we'll use
" it instead of direct calls to the compiler.
if filereadable('makefile') || filereadable('Makefile')
  setlocal makeprg=make
  if $HOSTTYPE=="alpha"
     setlocal makeprg=gmake
  endif
  map   <buffer>  ,rp  :make run<cr>
  map   <buffer>  ,rd  :make debug<cr>
endif

map <buffer> ,m  :make<cr>

map <buffer> ,l   :new %<.res <CR>:setlocal modifiable<cr>:%s/^\n//g<cr>:w!<cr>:setlocal ar<cr>:setlocal nomodifiable<cr>:setlocal ro<cr><cr>
map <buffer> ,o   :new %<.out <CR>:setlocal ar<cr>:setlocal nomodifiable<cr>:setlocal ro<cr><cr>

inoremap <buffer> (*    <C-R>=Double("(*","*)")<cr><Left>

set expandtab
" define folding
:set foldmethod=indent
:set foldlevel=1

