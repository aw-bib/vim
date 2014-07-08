"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Python
"
" Last change: <Tue, 2014/07/08 13:33:57 arwagner bib-pubdb2>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

setlocal makeprg=python\ %
map <buffer> ,m  :make<cr>

set textwidth=79

" Comply to PEP-0008: 4 spaces for indentation, use only spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

compiler pylint
