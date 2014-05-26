function! ToggleCommentify()
	let lineString = getline(".")						" don't comment empty lines
	if lineString != $									" don't comment empty lines
		let isCommented = strpart(lineString,0,3)		" getting the first 3 symbols
		let fileType = &ft								" finding out the file-type, and specifying the comment symbol to use
		if fileType == 'ox' || fileType == 'cpp'
			let commentSymbol = '///'
		elseif fileType == 'tex'
			let commentSymbol = '%'
		elseif fileType == 'fortran'
			let commentSymbol = 'C'
		elseif fileType == 'perl'
			let commentSymbol = '#'
		elseif fileType == 'mail'
			let commentSymbol = '>'
		elseif fileType == 'vim'
			let commentSymbol = '"""'
		elseif fileType == 'python'
			let commentSymbol = '###'
		else
			execute 'echo "ToggleCommentify has not (yet) been implemented for this file-type"'
			let commentSymbol = ''
		endif
		if isCommented == commentSymbol
			call s:UnCommentify(commentSymbol)			" if the line is already commented, uncomment
		else
			call s:Commentify(commentSymbol)			" otherwise comment the line
		endif
	endif
endfunction

function! s:Commentify(commentSymbol)
	set nohlsearch										" turn search highlighting off
														" add the comment symbol at the beginning of the line
	execute ':s+^+'.a:commentSymbol.'+'
	set hlsearch										" and turn highlighting back on
endfunction

function! s:UnCommentify(commentSymbol)
	set nohlsearch
	execute ':s+'.a:commentSymbol.'++'
	set hlsearch
endfunction


