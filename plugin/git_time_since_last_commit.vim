if exists('g:git_time_since_last_commit_loaded')
    " finish
endif
let g:git_time_since_last_commit_loaded = 1

function! Check_time_since_last_commit()
    hi! RedBar ctermfg=black ctermbg=red

    let l:now = system("date +%s")
    let l:last_commit = system("git log --pretty=format:%at -1 2> /dev/null || date +%s")

    let l:commit_time = l:now - l:last_commit

    if l:commit_time > 900
        while s:ShowError(commit_time) ==? 0
        endwhile
    endif

endfunction

function! s:ShowError(commit_time)
    echohl RedBar
    echo "WARNING! Last git commit was made [".a:commit_time."] seconds ago!"
    echohl None

    let l:num = reltime()[1]%10

    echo "Enter number ".l:num.": "

    let l:input = getchar() - 48
    if l:input ==? l:num
        return 1
    else
        return 0
    endif
endfunction

command! CheckTimeSinceLastCommit :call Check_time_since_last_commit()
