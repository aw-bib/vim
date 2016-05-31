"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Some setlocaltings to use vim as editor for LaTeX
" Based on various packages form the Net, namely auctex.vim
"
" (c) 2000 by Alexander Wagner, Team OS/2 Franken
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Global Options for TeX:
setlocal isk+=\
" Compilers, Previewers and stuff
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" Compilers uses:
"   - OS/2: emTeX
"   - Win : MikTeX
"   - Unix: teTeX
"
" Check if we have a makefile in this directory. If so we assume that
" this one contains the necessary steps for the compiler and we'll use
" it instead of direct calls to the compiler. Otherwise the compilers
" get called directly with the current file as input.
"
if filereadable('makefile') || filereadable('Makefile')
   setlocal makeprg=make
else 
   " default to lualatex
   setlocal makeprg=lualatex\ --interaction=nonstopmode\ %
endif

" inoremap <buffer> <BS> x<Esc>:call SmartBS('{\S*}')<CR>a<BS><BS>

" The following functions are independent of the platform so they are
" grouped together
"   ,rl = run latex (on current file)
"   ,rt = run plain tex (on current file)
"   ,ps = create ps and view it 
"
map <buffer> ,rl :wall<cr>:make <CR>
map <buffer> ,m  mz,rl<cr>
map <buffer> ,rt :wall<cr>:!tex % <CR><CR>

" Now actual compilers get called, so one has to care about hte
" platform. Note that not everything is implemented for every OS here.
"   ,pr = run previewer on dvi version of document
"   ,ri = make the index
"   ,rb = run BibTeX
"   ,fi = generate final incl. PS

if has("os2")
   map <buffer> ,vps :!start /n /f E:\ghostscript\gsview\gvpm.exe %<.ps <CR><CR>
   map <buffer> ,pr :!start /n /f dvipm @lj.cnf +z.x:5 +z.y:5 /fl=-1 %<.dvi <CR><CR>
   map <buffer> ,ri :make<cr>:!mkidx32 %< <CR><CR>:make<cr>
   map <buffer> ,rb :!bibtex32 %< <CR><CR>
   map <buffer> ,ie :!ispelle % <CR><Space>:e %<cr>
   map <buffer> ,ig :!ispellg % <CR><Space>:e %<cr>
   map <buffer> ,ps :wall<cr>:make<cr>:!dvips %<.dvi<cr><cr>
elseif has("win32")
   map <buffer> ,vps :!C:\Programme\Ghostgum\gsview\gsview32.exe %<.ps <CR><CR>
else 
   map <buffer> ,vps :!ggv %<.ps<cr><cr>
   map <buffer> ,pr :!xdvi %<.dvi<cr><cr>
   map <buffer> ,ps :!dvips -f %<.dvi > %<.ps<cr>

endif

map <buffer> ,fi  :call TeXFinal()<cr>
map <buffer> ,pdf :call TeXPDF()<cr>

" Creates the 'Final Version', that is: run latex, makeindex, bibtex, latex
" and dvips in sequence. Then jump to the first error reported. As projects
" can consist of more than one file the 'MASTERFILE' is sarched first. This is
" done by search("MASTERFILE") on all buffers loaded. NOTE that the first
" MASTERFILE found is treated as such, so don't open more than one MASTERFILE
" in one session. (No probelm when using :mksession...)

fun! TeXFinal()
   if has("os2")
      " let dvips = "dvips "
      let mkidx = "mkidx32 "
      let bibtex = "bibtex32 "
   elseif has("win32")
      " let dvips = "dvips "
      let mkidx = "makeindex "
      let bibtex = "bibtex "
   else 
      " let dvips = "dvips "
      let mkidx = "makeindex "
      let bibtex = "bibtex "
   endif

   let i = 1

   while i <= bufnr("$")
      if (bufexists(i))
         execute "b " . i
         if (search("MASTERFILE") > 0)
            let main = bufname("%")
            let basename = fnamemodify(main, ":r")
            break
         endif
      endif
      let i = i+1
   endwhile
   execute "b " . main
   make
   execute "!" . mkidx . basename
"  Call bibtex after the first TeX-run, then run latex _twice_ to get the
"  references and crossreferences correct.
   execute "!" . bibtex . basename
   execute "b " . main
   make
   execute "b " . main
   make
   execute "b " . main
   " lualatex produces a pdf right away. Traditional latex would
   " create a dvi that needs to be converted to ps.gz or the like
   " execute "!" . dvips . "-f %<.dvi > %<.ps "
   "  Compress the created PostScript. gv et al can handle ps.gz
   " execute "! gzip -f  %<.ps"
   :cn
endfun

" Create a PDF out of the main document.
fun! TeXPDF()
   " use lualatex to produce a pdf from a utf-8 encoded latex document
   let latex = "lualatex"

   let i = 1
   while i <= bufnr("$")
      if (bufexists(i))
         execute "b " . i
         if (search("MASTERFILE") > 0)
            let main = bufname("%")
            let basename = fnamemodify(main, ":r")
            break
         endif
      endif
      let i = i+1
   endwhile
   execute "b " . main
   :wa<cr>
   execute "!" . latex . basename
   :cn
endfun

"   Jump to prev / next error
map <buffer> - :cp<cr>
map <buffer> + :cn<cr>
map <buffer> ,tv :vnew ~/vimakro/tex.vim<cr>

map <buffer> ,Ma     :call TeX_matrix()<cr>
map <buffer> ,um     :call TeX_unmatrix()<cr>
map <buffer> _Env    :call TeX_ask_env()<cr>
map <buffer> ,Env    :call TeX_read_env()<cr>

" Syntax expansion for LaTeX
" ~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" Map Umlauts to there equivalent though many compilers know them via
" inputenhance this will allways work...
if has("os2")
   inoremap <buffer> é      {\"A}
   inoremap <buffer> ô      {\"O}
   inoremap <buffer> ö      {\"U}
   inoremap <buffer> Ñ      {\"a}
   inoremap <buffer> î      {\"o}
   inoremap <buffer> Å      {\"u}
   inoremap <buffer> ·       {\ss}
   inoremap <buffer> ß       \S
elseif has("win32")
   inoremap <buffer> é      "A
   inoremap <buffer> ô      "O
   inoremap <buffer> ö      "U
   inoremap <buffer> Ñ      "a
   inoremap <buffer> î      "o
   inoremap <buffer> Å      "u
   inoremap <buffer> ·       "s
   inoremap <buffer> ß       \S
else
   inoremap <buffer> ƒ       "A
   inoremap <buffer> ÷       "O
   inoremap <buffer> ‹       "U
   inoremap <buffer> ‰       "a
   inoremap <buffer> ˆ       "o
   inoremap <buffer> ¸       "u
   inoremap <buffer> ﬂ       "s
   inoremap <buffer> ß       \S

endif

inoreabbr <buffer> \cd    \cdot
inoreabbr <buffer> \cds   \cdots

inoremap <buffer> \bei   \begin{itemize}o\end{itemize}O<tab>\item 
inoremap <buffer> \beq   \begin{equation}o\end{equation}O
inoremap <buffer> \bea   \begin{eqnarray}o\end{eqnarray}O
iabbr  <buffer> \it      \item
iabbr  <buffer> \hs      \hspace{<C-O>:call getchar()<CR>
iabbr  <buffer> \vs      \vspace{<C-O>:call getchar()<CR>
iabbr  <buffer> \pt      \partial
iabbr  <buffer> \ol      \overline{<C-O>:call getchar()<CR>
iabbr  <buffer> \ul      \underline{<C-O>:call getchar()<CR>
iabbr  <buffer> \un      \underbrace{<C-O>:call getchar()<CR>
iabbr  <buffer> \ch      \chapter{<C-O>:call getchar()<CR>
iabbr  <buffer> \se      \section{<C-O>:call getchar()<CR>
iabbr  <buffer> \su      \subsection{<C-O>:call getchar()<CR>
iabbr  <buffer> \ss      \subsubsection{<C-O>:call getchar()<CR>
iabbr  <buffer> \par     \paragraph{<C-O>:call getchar()<CR>
iabbr  <buffer> \hb      \hbar
iabbr  <buffer> \ov      \over
iabbr  <buffer> \ci      \cite{<C-O>:call getchar()<CR>
iabbr  <buffer> \Ria     \Rightarrow
iabbr  <buffer> \ria     \rightarrow
iabbr  <buffer> \tab     \tabular
iabbr  <buffer> \emi     \emindex{<C-O>:call getchar()<CR>
iabbr  <buffer> \nfi     \nfindex{<C-O>:call getchar()<CR>
iabbr  <buffer> \bfi     \bfindex{<C-O>:call getchar()<CR>

imap <buffer> " <C-R>=TexQuotes()<CR>
inoreabbr <buffer> \v     \vec{}i

" Math Abbreviations

iab <buffer> \b \bigskip
iab <buffer> \h \hspace{}<Left>
iab <buffer> \m \medskip
iab <buffer> \n \nonumber\\
iab <buffer> \p \newpage
iab <buffer> \q \qquad
iab <buffer> \v \vfill

" Due to Ralf Arens <ralf.arens@gmx.net>
inoremap <buffer> <F5> <C-O>:call PutEnvironment(input("Environment? "))<CR>
inoremap <buffer> <F6> <C-O>:call ChangeEnvironment(input("Environment? "))<CR>
noremap  <buffer> <F6> :call ChangeEnvironment(input("Environment? "))<CR>

" Bracket Completion Macros
" Typing the symbol a second time (for example, $$) will result in one
" of the symbole (for instance, $).  With {, typing \{ will result in \{\}.
inoremap <buffer> ( <C-R>=Double("(",")")<CR>
inoremap <buffer> [ <C-R>=Double("[","]")<CR>
inoremap <buffer> $ <C-R>=Double("$","$")<CR>
inoremap <buffer> & <C-R>=DoubleAmpersands()<CR>
inoremap <buffer> { <C-R>=CompleteSlash("{","}")<CR>
inoremap <buffer> \| <C-R>=CompleteSlash("\|","\|")<CR>
inoremap <buffer> \l( <C-R>=Double("\\left(","\\right)")<CR><esc>5<Left>i  <esc>i
inoremap <buffer> \l[ <C-R>=Double("\\left[","\\right]")<CR><esc>5<Left>i  <esc>i
inoremap <buffer> \l{ <C-R>=Double("\\left\\{","\\right\\}")<CR><esc>6<Left>i  <esc>i
inoremap <buffer> \l< <C-R>=Double("\\langle","\\rangle")<CR><esc>5<Left>i  <esc>i
"
" Greek letter, AucTex style bindings
"
inoremap <buffer> `` ``
inoremap <buffer> 'a \alpha
inoremap <buffer> 'b \beta
inoremap <buffer> 'c \chi
inoremap <buffer> 'd \delta
inoremap <buffer> 'e \varepsilon
inoremap <buffer> 'f \varphi
inoremap <buffer> 'g \gamma
inoremap <buffer> 'h \eta
inoremap <buffer> 'i \infty
" Or \iota or \infty or \in
inoremap <buffer> 'k \kappa
inoremap <buffer> 'l \lambda
inoremap <buffer> 'm \mu
inoremap <buffer> 'n \nu
inoremap <buffer> 'o \omega
inoremap <buffer> 'p \phi
inoremap <buffer> 'q \theta
inoremap <buffer> 'r \rho
inoremap <buffer> 's \sigma
inoremap <buffer> 't \tau
inoremap <buffer> 'u \upsilon
inoremap <buffer> 'v \vee
inoremap <buffer> 'w \wedge
inoremap <buffer> 'x \xi
inoremap <buffer> 'y \psi
inoremap <buffer> 'z \zeta
inoremap <buffer> 'D \Delta
inoremap <buffer> 'I \int_{}^{}<Esc>3hi
inoremap <buffer> 'F \Phi
inoremap <buffer> 'G \Gamma
inoremap <buffer> 'L \Lambda
inoremap <buffer> 'N \nabla
inoremap <buffer> 'O \Omega
inoremap <buffer> 'Q \Theta
inoremap <buffer> 'R \varrho
inoremap <buffer> 'S \sum_{}^{}<Esc>3hi
inoremap <buffer> 'U \Upsilon
inoremap <buffer> 'X \Xi
inoremap <buffer> 'Y \Psi
inoremap <buffer> '0 \emptysetlocal
inoremap <buffer> '1 \left
inoremap <buffer> '2 \right
inoremap <buffer> '3 \Big
inoremap <buffer> '6 \partial
inoremap <buffer> '8 \infty
inoremap <buffer> '/ \frac{}{}<Esc>2hi
inoremap <buffer> '% \frac{}{}<Esc>2hi
inoremap <buffer> '@ \circ
inoremap <buffer> '\| \Big\|
inoremap <buffer> '= \equiv
inoremap <buffer> '\ \setlocalminus
inoremap <buffer> '. \cdot
inoremap <buffer> '* \times
inoremap <buffer> '& \wedge
inoremap <buffer> '- \bigcap
inoremap <buffer> '+ \bigcup
inoremap <buffer> '( \subsetlocal
inoremap <buffer> ') \supsetlocal
inoremap <buffer> '< \le
inoremap <buffer> '> \ge
inoremap <buffer> ', \nonumber
inoremap <buffer> ': \dots
inoremap <buffer> '~ \tilde{}<Left>
inoremap <buffer> '^ \hat{}<Left>
inoremap <buffer> '; \dot{}<Left>
inoremap <buffer> '_ \bar{}<Left>
inoremap <buffer> '<M-c> \cos
inoremap <buffer> '<C-E> \exp\left(\right)<Esc>6hi
inoremap <buffer> '<C-I> \in
inoremap <buffer> '<C-J> \downarrow
inoremap <buffer> '<C-L> \log
inoremap <buffer> '<C-P> \uparrow
inoremap <buffer> '<Up> \uparrow
inoremap <buffer> '<C-N> \downarrow
inoremap <buffer> '<Down> \downarrow
inoremap <buffer> '<C-F> \to
inoremap <buffer> '<Right> \lim_{}<Left>
inoremap <buffer> '<C-S> \sin
inoremap <buffer> '<C-T> \tan


"------------------ old ---------------------
" make the word under the cursor into an environent (br)
"  noremap ,Env B"zyEi\begin{<ESC>Ea}<CR>\end{<ESC>"zpa}<CR><ESC>?\\end<CR>O	
"  inoremap Œ0   <esc>B"zyEi\begin{<ESC>Ea}<CR>\end{<ESC>"zpa}<CR><ESC>?\\end<CR>O	
" as above, but without the extra carrige returns, for inline environments
"  noremap ,ENV B"zyEi\begin{<ESC>Ea}\end{<ESC>"zpa}<CR><ESC>?\\end
"------------------ old ---------------------


" The following section is form Benji Fisher's texmacro.vim
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" 4. Functions that do automatic formatting

" Assume the cursor is on a " and return TeX-style open quotes or close
" quotes appropriately.
" TODO:  Deal with nested quotes.
function! TeX_quote()
  let l = line(".")
  let c = col(".")
  if synIDattr(synID(l, c, 1), "name") =~ "^texMath"
    	\ || (c > 1 && getline(l)[c-2] == '\')
    return '"'
  endif
  if exists("g:TeX_open")
    let open = g:TeX_open
  else
    let open = "``"
  endif
  if exists("g:TeX_close")
    let close = g:TeX_close
  else
    let close = "''"
  endif
  let boundary = '\|'
  if exists("g:TeX_strictquote")
    if( g:TeX_strictquote == "open" || g:TeX_strictquote == "both" )
      let boundary = '\<' . boundary
    endif
    if( g:TeX_strictquote == "close" || g:TeX_strictquote == "both" )
      let boundary = boundary . '\>'
    endif
  endif
  let q = open
  let ws_save = &wrapscan
  setlocal wrapscan	" so the search will not fail
  while 1	" Look for preceding quote (open or close), ignoring
  		" math mode and '\"' .
    execute 'normal ?^$\|"\|' . open . boundary . close . "\r"
    if synIDattr(synID(line("."), col("."), 1), "name") !~ "^texMath"
    	\ && (col(".") == 1 || getline(".")[col(".")-2] != '\')
      break
    endif
  endwhile
  " Now, test whether we actually found a _preceding_ quote; if so, is it
  " and open quote?
  if ( line(".") < l || line(".") == l && col(".") < c )
    if strlen(getline("."))
      if ( getline(".")[col(".")-1] == open[0] )
        let q = close
      endif
    endif
  endif
  " Return to line l, column c:
  execute l . " normal " . c . "|"
  let &wrapscan = ws_save
  return q
endfunction

" " Usage:  :let bar = 3 | TeXLine bar put='% comment'
" command! -nargs=* TeXLine
" 	\ | execute 'let TeX_Line_range=' . matchstr(<q-args>, '\S\+')
" 	\ | execute TeX_Line_range . substitute(<q-args>, '\S\+', "", "")
" 	\ | unlet TeX_Line_range

" Usage:  :let foo = 1 | let bar = 3 | TeXRange foo bar s/foo/bar
command! -nargs=* TeXRange
	\ execute 'let TeX_Range_range=' . substitute(<q-args>,
		\ '\(\S\+\)\s\+\(\S\+\).*', '\1.",".\2', "")
	\ | exe TeX_Range_range . substitute(<q-args>, '\S\+\s\+\S\+', "", "")
	\ | unlet TeX_Range_range

fun! TeX_matrix(...) range
  let save_report = &report
  setlocal report =1000 " Suppress messages from :s
  if exists("a:1")
    let env = a:1
  else
    let env = "pmatrix"
  endif
  TeXRange a:firstline a:lastline	s/\t/ \&/eg
  TeXRange a:firstline (a:lastline-1)	s/$/ \\\\/
  TeXRange a:firstline a:lastline	s/^/  /
  call append(a:lastline, '\end{' . env . '}')
  call append(a:firstline-1, '\begin{' . env . '}')
  let &report = save_report
endfun

fun! TeX_unmatrix() range
  let save_report = &report
  setlocal report =1000 " Suppress messages from :s
  TeXRange a:firstline a:lastline	s/ \&/\t/eg
  TeXRange a:firstline a:lastline	s/ \\\\$//e
  TeXRange a:firstline a:lastline	s/^  //e
  execute a:lastline . "d"
  execute a:firstline . "d"
  let &report = save_report
endfun

fun! TeX_cases() range
  " Stop-gap until I change the vmaps and menu items
  TeXRange a:firstline a:lastline call TeX_matrix("cases")
endfun

" Do an elementary row operation
fun! TeX_Row_op(vector, scalar)
  let v = a:vector
  while strlen(v)
    let bar = matchstr(v, "[^\t]*")
    let v=strpart(v, 1+strlen(bar), strlen(v))
    execute "normal cW\<C-R>=@\"+a:scalar*bar\<CR>\<Esc>w"
  endwhile
endfun

" 4a. Ralf Arens's AUC-TeX inspired functions for LaTeX environments
" TODO:  I have lots of plans.  For now, I am pretty much pasting them in as
" Ralf Arens wrote them.  For now, I will only modify them so that they start
" with "TeX_" and provide menu entries for them.

" some macros for LaTeX
"
" by Ralf Arens <ralf.arens@gmx.net>
" Thu 27 Jan 2000, 15:24:58 CET

" inspired by AUC TeX's `LaTeX-environment'
"
" map `:call TeX_ask_env()' and `TeX_read_env()' to convient shortcuts

" this asks for an environment and
" inserts \begin{...} and \end{...} commands

function! TeX_ask_env()
    let env = input("Environment? ")
    call TeX_common_env(env)
endfunction

" this reads the current and creates an environment out if it
" (this way you can use ins-completion)
function! TeX_read_env()
    let env = getline(".")
    normal ddk
    call TeX_common_env(env)
endfunction

" common routine for all environments
function! TeX_common_env(env)
    if (a:env=="figure" || a:env=="figure*" )
        call TeX_figure(a:env)
    elseif (a:env=="table" || a:env=="table*")
        call TeX_table(a:env)
    elseif (a:env=="tabular" || a:env=="tabular*" ||
           \a:env=="array" || a:env=="array*")
        call TeX_tabular(a:env, "")
    elseif (a:env=="eqnarray" || a:env=="equation*")
        call TeX_eqnarray(a:env)
    elseif (a:env=="list")
        call TeX_list(a:env)
    elseif (a:env=="itemize" || a:env=="theindex" ||
           \a:env=="trivlist" || a:env=="enumerate")
        call TeX_itemize(a:env)
    elseif (a:env=="description")
        call TeX_description(a:env)
    elseif (a:env=="document")
        call TeX_document(a:env)
    elseif (a:env=="minipage")
        call TeX_minipage(a:env)
    elseif (a:env=="thebibliography")
        call TeX_thebibliography(a:env)
    else
        put ='\begin{'.a:env.'}'
        put ='\end{'.a:env.'}'
    endif
endfunction

" special treatment for `figure'
function! TeX_figure(env)
    let flto = input("Float to (htbp)? ")
    "let pos = input("Position (htbp)? ")
    let caption = input("Caption? ")
    let center = input("Center (y/n)? ")
    " confirm is also possible, but I don't like it (in a terminal)
    "let center = confirm("Center?", "&yes\n&no")
    let label = input('Label (for use with \ref)? ')
    " additional to AUC TeX since my pics are usually external files
    let pic = input("Name of Pic-File? ")
    "
    " what should hapen if flto is empty? default values? nothing?
    put ='\begin{'.a:env.'}['.flto.']'
    put ='\end{'.a:env.'}'
    normal k
    if (center == "y")
        put ='    \begin{center}'
        put ='    \end{center}'
        normal m'
        normal k
    endif
    if (pic != "")
        put ='        \input{'.pic.'}'
    endif
    if (caption != "")
        put ='        \caption{'.caption.'}'
    endif
    if (label != "")
        put ='        \label{'.label.'}'
    endif
    normal ''
endfunction

" special treatment for `table'
function! TeX_table(env)
    let flto = input("Float to (htbp)? ")
    let caption = input("Caption? ")
    let center = input("Center (y/n)? ")
    " confirm is also possible, but I don't like it (in a terminal)
    "let center = confirm("Center?", "&yes\n&no")
    let label = input('Label (for use with \ref)? ')
    " TODO what should hapen if flto is empty? default values? nothing?
    put ='\begin{'.a:env.'}['.flto.']'
    put ='\end{'.a:env.'}'
    normal k
    if (center == "y")
        put ='    \begin{center}'
        put ='    \end{center}'
        normal k
    endif
    normal m'
    if (caption != "")
        put ='        \caption{'.caption.'}'
    endif
    if (label != "")
        put ='        \label{'.label.'}'
    endif
    normal ''
    call TeX_tabular("tabular", "        ")
endfunction

" special treatment for `tabular' and `array'
function! TeX_tabular(env, indent)
    let foo = a:indent.'\begin{'.a:env.'}'
    let pos = input("(Optional) Position (t b)? ")
    if (pos!="")
        let foo = foo.'['.pos.']'
    endif
    let format = input("Format  ( l r c p{width} | @{text} )? ")
    put =foo.'{'.format.'}'
    put =a:indent.'\end{'.a:env.'}'
    normal k
endfunction

" special treatment for `eqnarray' and `equation'
function! TeX_eqnarray(env)
    let label = input("Label? ")
    put ='\begin{'.a:env.'}'
    if (label != "")
        put ='    \label{'.label.'}'
    endif
    put ='\end{'.a:env.'}'
    normal k
endfunction

" special treatment for `list' (unlike AUC TeX)
function! TeX_list(env)
    let label = input("Label (for \item)? ")
    let foo ='\begin{'.a:env.'}'
    if (label != "")
        let foo = foo.'{'.label.'}'
        let addcmd = input("Additional commands? ")
        if (addcmd != "")
            let foo = foo.'{'.addcmd.'}'
        endif
    endif
    put =foo
    put ='\end{'.a:env.'}'
    normal k
    put ='    \item'
endfunction

" special treatment for `itemize', `enumerate', `theindex', `trivlist'
function! TeX_itemize(env)
    put ='\begin{'.a:env.'}'
    put ='\end{'.a:env.'}'
    normal k
    put ='    \item'
endfunction

" special treatment for `description'
function! TeX_description(env)
    put ='\begin{'.a:env.'}'
    put ='\end{'.a:env.'}'
    normal k
    let itlabel = input("(Optional) Item label? ")
    if (itlabel == "")
        put ='    \item'
    else
        put ='    \item['.itlabel.']'
    endif
endfunction

" special treatment for `document'
function! TeX_document(env)
    let dstyle = input("Document style (article report book)? ")
    let opts = input("(Optional) Options? ")
    let foo = '\documentclass'
    if (opts=="")
        let foo = foo.'{'.dstyle.'}'
    else
        let foo = foo.'['.opts.']'.'{'.dstyle.'}'
    endif
    put =foo
    put =""
    put ='\begin{document}'
    put ='\end{document}'
    normal k
endfunction

" special treatment for `minipage'
function! TeX_minipage(env)
    let foo = '\begin{minipage}'
    let pos = input("(Optional) Position (t b)? ")
    let width = input("Width? ")
    if (pos=="")
        let foo = foo.'{'.width.'}'
    else
        let  foo = foo.'['.pos.']{'.width.'}'
    endif
    put =foo
    put ='\end{minipage}'
    normal k
endfunction

" special treatment for `thebibliography'
function! TeX_thebibliography(env)
    let foo = '\begin{thebibliography}'
    " AUC TeX: "Label for BibItem: 99"
    let indent = input("Indent for BibItem? ")
    let foo = foo.'{'.indent.'}'
    let biblabel = input("(Optional) Bibitem label? ")
    let key = input("Add key? ")
    let bar = '    \bibitem'
    if (biblabel!="")
        let bar = bar.'['.biblabel.']'
    endif
    let bar = bar.'{'.key.'}'
    put =foo
    put =bar
    put ='\end{thebibliography}'
    normal k
endfunction

" Smart quotes.  Thanks to Ron Aaron <ron@mossbayeng.com>.
function! TexQuotes ()
    let insert = "''"
    let left = getline(line("."))[col(".")-2]
    if left == ' ' || left == '' || left == '	'   " Tab
	let insert = '``'
    elseif left == '\'
	let insert = '"'
    endif
    return insert
endfunction

function! PutEnvironment (env)
    put! ='\begin{' . a:env . '}'
    normal j
    put ='\end{' . a:env . '}'
    normal k
    if a:env == "array"
	call ArgumentsForArray(input("{rlc}? "))
    endif
    if a:env == "theorem" || a:env == "lemma" || a:env == "equation" || a:env == "eqnarray" || a:env == "align" || a:env == "multline"
	call AskLabel(input("Label? "))
    endif
endfunction

function! ChangeEnvironment (env)
    exe "normal /\\\\end\\|\\\\]\<CR>dd"
    put! = '\end{' . a:env . '}'
    exe "normal ?\\\\begin\\|\\\\[\<CR>dd"
    put! = '\begin{' . a:env . '}'
    normal j
    if a:env == "theorem" || a:env == "lemma" || a:env == "equation" || a:env == "eqnarray" || a:env == "align" || a:env == "multline"
	if (-1 == match(getline(line(".")),"\\label"))
	    call AskLabel(input("Label? "))
	endif
    elseif a:env[strlen(a:env)-1] == '*'
	if (-1 != match(getline(line(".")),"\\label"))
	    normal dd
	endif
    endif
endfunction

" Complete Curly Brackets and Absolute Values
function! CompleteSlash(left,right)
    let column = col(".")
    let first = getline(line("."))[column-2]
    let second = getline(line("."))[column-1]
    if first == "\\"
        return a:left . "\\" . a:right . "\<Left>\<Left>"
    elseif first == a:left && second == a:right
        return "\<C-O>s"
    else
        return a:left . a:right . "\<Left>"
    endif
endfunction

" Double ampersands, unless you are in an array environment
function! DoubleAmpersands ()
    let stop = 0
    let currentline = line(".")
    while stop == 0
	let currentline = currentline - 1
	let thisline = getline(currentline)
	if thisline =~ '\\begin' || currentline == 0
	    let stop = 1
	endif
    endwhile
    if thisline =~ '\\begin{array}'
	return "&"
    elseif strpart(getline(line(".")),col(".")-2,2) == "&&"
	return "\<C-O>s"
    else
	return "&&\<Left>"
    endif
endfunction

" This doesn't work yet. It should toggle the display of warnings in the
" errorlist. But what's the efm???
"
"  nmap ,tl :silent call Toggle_LaTeX()<cr>
"  
"  fu! Toggle_LaTeX()
"    if exists("b:ToggleLaTeX")
"      unlet b:ToggleLaTeX
"      echo"LaTeX warnings on"
"    else
"      let b:ToggleLaTeX=1
"      echo"LaTeX warnings off"
"    endif
"  endf

" Set up the errorparsing:
    setlocal efm=%E!\ LaTeX\ %trror:\ %m,
       \%E!\ %m,
       \%+WLaTeX\ %.%#Warning:\ %.%#line\ %l%.%#,
       \%+W%.%#\ at\ lines\ %l--%*\\d,
       \%WLaTeX\ %.%#Warning:\ %m,
       \%Cl.%l\ %m,
       \%+C\ \ %m.,
       \%+C%.%#-%.%#,
       \%+C%.%#[]%.%#,
       \%+C[]%.%#,
       \%+C%.%#%[{}\\]%.%#,
       \%+C<%.%#>%.%#,
       \%C\ \ %m,
       \%-GSee\ the\ LaTeX%m,
       \%-GType\ \ H\ <return>%m,
       \%-G\ ...%.%#,
       \%-G%.%#\ (C)\ %.%#,
       \%-G(see\ the\ transcript%.%#),
       \%-G\\s%#,
       \%+O(%f)%r,
       \%+P(%f%r,
       \%+P\ %\\=(%f%r,
       \%+P%*[^()](%f%r,
       \%+P[%\\d%[^()]%#(%f%r,
       \%+Q)%r,
       \%+Q%*[^()])%r,
       \%+Q[%\\d%*[^()])%r

