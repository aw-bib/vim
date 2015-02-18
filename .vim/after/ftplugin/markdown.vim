"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Markdown
"
" Last change: <Wed, 2015/02/18 09:47:24 arwagner l00slwagner>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <buffer> ,m  :make<cr>

map <buffer> ,mw  :call CallPandoc('mediawiki', 'mediawiki')<cr>
map <buffer> ,mp  :call CallPandoc('pdf', 'pdf')<cr>
map <buffer> ,mo  :call CallPandoc('odt', 'odt')<cr>
map <buffer> ,md  :call CallPandoc('docx', 'docx')<cr>
" map <buffer> ,tw  :call MakeTwiki<cr>

set textwidth=80

" Like python, markdown likes 4 space indents
setlocal smarttab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal autoindent

fun! CallPandoc(format, extension)
    " pandoc -f markdown -t <format> basename -o basename.<extension>
    let inputname = bufname("%")
    let basename  = fnamemodify(inputname, ":r")
    let outname   = basename . "." . a:extension
    let pandoc    = "pandoc -f markdown -t " . a:format . " " . inputname . " -o " . outname
    execute "!" . pandoc
endfun


