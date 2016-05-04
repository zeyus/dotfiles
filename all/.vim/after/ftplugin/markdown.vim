" Mappings for headings
nnoremap <buffer> <leader>h1 Yp<c-v>$r=
nnoremap <buffer> <leader>h2 Yp<c-v>$r-

" Complete checklist item
nnoremap <buffer> <silent> <leader>x :s/\v(\s*- \[) \]/\1x]<cr>:noh<cr>
