"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Markdown
"
" Last change: <Fri, 2020/04/24 11:21:00 arwagner l00lnxwagner.desy.de>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save the bit order marker for utf-8 encoding
set bomb

" usually, markdown are local docs in their own window. Use a
" different colour scheme to distinguish the windows. This is not
" possible via modelines :(
" map <buffer> ,m  :make<cr>
" 
" map <buffer> ,mw  :call CallPandoc('mediawiki', 'mediawiki')<cr>
" map <buffer> ,mp  :call CallPandoc('pdf', 'pdf')<cr>
" map <buffer> ,mo  :call CallPandoc('odt', 'odt')<cr>
" map <buffer> ,md  :call CallPandoc('docx', 'docx')<cr>
" " map <buffer> ,tw  :call MakeTwiki<cr>

set textwidth=80

" set formatoptions-=t
set linebreak
set nolist  " ensure that linebreak and breakat are used for display
command! -range=% SoftWrap
            \ <line2>put _ |
            \ <line1>,<line2>g/.\+/ .;-/^$/ join |normal $x

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

" enable spell checker for English and German
set spelllang=en,de
set spell
