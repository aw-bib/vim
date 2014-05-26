" Vim syntax file
" Language:	parameters.dta and similar parameter files
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

" The param reserved words, defined as keywords.

syn keyword paramOperator	not and or
syn match   paramOperator "\(=\|+\|-\|/\|\*\)"

" Strings and characters:
syn region paramString		start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region paramString		start=+'+  skip=+\\\\\|\\'+  end=+'+

" Numbers:
"Numbers of various sorts: Stolen from fortran.vim
" Integers
syn match paramNumber display "\<\d\+\(_\a\w*\)\=\>"
" floating point number, without a decimal point
syn match paramFloatNoDec     display "\<\d\+[deq][-+]\=\d\+\(_\a\w*\)\=\>"
" floating point number, starting with a decimal point
syn match paramFloatIniDec    display "\.\d\+\([deq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"
" floating point number, no digits after decimal
syn match paramFloatEndDec    display "\<\d\+\.\([deq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"
" floating point number, D or Q exponents
syn match paramFloatDExp      display "\<\d\+\.\d\+\([dq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"
" floating point number
syn match paramFloat  display "\<\d\+\.\d\+\(e[-+]\=\d\+\)\=\(_\a\w*\)\=\>"

" Comments:
" Comments may start with a pipe or hash char
" Note that this is convention only. Parameter files consist mainly of just
" one number which is the value read in and the rest of the line is ignored.
syn region paramComment    start="|" end="\n"
syn region paramComment    start="#" end="\n"

syn sync ccomment paramComment

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_param_syn_inits")
  if version < 508
    let did_param_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink paramComment	Comment
  HiLink paramKeyword	paramSpecial
  HiLink paramNumber	Number
  HiLink paramFloat	Number
  HiLink paramFloatNoDec	Number
  HiLink paramFloatIniDec	Number
  HiLink paramFloatEndDec	Number
  HiLink paramFloatDExp	Number
  HiLink paramOperator	paramStatement
  HiLink paramSpecial	Special
  HiLink paramStatement	Statement
  HiLink paramString	String
  HiLink paramType	Type

  delcommand HiLink
endif

let b:current_syntax = "param"

" vim: ts=8
