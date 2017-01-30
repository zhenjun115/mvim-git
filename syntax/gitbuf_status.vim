if exists("b:current_syntax")
    finish
endif

syntax keyword vimgitKeyword git add 
syntax keyword vimgitKeyword git reset 
syntax keyword vimgitKeyword git diff 
syntax keyword vimgitKeyword git checkout 

highlight link vimgitKeyword Keyword

let b:current_syntax = "vimgit_status"
