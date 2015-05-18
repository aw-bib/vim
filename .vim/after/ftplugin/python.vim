"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Python
"
" Last change: <Tue, 2015/02/24 12:52:54 arwagner l00slwagner>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <buffer> ,m  :make<cr>

set textwidth=80


" Comply to PEP-0008: 4 spaces for indentation, use only spaces
setlocal smarttab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal autoindent

" highlight lines longer than 80 chars
:match Folded '\%>80v.\+'
