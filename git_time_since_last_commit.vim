if exists('g:git_time_since_last_commit_loaded')
    " finish
endif
let g:git_time_since_last_commit_loaded = 1

function! Check_time_since_last_commit()
    hi! RedBar ctermfg=white ctermbg=red

    let l:now = system("date +%s")
    let l:last_commit = system("git log --pretty=format:%at -1 2> /dev/null || date +%s")

    let l:commit_time = l:now - l:last_commit

    if l:commit_time > 300
        echohl RedBar
        echo "WARNING! Last git commit was made [".l:commit_time."] seconds ago!"
        echohl None
    endif
endfunction
