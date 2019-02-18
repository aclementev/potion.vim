if !exists("g:potion_command")
    let g:potion_command = "potion"
endif

" This is a bad idea! Just a PoC
function! PotionForceAutoload()
    " Calling silently to an knowiningly inexistent function
    silent! call #potion#running#InexistentFunction()
    echom "Forcing autoload..."
endfunction

nnoremap <buffer> <localleader>r :call potion#running#PotionCompileAndRunFile()<CR>
nnoremap <buffer> <localleader>b :call potion#running#PotionShowBytecode()<CR>
