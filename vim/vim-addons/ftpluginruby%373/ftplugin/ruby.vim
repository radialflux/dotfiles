" Vim filetype plugin
" Language:     Ruby
" Maintainer:   Gavin Sinclair <gsinclair@soyabean.com.au>
" Last Change:  2002/08/12
" URL: www.soyabean.com.au/gavin/vim/index.html
" Chages: (since vim 6.1)
"  - removed everything! (shiftwidth, formatoptions etc, should are personal
"    preferences and should not be set in a global ftplugin)

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
    finish
endif
let b:did_ftplugin = 1

" There are no known setting particularly appropriate for Ruby.  Please
" contact the maintainer if you think of some.
