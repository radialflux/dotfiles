scriptencoding utf-8

" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

Context types
  It tests escape string.
    ShouldEqual neocomplete#filters#fuzzy_escape(
          \ 'abc'), 'a.*b.*c.*'
    ShouldEqual neocomplete#filters#fuzzy_escape(
          \ '%a%b%c'), '%%a.*%%b.*%%c.*'
    ShouldEqual neocomplete#filters#fuzzy_escape(
          \ '%[ab]c'), '%%%[a.*b.*%]c.*'
    ShouldEqual neocomplete#filters#fuzzy_escape(
          \ '.abc'), '%.a.*b.*c.*'
  End

  It tests sort functions.
    let g:candidates = []
    for g:i in range(1, 1000)
      call add(g:candidates, { 'word' : g:i, 'rank' : g:i })
    endfor
    function! CompareRank(i1, i2)
      let diff = (get(a:i2, 'rank', 0) - get(a:i1, 'rank', 0))
      return (diff != 0) ? diff : (len(a:i1.word) < len(a:i2.word)) ? 1 : -1
    endfunction"

    " Benchmark.
    let g:start = reltime()
    call sort(copy(g:candidates), 'CompareRank')
    echomsg reltimestr(reltime(g:start))
    let g:start = reltime()
    call neocomplete#filters#sorter_rank#define().filter(
          \   {'candidates' : copy(g:candidates), 'input' : '' })
    echomsg reltimestr(reltime(g:start))

    ShouldEqual sort(copy(candidates), 'CompareRank'),
          \ neocomplete#filters#sorter_rank#define().filter(
          \   {'candidates' : copy(g:candidates), 'input' : '' })
  End

  It tests fuzzy matcher.
    ShouldEqual neocomplete#filters#matcher_fuzzy#define().filter(
          \ {'complete_str' : 'ae', 'candidates' : ['~/~']}), []
  End

  It tests overlap.
    ShouldEqual neocomplete#filters#converter_remove_overlap#
          \length('foo bar', 'bar baz'), 3
    ShouldEqual neocomplete#filters#converter_remove_overlap#
          \length('foobar', 'barbaz'), 3
    ShouldEqual neocomplete#filters#converter_remove_overlap#
          \length('foob', 'baz'), 1
    ShouldEqual neocomplete#filters#converter_remove_overlap#
          \length('foobar', 'foobar'), 6
  End
End

Fin

" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}

" vim:foldmethod=marker:fen:
