"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Python
"
" Last change: <Mon, 2016/05/02 14:07:31 arwagner l00slwagner.desy.de>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <buffer> ,m  :make<cr>

" flake8 recommends 79
set textwidth=79

" Comply to PEP-0008: 4 spaces for indentation, use only spaces
setlocal smarttab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal autoindent

" highlight lines longer than 80 chars
""" :match Folded '\%>80v.\+'
