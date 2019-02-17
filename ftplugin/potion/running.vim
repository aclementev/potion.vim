if !exists("g:potion_command")
    let g:potion_command = "potion"
endif

function! PotionCompileAndRunFile()
    " Save the current file
    write
    silent !clear
    execute "!" . g:potion_command . " " . bufname("%")
endfunction

function! PotionShowBytecode()
    " Save the current file
    write
    " Get the bytecode
    let bytecode = system(g:potion_command . " -c -V " . bufname("%"))
    if bytecode =~? '\vSyntax error'
        echom "Syntax error"
        return
    endif
    " Check if a potionbytecode buffer already exists
    let potionbuffernr = bufwinnr("__Potion_Bytecode__")
    if potionbuffernr == -1
        " Open a new split and set it up
        vsplit __Potion_Bytecode__
    else
        " Open the potionbytecode buffer
        execute potionbuffernr . "wincmd w"
    endif
    normal! ggdG
    setlocal filetype=potionbytecode
    setlocal buftype=nofile

    " Insert the bytecode
    call append(0, split(bytecode, '\v\n'))
endfunction

nnoremap <buffer> <localleader>r :call PotionCompileAndRunFile()<CR>
nnoremap <buffer> <localleader>b :call PotionShowBytecode()<CR>
