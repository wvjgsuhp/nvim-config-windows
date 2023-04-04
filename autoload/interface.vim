function! interface#toggleTerminal()
  wincmd k
  if utils#isTerminal()
    return
  endif

  wincmd j
  if utils#isTerminal()
    quit
    return
  endif

  split
  wincmd j
  resize 13

  for buffer_ in getbufinfo({'buflisted': 1})
    if utils#startsWith(buffer_.name, 'term://')
      execute 'b ' . buffer_.name
      startinsert
      return
    endif
  endfor

  term
  startinsert
endfunction
