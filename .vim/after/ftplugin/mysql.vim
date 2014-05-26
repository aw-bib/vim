" VIM Macrofile for use with MySQL
"

" " Load the dbextensions
" runtime mysql/multvals.vim
" runtime mysql/genutils.vim
" runtime mysql/dbext.vim
" 
" let g:dbext_default_buffer_lines = 5 
" let g:dbext_default_use_sep_result_buffer = 0
" 
" let dbext_default_MYSQL_bin = 'mysql'
" 
" :DBSetOption 'type=MYSQL'
" :DBSetOption 'user=$USER'
" :DBSetOption 'password=@askb'
" :DBSetOption 'host=localhost'

:SQLSetType mysql
let g:sql_type_default = 'mysql'
:set foldmethod=indent
:set foldlevel=1

