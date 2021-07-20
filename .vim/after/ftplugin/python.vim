"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Python
"
" Last change: <Tue, 2021/07/20 12:15:30 arwagner l00lnxwagner.desy.de>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <buffer> ,m  :make<cr>

set spelllang=en_gb
set spell

" flake8 recommends 79
set textwidth=79

" Comply to PEP-0008: 4 spaces for indentation, use only spaces
setlocal smarttab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal autoindent

" Add a specific user dictionary. We may have some words in
" programming that should not enter the general language.
setlocal spellfile=~/.vim/spell/python.utf-8.add

" highlight lines longer than 80 chars
""" :match Folded '\%>80v.\+'
