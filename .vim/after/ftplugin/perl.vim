"  Vim Macrofile for PERL

set notimeout
set smartindent
set smarttab
set autoindent
set cindent
set comments=:#
set formatoptions=croql
set keywordprg=perldoc\ -f

map <C-Esc> :set nosmartindent<CR>:set noautoindent<CR>

nnoremap <F1> :if strpart(getline(1),0,16) != '#!/usr/bin/perl'<CR>0put ='#!/usr/bin/perl'<CR>put =''<CR>endif<CR>:if getline(3) != ""<CR>1put =''<CR>endif<CR><Space>3Gi

inoremap <buffer> ,;    ;<CR>
inoremap <buffer> ,c    chomp<Space>
inoremap <buffer> ,d    die
inoremap <buffer> ,e    <Esc>:call Else()<CR>O
inoremap <buffer> ,f    foreach  () {<CR>}<Esc>k0fhla
inoremap <buffer> ,m    my<Space>
inoremap <buffer> ,o    open ;<Left>
inoremap <buffer> ,p    print<Space>
inoremap <buffer> ,si    <STDIN>
inoremap <buffer> ,so    <STDOUT>
inoremap <buffer> ,r    return<Space>
inoremap <buffer> ,C    close ;<Left>
inoremap <buffer> ,E    <Esc>:call ElseIf()<CR>i
inoremap <buffer> ,F    for (; ; ) {<CR>}<Esc>k0f(a
inoremap <buffer> ,I    if () {<CR>}<Esc>k0f(a
inoremap <buffer> ,O    open ;<Left>
inoremap <buffer> ,S    sub  {<CR>}<Esc>k$hi
inoremap <buffer> ,su   sub  {<CR>}<Esc>k$hi
inoremap <buffer> ,sp   split (//,);<Esc>3hi
inoremap <buffer> ,u    until () {<CR>}<Esc>k0f(a
inoremap <buffer> ,U    until () {<CR>}<Esc>k0f(a
inoremap <buffer> ,w    while () {<CR>}<Esc>k0f(a
inoremap <buffer> ,W    while () {<CR>}<Esc>k0f(a
noremap  <buffer> ,m    <Esc>:call PerlCWBuffer()<CR><Esc>
noremap <f3> <Esc>:call PerlBuffer()<CR><Esc>

function! ElseIf ()
    if getline(line(".")) =~ "}"
	exe "normal a \<Esc>F}a \<Esc>C elseif `() `[\<CR>}\<Esc>k$F)"
    else
	exe "normal /}\<CR>a elsif `() `[\<CR>}\<Esc>k$F)"
    endif
endfunction

function! Else ()
    if getline(line(".")) =~ "}"
	exe "normal a \<Esc>F}a \<Esc>C else `[\<CR>}\<Esc>"
    else
	exe "normal /}\<CR>a else `[\<CR>}\<Esc>"
    endif
endfunction

" perl -cw buffer, open output in a new window
function! PerlCWBuffer()
	let l:tmpfile1 = tempname()
	let l:tmpfile2 = tempname()

	execute "normal:w!" . l:tmpfile1 . "\<CR>"
	execute "normal:! perl -cw ".l:tmpfile1." \> ".l:tmpfile2." 2\>\&1 \<CR>"
	execute "normal:new\<CR>"
	execute "normal:edit " . l:tmpfile2 . "\<CR>"
endfunction

" run buffer as a perl script, open output in a new window
function! PerlBuffer()
	let l:tmpfile1 = tempname()
	let l:tmpfile2 = tempname()
    
	execute "normal:w!" . l:tmpfile1 . "\<CR>"
	execute "normal:! perl ".l:tmpfile1." \> ".l:tmpfile2." 2\>\&1 \<CR>"
	execute "normal:new\<CR>"
	execute "normal:edit " . l:tmpfile2 . "\<CR>"
endfunction


