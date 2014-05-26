" Vim syntax file
" Language:    Scid Repertoir Files
" Maintainer:
" Last Update: Tue, 2003/04/01, 14:23:30
"
"
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if version < 600
  set iskeyword=$,48-57,_,a-z,@-Z
else
  setlocal iskeyword=$,48-57,_,a-z,@-Z
endif

" parenthesis/curly/brace sanity checker
syn region mvZone	matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" transparent contains=ALLBUT,mvError,mvBraceError,mvCurlyError
syn region mvZone	matchgroup=Delimiter start="{" matchgroup=Delimiter end="}" transparent contains=ALLBUT,mvError,mvBraceError,mvParenError
syn region mvZone	matchgroup=Delimiter start="\[" matchgroup=Delimiter end="]" transparent contains=ALLBUT,mvError,mvCurlyError,mvParenError
syn match  mvError		"[)\]}]"
syn match  mvBraceError	"[)}]"	contained
syn match  mvCurlyError	"[)\]]"	contained
syn match  mvParenError	"[\]}]"	contained
syn match  mvComma		"[,;:]"
syn match  mvSemiError	"[;:]"	contained

" Lower-Priority Operators
syn match mvOper	"\."
syn match mvOper    "+ "
syn match mvOper    "- "

" Number handling
syn match mvNumber	"\<\d\+"		" integer
 syn match mvNumber	"[-+]\=\.\d\+"		" . integer
syn match mvNumber	"\<\d\+\.\d\+"		" integer . integer
syn match mvNumber	"\<\d\+\."		" integer .
syn match mvNumber	"\<\d\+\.\."	contains=mvRange	" integer ..

syn match mvNumber	"\<\d\+e[-+]\=\d\+"		" integer e [-+] integer
syn match mvNumber	"[-+]\=\.\d\+e[-+]\=\d\+"	" . integer e [-+] integer
syn match mvNumber	"\<\d\+\.\d*e[-+]\=\d\+"	" integer . [integer] e [-+] integer

syn match mvNumber	"[-+]\d\+"		" integer
syn match mvNumber	"[-+]\d\+\.\d\+"		" integer . integer
syn match mvNumber	"[-+]\d\+\."		" integer .
syn match mvNumber	"[-+]\d\+\.\."	contains=mvRange	" integer ..

syn match mvNumber	"[-+]\d\+e[-+]\=\d\+"	" integer e [-+] integer
syn match mvNumber	"[-+]\d\+\.\d*e[-+]\=\d\+"	" integer . [integer] e [-+] integer

syn match mvRange	"\.\."

" Operators
syn keyword mvOper	and not or
syn match   mvOper	"->\|<>\|[<>]=\|[<>]\|=\|:="
syn match   mvOper	"&+\|&-\|&\*\|&\/\|&"
syn match   mvError	"\.\.\."

" Comments:  DEBUG, if in a comment, is specially highlighted.
syn keyword mvDebug	contained	DEBUG
syn cluster mvCommentGroup	contains=mvTodo,mvDebug
syn match mvComment "@.*$"	contains=@mvCommentGroup
syn match mvComment ";.*$"	contains=@mvCommentGroup
syn match mvComment "#.*$"	contains=@mvCommentGroup

" Basic Library Functions: ? index[function]

" ==  PACKAGES  =======================================================

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_scid_syntax_inits")
  if version < 508
    let did_scid_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " scid->scid Links
  HiLink mvBraceError	mvError
  HiLink mvCurlyError	mvError
  HiLink mvDebug		mvTodo
  HiLink mvParenError	mvError
  HiLink mvPkg_linalg	mvPkgFunc
  HiLink mvRange		mvOper
  HiLink mvSemiError	mvError

  " scid->Standard Links
  HiLink mvAssign		Delimiter
  HiLink mvBool		Boolean
  HiLink mvComma		Delimiter
  HiLink mvComment		Comment
  HiLink mvCond		Conditional
  HiLink mvConstant		Number
  HiLink mvDelayEval	Label
  HiLink mvError		Error
  HiLink mvLibrary		Statement
  HiLink mvNumber		Number
  HiLink mvOper		Operator
  HiLink mvPackage		Type
  HiLink mvPkgFunc		Function
  HiLink mvPktOption	Special
  HiLink mvRepeat		Repeat
  HiLink mvSpecial		Special
  HiLink mvStatement	Statement
  HiLink mvString		String
  HiLink mvTodo		Todo

  delcommand HiLink
endif

let b:current_syntax = "scid"

" vim: ts=20
