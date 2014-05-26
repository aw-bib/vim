" Vim Macrofile for MAPLE
"

set syntax=maple
if (has("os2"))
   chdir E:\Maple\bin.os2
endif
map ,rm :w<cr>:!cmaple %<CR>
map ,m  ,rm
" Add quotes for seemless insertation into worksheets
map ,aq :%s/^/> /g<CR>:w
" Remove the quotes maple insert when saving to maple-text
map ,rq :%s/^>//g

set keywordprg=maphelp
