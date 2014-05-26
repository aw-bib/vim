"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" VIM Macrofile for e-mail
"
" Some settings usefull for vim as external mail-editor
" (c) 2000 Alexander Wagner, Team OS/2 Franken
"
" Last update: Wed, 2004/03/17, 11:26:22
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" The address book... Mainly just some iabbrs
source ~/.vim/addressbook.vim

" Look up addresses via address command
map ,a :r!address -s -f email <cword><cr>$kbdwJ$a

" mutt-Terminals have a meaningfull title, don't change it
set notitle

" Convert umlauts within original message
if has("os2")
   %s/Ñ/ae/g
   %s/î/oe/g
   %s/Å/ue/g
   %s/é/Ae/g
   %s/ô/Oe/g
   %s/ö/Ue/g
   %s/·/ss/g
elseif (($HOSTTYPE=="i386") || ($HOSTTYPE=="alpha") || ($HOSTTYPE=="i386-linux"))
   %s/‰/ae/g
   %s/ˆ/oe/g
   %s/¸/ue/g
   %s/ƒ/Ae/g
   %s/÷/Oe/g
   %s/‹/Ue/g
   %s/ﬂ/ss/g
endif

" Map umlauts to there 7bit equivalent 
if has("os2")
   imap <buffer> Ñ ae
   imap <buffer> î oe
   imap <buffer> Å ue
   imap <buffer> é Ae
   imap <buffer> ö Ue
   imap <buffer> ô Oe
   imap <buffer> ·  ss
" elseif (($OSTYPE=="linux")   || ($OSTYPE=="linux-gnu") || ($HOSTTYPE=="alpha") || ($HOSTTYPE=="i386-linux") || ($TERM=="xterm"))
elseif has("unix")
   imap <buffer> ‰ ae
   imap <buffer> ˆ oe
   imap <buffer> ¸ ue
   imap <buffer> ƒ Ae
   imap <buffer> ‹ Ue
   imap <buffer> ÷ Oe
   imap <buffer> ﬂ ss
endif

" set textwidth for mail to 60 chars
setlocal tw=60
" Tab's need to be exapanded in e-mail!
setlocal expandtab

" Source Justify to set mail in blockquote
:so ~/.vim/justify.vim
"
" switch off backups for e-mail
setlocal nobackup
setlocal syntax=mail
"
"enable autmatic quote folding
:setlocal foldmethod=expr
:setlocal foldexpr=strlen(substitute(substitute(getline(v:lnum),'\\s','',\"g\"),'[^>].*','',''))
"
" unfold last message quotes, keep older quotes folded
:setlocal foldlevel=1
"
" Don't use modelines in e-mail messages, avoid trojan horses
setlocal nomodeline
"
" Set 'formatoptions' to break text lines,
" and insert the comment leader ">" when hitting <CR> or using "o".
setlocal fo+=tcroql
iab <buffer> Yhome       http://www.stellarcom.org/index.html
iab <buffer> Yplucker    http://plucker.gnu-designs.com
iab <buffer> Yplucker2   http://www.stellarcom.org/plucker/os2_bins/index.html  

" Inserting an ellipsis to indicate deleted text
iab  <buffer> Yell  [...]
vmap <buffer> ,yell c[...]<ESC>
" Changing quote style to *the* true quote prefix string "> ":
"
"       Fix Supercite aka PowerQuote (Hi, Andi! :-):
"       before ,kpq:    >   Sven> text
"       after  ,kpq:    > > text
"      ,kpq kill power quote
map <buffer> ,kpq :1,$s/^> *[a-zA-Z]*>/> >/<C-M>
"
"       Fix various other quote characters:
"      ,fq "fix quoting"
map <buffer> ,fq :1,$s/^> \([-":}\|][ <C-I>]\)/> > /
"
"  Fix the quoting of "Microsoft Internet E-Mail":
"  The guilty mailer identifies like this:
"  X-Mailer: Microsoft Internet E-Mail/MAPI - 8.0.0.4211
"  
"  And this is how it quotes - with a pseudo header:
"
"  -----Ursprungliche Nachricht-----
"  Von:            NAME [SMTP:ADDRESS]
"  Gesendet am:    Donnerstag,  6. April 2000 12:07
"  An:             NAME
"  Cc:             NAME
"  Betreff:        foobar
"
" And here's how I "fix" this quoting:
" (it makes use of the mappings ",dp" and ",qp"):
  map <buffer>  #fix /^> -----.*-----$<cr>O<esc>j,dp<c-o>dapVG,qp

" Remove eGroups header stuff
  map <buffer>  #ef /-_->$<cr><esc>o<esc>d{ddx
  
"      ,j = join line in commented text
"           (can be used anywhere on the line)
  nmap <buffer>  ,j Vjgq
"
"      ,B = break line at current position *and* join the next line
  nmap <buffer>  ,B r<CR>Vjgq
"     ,hi = "Hi!"        (indicates first reply)
  map <buffer>  ,hi 1G}oHi!<CR><ESC>
  map <buffer>  ,ha 1G}oHallo!<CR><ESC>
"       remove signatures
"
"     ,kqs = kill quoted sig (to remove those damn sigs for replies)
"          goto end-of-buffer, search-backwards for a quoted sigdashes
"          line, ie "^> -- $", and delete unto end-of-paragraph:
  map <buffer>  ,kqs G?^> --\_.<CR>d}

" Quote the whole file
  map <buffer>  ,q :1<cr><C-v>GI> <esc> 

" Decyrpt a selected block
  vmap <buffer> ,D :s/^[> ]*//g<cr>gv:!gpg<cr><cr>

  map  <buffer> ,E :call GPGencrypt()<cr>

function! GPGencrypt ()

  let from=substitute(getline(1), "^From: ","", "")
  let from=substitute(from, "^[\"A-Za-z0-9@ ]*<", "", "")
  let from=substitute(from, ">.*", "", "")
  let rcpt=substitute(getline(2), "^To: ","", "")
  let rcpt=substitute(rcpt, "^[\"A-Za-z0-9@ ]*<", "", "")
  let rcpt=substitute(rcpt, ">.*", "", "")
  exec "9,$! gpg -ea --always-trust -r \"" . from . "\" -r \"" . rcpt . "\"" 
  redraw!

endfunction


syn region mailComment start="-=" end="\n"
