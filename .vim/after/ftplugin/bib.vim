" Auctex-like bindings for the bibliography entries
source $VIMRUNTIME/syntax/bib.vim
set notimeout
set expandtab
" set noai

inoremap <buffer> 'a @article{,<CR>
     \   author    = "",<CR>
        \title     = "",<CR>
        \journal   = "",<CR>
        \year      = "",<CR>
        \volume    = "",<CR>
        \number    = "",<CR>
        \pages     = "",<CR>
        \note      = "\mbox{hep-ph/}",<CR><Esc>3xi}<Esc>?@<CR>f{a

inoremap <buffer> 'b @book{,<CR>
     \   author    = "",<CR>
        \title     = "",<CR>
        \stitle    = "",<CR>
        \series    = "",<CR>
        \volume    = "",<CR>
        \publisher = "",<CR>
        \address   = "",<CR>
        \year      = "",<CR><Esc>3xi}<Esc>?@<CR>f{a

inoremap <buffer> 'i @inBook{,<CR>
     \   author    = "",<CR>
        \title     = "",<CR>
        \stitle    = "",<CR>
        \pages     = "",<CR>
        \crossref  = "",<CR><Esc>3xi}<Esc>?@<CR>f{a

" inoremap <silent><buffer>  <C-N> <Esc>$/$\\|{<CR>a
inoremap <silent><buffer>  <C-N> <Esc>$/{<CR>:nohls<CR>a
inoremap <buffer>  <C-P> <Esc>0?^\\|{<CR>a
" noremap <buffer>  j j0f{l
" noremap <buffer>  k k0f{l

" F1 removes empty fields in a citation.
map <buffer> <F1> -/^}<CR>O{},<Esc>V?@<CR>:g/{},$/d<CR>
imap <buffer> <F1> <Esc>-/^}<CR>O{},<Esc>V?@<CR>:g/{},$/d<CR>

