"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" VIM Macrofile for displaying Chat-Logs
"
" Last update: Tue, 2003/06/17, 20:55:24
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" switch off backups for e-mail
setlocal nobackup
setlocal syntax=mail
" Don't use modelines in e-mail messages, avoid trojan horses
setlocal nomodeline
" Set 'formatoptions' to break text lines,
" and insert the comment leader ">" when hitting <CR> or using "o".
setlocal fo+=tcroql
setlocal noswapfile
setlocal nomodifiable
setlocal readonly
setlocal nolist
set guioptions-=m
hi Normal guifg=white
hi Normal guibg=black

