" Vim Macrofile for SCID (mainl repertoir files)
"

" Tell vim which lines are comments: & is the default continuation
" char. Treat it as comment and you don't need to add it manually ;)
setlocal comments=:@
setlocal formatoptions=tcqr

if has("folding")
   setlocal foldmethod=indent
   setlocal foldlevel=1
endif

syntax on
" sync from start as long lines for [] are standard but the sor files
" themselves should not be to long
syntax sync fromstart
colors aw
