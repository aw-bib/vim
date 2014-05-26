:set encoding=utf-8

:%s/�/�/g
:%s/�/�/g
:%s/�/�/g
:%s/�/�/g

:%s/�/�/g
:%s/�/�/g
:%s/�/�/g


" Wikipedia prefers line breaks only at the end of paragraphs (like in a text
" processor), which results in long, wrapping lines. 
setlocal wrap linebreak
setlocal textwidth=0

" No auto-wrap at all.
setlocal formatoptions-=tc formatoptions+=l
if v:version >= 602 | setlocal formatoptions-=a | endif

" Make navigation more amenable to the long wrapping lines. 
noremap <buffer> k gk
noremap <buffer> j gj
noremap <buffer> <Up> gk
noremap <buffer> <Down> gj
noremap <buffer> 0 g0
noremap <buffer> ^ g^
noremap <buffer> $ g$
noremap <buffer> D dg$ 
noremap <buffer> C cg$ 
noremap <buffer> A g$a

inoremap <buffer> <Up> <C-O>gk
inoremap <buffer> <Down> <C-O>gj

