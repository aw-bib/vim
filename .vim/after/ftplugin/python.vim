"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Python
"
" Last change: <Mon, 2014/07/07 13:17:37 arwagner bib-pubdb2>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

setlocal makeprg=python\ %
map <buffer> ,m  :make<cr>

" Comply to PEP-0008: 4 spaces for indentation, use only spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

compiler pylint
