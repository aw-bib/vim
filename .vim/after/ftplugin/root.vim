"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" root
"
" (c) 2000 by Alexander Wagner, Team OS/2 Franken
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set syntax=cpp
setlocal makeprg=root\ -b\ -q\ %\ >%<.root.log
map <buffer> ,m  :wall<cr>:make<cr>
map ,l :new %<.rootlog<CR>:setlocal ar<cr>:setlocal nomodifiable<cr>:setlocal ro<cr>
