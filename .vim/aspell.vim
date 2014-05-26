" -*- vim -*-
" FILE: "/home/joze/.vim/plugin/aspell.vim"
" LAST MODIFICATION: "Thu, 03 May 2001 16:49:44 +0200 (joze)"
" (C) 2001 by Johannes Zellner, <johannes@zellner.org>
" $Id: aspell.vim,v 1.3 2001/05/04 05:40:54 joze Exp $

" USAGE:
"
"   :Spell      -- spellcheck the current buffer with the default language
"                  (as set by the environment variable DICTIONARY)
"   <f9>        -- german spell checking (you need the german dict)
"   <s-f9>        -- english spell checking
"   <Leader>m   -- merge word under cursor to the personal dictionary

if exists("*ASpellBuffer") | finish | endif

command! -nargs=? Spell call ASpellBuffer(<q-args>)

noremap \ASpellUpdateGerman :call ASpellBuffer('german')<cr>
if !hasmapto('\ASpellUpdateGerman', 'n')
    nmap <unique> <f9> \ASpellUpdateGerman
endif

noremap \ASpellUpdateEnglish :call ASpellBuffer('english')<cr>
if !hasmapto('\ASpellUpdateEnglish', 'n')
    nmap <unique> <S-f9> \ASpellUpdateEnglish
endif

noremap \ASpellMerge :call ASpellMerge(expand('<cword>'))<cr>
if !hasmapto('\ASpellMerge', 'n')
    nmap <unique> <Leader>m \ASpellMerge
endif

noremap \ASpellLookup :call ASpellLookup(expand('<cword>'))<cr>
if !hasmapto('\ASpellLookup', 'n')
    nmap <unique> <Leader>? \ASpellLookup
endif

fun! ASpellLookup(word)
    let report=&report
    let &report=999999
    sp /aspell.tmp
    setlocal modifiable
    setlocal noreadonly
    setlocal buftype=nofile
    au! BufLeave /aspell.tmp bd!
    exe 'r !echo '.a:word.' | aspell pipe'
    if !search('^#')
	" no suggestions
	echo 'sorry, no suggestions for "'.a:word.'"'
	bd!
	let &report=report
	return
    elseif !search('^*$')
	" word is spelled correctly
	bd!
	let &report=report
	return
    endif
    " delete the aspell header line
    g/^@(#)/d
    " break at <cr>
    %s/:/:\r/ge
    " delete empty lines
    g/^$/d
    %s/,/ /ge
    g/^[^:]\+$/normal gqq
    setlocal nomodified
    setlocal nomodifiable
    setlocal readonly
    setlocal nobuflisted
    if winheight('.') > line('$')
	exe 'resize' . line('$')
    endif
    1
    let &report=report
endfun

" [-- merge word to peronal dictionary ~/.aspell.<lang>.pws --]
fun! ASpellMerge(word)
    call system('echo '.a:word.' | aspell merge personal')
    " call ASpellBuffer()
endfun

" [-- run the spell checker on the current buffer --]
fun! ASpellBuffer(...)
    if a:1 == ""
        let lang = ''
    else
	let lang = '--lang='.a:1
    endif
    syn clear ASpellError
    w!
    let tmp = tempname()
    let aspellmode = ''
    let ext = expand('%:e')
    if 'tex' == ext
	let aspellmode = '--mode=tex'
    elseif 'sgml' == ext || 'sgm' == ext || 'html' == ext || 'htm' == ext
	let aspellmode = '--mode=sgml'
    endif

    " call system('aspell list '.lang.' '.aspellmode.' < '.expand("%").' | sed "s/.*/syntax keyword ASpellError &/g" > '.tmp)
    " call aspell to generate the list of misspelled words
    call system('aspell list '.lang.' '.aspellmode.' < '.expand("%").' > '.tmp)

    " turn the list of words into a vim syntax file
    let report=&report
    let &report=999999
    exe 'sp '.tmp
    g/^$/d
    %s/.*/syntax keyword ASpellError &/g
    w!
    bd
    let &report=report

    " source the vim syntax file
    exe 'source '.tmp
    call delete(tmp)
endfun

hi ASpellError ctermfg=red ctermbg=yellow guifg=red guibg=yellow
au Syntax tex syn cluster texMatchGroup add=ASpellError
au Syntax xml syn cluster xmlRegionHook add=ASpellError
au Syntax html syn cluster Spell add=ASpellError
