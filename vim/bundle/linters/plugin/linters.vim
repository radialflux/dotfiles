" g:linters_automatic_on_save is a global flag for enabling/disabling the
" automatic running of the linters plugin on every write.
if !exists('g:linters_automatic_on_save')
	let g:linters_automatic_on_save = 1
endif

" g:linters_disabled_filetypes can contain a list of filetypes that automatic
" linting should be disabled for
if !exists('g:linters_disabled_filetypes')
	let g:linters_disabled_filetypes = []
endif

" g:linters_extra can contain a list of extra linter definitions, to append or
" override to the existing set. It should be a list of triples of the format::
"
"     ['filetype', 'command', ['error', 'format', 'strings']]
if !exists('g:linters_extra')
	let g:linters_extra = []
endif

let s:scripts_dir = expand('<sfile>:h:h').'/scripts/'


let s:linters = {}
let s:empty_dict = {}
if !exists('g:linters_enabled')
	let g:linters_enabled = 1
endif


" Escape a single errorformat string, by escaping commas, and then escaping
" spaces, commas and backslashes. The result should be useable when setting
" errorformat strings:
" 	let errorformat = "%f: line %l, col %c, %m"
" 	execute "set errorformat=" . s:EscapeErrorFormat(errorformat)
function s:EscapeErrorFormat(string)
	let l:string = a:string
	let l:string = substitute(l:string, ',', '\\,', 'g')
	let l:string = substitute(l:string, '[\\, ]', '\\\0', 'g')
	return l:string
endfunction

" Escape a list of errorformat strings, joining them with a comma. The result
" will be useable when setting errorformat strings:
" 	let errorformats = ["%f: line %l, col %c, %m", "%f: line %l, %m"]
" 	execute "set errorformat=" . s:EscapeErrorFormats(errorformats)
function s:EscapeErrorFormats(strings)
	return join(map(a:strings, 's:EscapeErrorFormat(v:val)'), ',')
endfunction

" Run the linter for the current buffer, if there is one defined.
function s:RunLinter()
	if !g:linters_enabled
		return
	endif

	" Get buffers filetype
	let l:filetype = &ft

	let l:this_file = expand("%:p")
	if l:this_file =~ '^[a-zA-Z0-9]\+://'
		return
	endif

	let l:linter = get(s:linters, l:filetype, s:empty_dict)
	if l:linter == s:empty_dict
		return
	endif

	let l:temp_file = tempname()
	let l:cmd = printf(l:linter['linter'], shellescape(l:this_file), shellescape(l:temp_file))

	silent execute "!" . l:cmd

	if v:shell_error
		set errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m
		execute 'set errorformat=' . linter['errorformat']
		copen
		execute "cgetfile " . l:temp_file
	else
		call setqflist([])
		cclose
	endif

endfunction

" Define a new linter for a filetype
"
" Parameters:
"   filetype - The filetype this linter is used for
"   linter - The command to invoke. This must contain two "%s" placeholders.
"     The first is replaced with the full file path of the file being linted,
"     and the second is replaced with the output file for any errors. The
"     command can contain shell pipes and redirects, such as
"         mylinter --foo --input=%s | frobnicat > %s
"   errorformats - The errorformat strings to use. This should be a list of
"   all the different formats to use. The entries should not be escaped - the
"   escaping will be done automatically.
" 
" Example:
" 	call s:DefineLinter("foo", "foolint --input %s 2> %s", [
" 	\	"%f:%l:%c: %m",
" 	\	"%f:%l: %m"
" 	\])
function! s:DefineLinter(filetype, linter, errorformats)
	let l:errorformat_string = s:EscapeErrorFormats(a:errorformats)
	let s:linters[a:filetype] = {'linter': a:linter, 'errorformat': l:errorformat_string, }
endfunction

" Check to see if linting should be done. This checks if the linters plugin is
" disabled, or if linting for the current filetype is disabled, before running
" the linters.
function! s:WritePostHook()
	if !g:linters_automatic_on_save
		return
	endif
	if -1 != index(g:linters_disabled_filetypes, &filetype)
		return
	endif

	call s:RunLinter()
endfunction

" Expose the DefineLinter() function for external use. Has the same
" parameters.
function! linters#define(filetype, linter, errorformats)
	call DefineLinter(a:filetype, a:linter, a:errorformats)
endfunction

function! linters#run()
	call s:RunLinter()
endfunction

" jshint integration for linting JavaScript
if executable("jshint")
	call s:DefineLinter("javascript", "jshint %s > %s", ['%f: line %l, col %c, %m'])
endif

" coffeelint integration for linting coffeescript
if executable("coffeelint")
	call s:DefineLinter("coffee", "coffeelint --csv %s > %s", ['%f,%l,error,%m'])
endif

" LessCSS compiling using lessc and /dev/null
if executable("lessc")
	call s:DefineLinter("less", "lessc --no-color %s /dev/null 2> %s", ['%m in %f:%l:%c'])
endif

if executable("pylint")
	call s:DefineLinter('python', "pylint %s &> %s", [
	\	"%t:  %l,%c:%m",
	\	"%t: %l,%c:%m",
	\	"%t:%l,%c:%m",
	\])
endif

if executable("pyflakes")
	call s:DefineLinter('python', "pyflakes %s &> %s", ["%f:%l: %m"])
endif

if executable("pep8")
	call s:DefineLinter('python', "pep8 --ignore=E501 %s &> %s", ["%f:%l:%c: %t%n %m"])
endif

if executable("hlint")
	call s:DefineLinter('haskell', 'hlint %s > %s', ['%f:%l:%c: %m'])
endif

if executable("php")
	call s:DefineLinter('php', 'php -l %s &> %s', [
	\	"%m in %f on line %l",
	\])
elseif executable("php5")
	call s:DefineLinter('php', 'php -l %s &> %s', [
	\	"%m in %f on line %l",
	\])
else
	let s:linter = 'echo %s":1:1: Error: You''re using PHP" > %s ; exit 1'
	call s:DefineLinter('php', s:linter, ['%f:%l:%c: %m'])
endif

if executable("javac")
	call s:DefineLinter('java', "javac -Werror -Xlint %s &> %s", ['%f:%l: %m'])
endif

if executable("dot")
	call s:DefineLinter('dot', 'dot -Knop -Npos="0,0" -Tdot %s 1>/dev/null 2>%s', [
	\	'Error: %f:%l: %m',
	\])
endif

if executable("tidy")
	call s:DefineLinter('html', 'tidy -e --alt-text "" -utf8 %s 2>%s', [
	\	'line %l column %c - %m',
	\])
endif

if executable("splint")
	call s:DefineLinter('c', 'splint %s &>%s', [
	\	'%E%f:%l:%v: %m', '%+C %.%#',
	\])
endif

if executable("escript")
	let s:erlang_check = s:scripts_dir . 'erlang_check.erl'
	call s:DefineLinter('erlang', s:erlang_check.' %s > %s 2>&1', [
	\	'%f:%l: %tarning: %m', '%f:%l: %m', '%+C %.%#',
	\])
endif

" Load any linters from g:linters_extra, if it exists
for linter in g:linters_extra
	call s:DefineLinter(linter[0], linter[1], linter[2])
endfor

au BufWritePost * call s:WritePostHook()
