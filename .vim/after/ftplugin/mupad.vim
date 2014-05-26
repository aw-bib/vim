" Vim Macrofile for MuPAD
"
set syntax=mupad

" Unse more lines to check syntax; expressions are long...
syn sync maxlines=200
syn sync minlines=50

map ,l :new %<.log<CR>:setlocal ar<cr>:setlocal nomodifiable<cr>:setlocal ro<cr>
map ,rm :wall<cr>:!mupad -b %<.log % <CR>
map ,m  ,rm
set expandtab

" Insert //EVAL and separator line
:iabbr ev //EVAL<esc>o//<esc>70A-<esc>o
