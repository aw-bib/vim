"
" GPG-Handling for vim
" 
map ,de    :call Decrypt("gpg --decrypt ")<cr>
map ,en    :call Encrypt("gpg -ea --batch --allways-trust -r a.wagner@stellarcom.org ")<cr>

" Function to check that executing "cmd" works.
" The result is cached in s:have_"cmd" for speed.
fun s:check(cmd)
  let name = substitute(a:cmd, '\(\S*\).*', '\1', '')
  if !exists("s:have_" . name)
    let e = executable(name)
    if e < 0
      let r = system(name . " --version")
      let e = (r !~ "not found" && r != "")
    endif
    exe "let s:have_" . name . "=" . e
  endif
  exe "return s:have_" . name
endfun

" After reading encrypted file: decrypt text in buffer with "cmd"
fun! Decrypt(cmd)
  " don't do anything if the cmd is not supported
  if !s:check(a:cmd)
    return
  endif
  let g:have_it=s:have_gpg
  " set 'cmdheight' to two, to avoid the hit-return prompt
  let ch_save = &ch
  set ch=3

" filter the buffer through gpg:
" don't keep the buffer if no window is looking at it; don't associate a
" file with it, and don't allow a swapfile or a backup
"  setlocal bh=delete bt=nofile noswapfile patchmode='' nobackup

  setlocal bh=delete noswapfile nobackup
  " remove the entire contents of the buffer:
  %d
  " and replace it with the password the user enters:
  0put=inputsecret('Password: ')
  " and 'filter' the password by decrypting the file:
  exe 'silent! %! '.a:cmd . ' --batch --passphrase-fd 0 '.expand("%")

  " NOTE: This has several implications:
  " 	1) the password is not saved in any registers
  " 	2) there are no temporary files on disk to be hacked
  " 	3) however, a sufficiently quick snooper could grab the pwd from the
  " 	in-memory buffers *during* the filter operation; this is pretty low
  " 	risk, but YMMV.

  let &ch = ch_save
  " run the autocommand for the file type:
  execute ":silent! doau BufReadPost " . expand("%:r")
endfun

" After writing file: encrypt written file with "cmd"
"
fun Encrypt(cmd)
  " don't do anything if the cmd is not supported
  if s:check(a:cmd)
     let recipient = input("Recipient: ")
     exe 'silent! %! '.a:cmd . ' -r '. recipient
  endif
endfun
