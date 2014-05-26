" Vim Macrofile for PHP4
"

" Tell vim which lines are comments: & is the default continuation
" char. Treat it as comment and you don't need to add it manually ;)
setlocal expandtab
setlocal comments=://
setlocal formatoptions=tcqr

if has("folding")
   " Create syntax folds
   setlocal foldmethod=indent
   setlocal foldlevel=0
endif

syntax on
colors aw

setlocal autoindent smartindent
setlocal cinwords=if,else,do,case,where,elsewhere


inoremap <buffer> ,i    if () {<CR>}<Esc>k0f(a
inoremap <buffer> ,u    until () {<CR>}<Esc>k0f(a
inoremap <buffer> ,w    while () {<CR>}<Esc>k0f(a
inoremap <buffer> ,f    foreach  () {<CR>}<Esc>k0fhla
inoremap <buffer> ,myq   mysql_query (<CR>"<CR>");<Esc>k0f(A


