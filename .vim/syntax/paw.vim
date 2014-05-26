" Vim syntax file
" Language:	paw = Physics Analysis Workstation
" Maintainer:	Alexander Wagner <a.wagner@stellarcom.org>
" Last Change:  Wed Jun 26 20:08:47 CEST 2002 
"
" This file is based on the SQL-Syntaxfile

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

" The paw reserved words, defined as keywords.

syn keyword pawSpecial  opt set igset

syn keyword pawKeyword  mess

syn keyword pawKeyword  kuip mac[ro] ve[ctor] hist[ogram] fun[ction] nt[uple]
syn keyword pawKeyword  gra[phics] pic[ture] zebra for[tran] net[work]
syn keyword pawKeyword  zone op[tion] put
syn keyword pawKeyword  size 

syn keyword pawOperator	not and or
syn match   pawOperator "\(%\|+\|-\|/\|\*\)"

" syn region pawParen transparent start="\[" end="\]" contains=ALLBUT,pawParenError
" syn match  pawParenError   "\]"

syn keyword pawStatement pl[ot] cre[ate] li[st] co[py] read
syn keyword pawStatement del[ete] dr[aw] wr[ite] fi[le]
syn keyword pawStatement op[erations] 
syn keyword pawStatement vs[cale] vd[ivide] vmul[tiply] vadd vsub[tract] vbias
syn keyword pawStatement meta[file] primitives hplot print
syn keyword pawStatement if goto loop then return exec surf contour close
syn keyword pawStatement call hrout hrin text lego print project atitle labels

" Strings and characters:
syn region pawString		start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region pawString		start=+'+  skip=+\\\\\|\\'+  end=+'+

" Numbers:
syn match pawNumber		"-\=\<\d*\.\=[0-9_]\>"

" Comments:
" Comments may start with a * as the first char of a line...
syn region pawComment    start="^\s*\*"  end="\n"
" ... or at any point in a line by a pipe char
syn region pawComment    start="|" end="\n"
syn match pawComment	"--.*"

syn sync ccomment pawComment

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_paw_syn_inits")
  if version < 508
    let did_paw_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink pawComment	Comment
  HiLink pawKeyword	pawSpecial
  HiLink pawNumber	Number
  HiLink pawOperator	pawStatement
  HiLink pawSpecial	Special
  HiLink pawStatement	Statement
  HiLink pawString	String
  HiLink pawType	Type

  delcommand HiLink
endif

let b:current_syntax = "paw"

" vim: ts=8
