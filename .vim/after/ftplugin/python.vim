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

compiler pylint

" Do not pylint on every write but wait for a :make. Otherwise this
" might get a bit slow...
"
"let g:pylint_onwrite = 0
"
" Displaying code rate calculated by Pylint can be avoided by setting
"
"let g:pylint_show_rate = 0
"
" Openning of QuickFix window can be disabled with
"
"let g:pylint_cwindow = 0
"

" highlight lines longer than 80 chars
:match Folded '\%>80v.\+'
