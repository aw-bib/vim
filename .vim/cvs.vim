" Utility functions

function! CVSChangeToCurrentFileDir()
  let oldCwd=getcwd()
  let newCwd=expand("%:h")
  if strlen(newCwd) > 0
    execute 'cd' escape(newCwd, ' ')
  endif
  return oldCwd
endfunction

function! CVSCreateCommandBuffer(cmd, tempname)
  execute 'edit' tempname() . '_' . a:tempname . '_'
  set noro
  execute a:cmd
  set nomod
  set ro
  1
endfunction

" CVS functions and mappings.

function! CVSCommit()
  let messageFileName = tempname().'_message_'
  let newCwd=expand("%:h")
  let fileName=expand("%:t")

  execute 'au BufWritePost' messageFileName 'call CVSFinishCommit("' . messageFileName . '", "' . newCwd . '", "' . fileName . '") | au! BufWritePost ' messageFileName

  execute 'edit' messageFileName
endfunction

function! CVSFinishCommit(messageFile, targetDir, targetFile)
  if filereadable(a:messageFile)
    let oldCwd=getcwd()
    if strlen(a:targetDir) > 0
      execute 'cd' escape(a:targetDir, ' ')
    endif
    call CVSCreateCommandBuffer('0r!cvs commit -F "' . a:messageFile . '" "'. a:targetFile . '"', 'cvscommit')
    execute 'cd' escape(oldCwd, ' ')
    execute 'bd' a:messageFile
    execute '!rm' a:messageFile
  else
    echo "Can't read message file; no commit is possible."
  endif
endfunction

function! CVSUpdate()
  let oldCwd=CVSChangeToCurrentFileDir()
  call CVSCreateCommandBuffer('0r!cvs update "' . expand("%") . '"', 'cvsupdate')
  execute 'cd' escape(oldCwd, ' ')
endfunction

function! CVSDiff(...)
  if a:0 == 1
    let diffOptions = '-r' . a:1
    let caption = 'cvsdiff\ ' . a:1 . '\ ->\ current'
  elseif a:0 == 2
    let diffOptions = '-r' . a:1 . ' -r' . a:2
    let caption = 'cvsdiff\ ' . a:1 . '\ ->\ ' . a:2
  else
    let diffOptions = ''
    let caption = 'cvsdiff'
  endif

  let oldCwd=CVSChangeToCurrentFileDir()
  call CVSCreateCommandBuffer('0r!cvs diff -c ' . diffOptions . ' "' . expand("%") . '"', caption)
  call SetSyn("diff")
  execute 'cd' escape(oldCwd, ' ')
endfunction

function! CVSLog()
  let oldCwd=CVSChangeToCurrentFileDir()
  call CVSCreateCommandBuffer('0r!cvs log "' . expand("%") . '"', 'cvslog')
  execute 'cd' escape(oldCwd, ' ')
endfunction

function! CVSAdd()
  let oldCwd=CVSChangeToCurrentFileDir()
  call CVSCreateCommandBuffer('0r!cvs add "' . expand("%") . '"', 'cvsadd')
  execute 'cd' escape(oldCwd, ' ')
endfunction

function! CVSAnnotate()
  let currentLine=line(".")
  let oldCwd=CVSChangeToCurrentFileDir()
  if has("os2")
     call CVSCreateCommandBuffer('0r!cvs -q annotate "' . expand("%") . '" 2>nul', 'cvsannotate')
  else
     call CVSCreateCommandBuffer('0r!cvs -q annotate "' . expand("%") . '" 2>/dev/null', 'cvsannotate')
  endif
  exec currentLine
  execute 'cd' escape(oldCwd, ' ')
endfunction

function! CVSReview()
  let versiontag=input('Revision:  ')
  let origFileType=&filetype
  let oldCwd=CVSChangeToCurrentFileDir()
  call CVSCreateCommandBuffer('0r!cvs update -p -r ' . versiontag . ' "' . expand("%") . '" 2>/dev/null', 'cvsreview\ --\ ' . versiontag)
  execute 'cd' escape(oldCwd, ' ')
  let &filetype=origFileType
endfunction

function! CVSStatus()
  let oldCwd=CVSChangeToCurrentFileDir()
  if has("os2")
     call CVSCreateCommandBuffer('0r!cvs status "' . expand("%") . '" 2>nul', 'cvsstatus')
  else 
     call CVSCreateCommandBuffer('0r!cvs status "' . expand("%") . '" 2>/dev/null', 'cvsstatus')
  endif
  execute 'cd' escape(oldCwd, ' ')
endfunction

com! CVSCommit call CVSCommit()
com! CVSUpdate call CVSUpdate()
com! -nargs=* CVSDiff call CVSDiff(<f-args>)
com! CVSLog call CVSLog()
com! CVSAdd call CVSAdd()
com! CVSAnnotate call CVSAnnotate()
com! CVSReview call CVSReview()
com! CVSStatus call CVSStatus()

nmap _cc :CVSCommit<CR><CR>
nmap _cu :CVSUpdate<CR><CR>
nmap _cd :CVSDiff<CR><CR>
nmap _cl :CVSLog<CR><CR>
nmap _ca :CVSAdd<CR><CR>
nmap _cr :CVSReview<CR>
nmap _cn :CVSAnnotate<CR><CR>
nmap _cs :CVSStatus<CR><CR>
