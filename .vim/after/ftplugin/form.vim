" VIM Macrofile for use with FORM
"

" define the "compiler" to use
"map ,rf :wall<cr>:!form -l %<CR>
map ,rf :wall<cr>:call RunForm()<cr>
map ,m  ,rf
" Load the logfile
map ,l :new %<.log<CR>:setlocal ar<cr>:setlocal nomodifiable<cr>:setlocal ro<cr>
" Search the .frm-file in the current buffer list (note that there
" should only be one such file) and run form against it
fun! RunForm()

   let currbuff = bufnr("")
   let i = 1

   while i <= bufnr("$")
      if (bufexists(i))
         execute "b " . i
         let name = bufname(winbufnr(0))
         if matchstr(name, ".frm") == ".frm"
            let basename = name
            echo name
         endif
      endif
      let i = i+1
   endwhile

   "basename = "amplitude.frm"
   execute "!form -l " . basename
   execute "b " . currbuff
endfun

" define folding
:set foldmethod=indent
:set foldlevel=1

