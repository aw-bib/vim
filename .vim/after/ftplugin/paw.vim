"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Physics Analysis Workstation
"
" (c) 2000 by Alexander Wagner, Team OS/2 Franken
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
setlocal makeprg=paw\ -b\ %\ >%<.paw
map <buffer> ,m  :wall<cr>:make<cr>
map ,l :new %<.paw<CR>:setlocal ar<cr>:setlocal nomodifiable<cr>:setlocal ro<cr>
