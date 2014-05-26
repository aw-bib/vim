" Vim syntax file
" Language:    Axiom based upon Maple.vim
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

" MapleV Statements: ? statement
" Split into booleans, conditionals, operators, repeat-logic, etc
syn keyword mvBool	true	false
syn keyword mvCond	elif	else	fi	if	then

syn keyword mvRepeat	by	for	in	to                  end_for
syn keyword mvRepeat	do	from	od	while

syn keyword mvSpecial	NULL
syn match   mvSpecial	"\[\]\|{}"

syn keyword mvStatement	Order	fail	options	read	save
syn keyword mvStatement	break	local	point	remember	stop
syn keyword mvStatement	done	mod	proc	restart	with
syn keyword mvStatement	end	mods	quit	return              begin end_proc
syn keyword mvStatement	error	next
syn keyword mvStatement	Integer             Fraction            Float               Polynomial
syn keyword mvSpecial	clear       read      quit          trace    pquit     history  restore       lisp   load
syn keyword mvSpecial	library     show      write         save     change    file     frame         fin    edit
syn keyword mvSpecial	display     compile   constructor   close    cd        boot     abbreviation

" Builtin Constants: ? constants
syn keyword mvConstant	Catalan	%i	%infinity
syn keyword mvConstant	FAIL	%pi

" Comments:  DEBUG, if in a comment, is specially highlighted.
syn keyword mvDebug	contained	DEBUG
syn cluster mvCommentGroup	contains=mvTodo,mvDebug
syn match mvComment "#.*$"	contains=@mvCommentGroup
syn match mvComment "--.*$"	contains=@mvCommentGroup
syn match mvComment "++.*$"	contains=@mvCommentGroup

" Basic Library Functions: ? index[function]
syn keyword mvLibrary $	@	@@	ERROR
syn keyword mvLibrary AFactor	KelvinHer	arctan	factor	log	rhs
syn keyword mvLibrary AFactors	KelvinKei	arctanh	factors	log10	root
syn keyword mvLibrary AiryAi	KelvinKer	argument	fclose	lprint	roots
syn keyword mvLibrary AiryBi	LambertW	array	feof	map	round
syn keyword mvLibrary AngerJ	Lcm	assign	fflush	map2	rsolve
syn keyword mvLibrary Berlekamp	LegendreE	assigned	filepos	match	savelib
syn keyword mvLibrary besselI	LegendreEc	asspar	fixdiv	matrix	scanf
syn keyword mvLibrary besselJ	LegendreEc1	assume	float	max	searchtext
syn keyword mvLibrary besselK	LegendreF	asubs	floor	maximize	sec
syn keyword mvLibrary besselY	LegendreKc	asympt	fnormal	maxnorm	sech
syn keyword mvLibrary Beta	LegendreKc1	attribute	fopen	maxorder	select
syn keyword mvLibrary C	LegendrePi	bernstein	forget	member	seq
syn keyword mvLibrary Chi	LegendrePic	branches	fortran	min	series
syn keyword mvLibrary Ci	LegendrePic1	bspline	fprintf	minimize	setattribute
syn keyword mvLibrary CompSeq	Li	cat	frac	minpoly	shake
syn keyword mvLibrary Content	Linsolve	ceil	freeze	modp	showprofile
syn keyword mvLibrary D	MOLS	chrem	fremove	modp1	showtime
syn keyword mvLibrary DESol	Maple_floats	close	frontend	modp2	sign
syn keyword mvLibrary Det	MeijerG	close	fscanf	modpol	signum
syn keyword mvLibrary Diff	Norm	coeff	fsolve	mods	simplify
syn keyword mvLibrary Dirac	Normal	coeffs	galois	msolve	sin
syn keyword mvLibrary DistDeg	Nullspace	coeftayl	gc	mtaylor	singular
syn keyword mvLibrary Divide	Power	collect	gcd	mul	sinh
syn keyword mvLibrary Ei	Powmod	combine	gcdex	nextprime	sinterp
syn keyword mvLibrary Eigenvals	Prem	commutat	genpoly	nops	solve
syn keyword mvLibrary EllipticCE	Primfield	comparray	harmonic	norm	sort
syn keyword mvLibrary EllipticCK	Primitive	compoly	has	normal	sparse
syn keyword mvLibrary EllipticCPi	Primpart	conjugate	hasfun	numboccur	spline
syn keyword mvLibrary EllipticE	ProbSplit	content	hasoption	numer	split
syn keyword mvLibrary EllipticF	Product	convergs	hastype	op	splits
syn keyword mvLibrary EllipticK	Psi	convert	heap	open	sprem
syn keyword mvLibrary EllipticModulus	Quo	coords	history	optimize	sprintf
syn keyword mvLibrary EllipticNome	RESol	copy	hypergeom	order	sqrfree
syn keyword mvLibrary EllipticPi	Randpoly	cos	iFFT	parse	sqrt
syn keyword mvLibrary Eval	Randprime	cosh	icontent	pclose	sscanf
syn keyword mvLibrary Expand	Ratrecon	cost	identity	pclose	ssystem
syn keyword mvLibrary FFT	Re	cot	igcd	pdesolve	stack
syn keyword mvLibrary Factor	Rem	coth	igcdex	piecewise	sturm
syn keyword mvLibrary Factors	Resultant	csc	ilcm	plot	sturmseq
syn keyword mvLibrary FresnelC	RootOf	csch	ilog	plot3d	subs
syn keyword mvLibrary FresnelS	Roots	csgn	ilog10	plotsetup	subsop
syn keyword mvLibrary Fresnelf	SPrem	dawson	implicitdiff	pochhammer	substring
syn keyword mvLibrary Fresnelg	Searchtext	define	indets	pointto	sum
syn keyword mvLibrary Frobenius	Shi	degree	index	poisson	surd
syn keyword mvLibrary GAMMA	Si	denom	indexed	polar	symmdiff
syn keyword mvLibrary GaussAGM	Smith	depends	indices	polylog	symmetric
syn keyword mvLibrary Gaussejord	Sqrfree	diagonal	inifcn	polynom	system
syn keyword mvLibrary Gausselim	Ssi	diff	ininame	powmod	table
syn keyword mvLibrary Gcd	StruveH	dilog	initialize	prem	tan
syn keyword mvLibrary Gcdex	StruveL	dinterp	insert	prevprime	tanh
syn keyword mvLibrary HankelH1	Sum	disassemble	int	primpart	testeq
syn keyword mvLibrary HankelH2	Svd	discont	interface	print	testfloat
syn keyword mvLibrary Heaviside	TEXT	discrim	interp	printf	thaw
syn keyword mvLibrary Hermite	Trace	dismantle	invfunc	procbody	thiele
syn keyword mvLibrary Im	WeberE	divide	invztrans	procmake	time
syn keyword mvLibrary Indep	WeierstrassP	dsolve	iostatus	product	translate
syn keyword mvLibrary Interp	WeierstrassPPrime	eliminate	iperfpow	proot	traperror
syn keyword mvLibrary Inverse	WeierstrassSigma	ellipsoid	iquo	property	trigsubs
syn keyword mvLibrary Irreduc	WeierstrassZeta	entries	iratrecon	protect	trunc
syn keyword mvLibrary Issimilar	Zeta	eqn	irem	psqrt	type
syn keyword mvLibrary JacobiAM	abs	erf	iroot	quo	typematch
syn keyword mvLibrary JacobiCD	add	erfc	irreduc	radnormal	unames
syn keyword mvLibrary JacobiCN	addcoords	eulermac	iscont	radsimp	unapply
syn keyword mvLibrary JacobiCS	addressof	eval	isdifferentiable	rand	unassign
syn keyword mvLibrary JacobiDC	algebraic	evala	isolate	randomize	unload
syn keyword mvLibrary JacobiDN	algsubs	evalapply	ispoly	randpoly	unprotect
syn keyword mvLibrary JacobiDS	alias	evalb	isqrfree	range	updatesR4
syn keyword mvLibrary JacobiNC	allvalues	evalc	isqrt	rationalize	userinfo
syn keyword mvLibrary JacobiND	anames	evalf	issqr	ratrecon	value
syn keyword mvLibrary JacobiNS	antisymm	evalfint	latex	readbytes	vector
syn keyword mvLibrary JacobiSC	applyop	evalgf	lattice	readdata	verify
syn keyword mvLibrary JacobiSD	arccos	evalhf	lcm	readlib	whattype
syn keyword mvLibrary JacobiSN	arccosh	evalm	lcoeff	readline	with
syn keyword mvLibrary JacobiTheta1	arccot	evaln	leadterm	readstat	writebytes
syn keyword mvLibrary JacobiTheta2	arccoth	evalr	length	realroot	writedata
syn keyword mvLibrary JacobiTheta3	arccsc	exp	lexorder	recipoly	writeline
syn keyword mvLibrary JacobiTheta4	arccsch	expand	lhs	rem	writestat
syn keyword mvLibrary JacobiZeta	arcsec	expandoff	limit	remove	writeto
syn keyword mvLibrary KelvinBei	arcsech	expandon	ln	residue	zip
syn keyword mvLibrary KelvinBer	arcsin	extract	lnGAMMA	resultant	ztrans
syn keyword mvLibrary KelvinHei	arcsinh


" ==  PACKAGES  =======================================================

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_axiom_syntax_inits")
  if version < 508
    let did_axiom_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " axiom->axiom Links
  HiLink mvBraceError	mvError
  HiLink mvCurlyError	mvError
  HiLink mvDebug		mvTodo
  HiLink mvParenError	mvError
  HiLink mvPkg_linalg	mvPkgFunc
  HiLink mvRange		mvOper
  HiLink mvSemiError	mvError

  " axiom->Standard Links
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

let b:current_syntax = "mupad"

" vim: ts=20
