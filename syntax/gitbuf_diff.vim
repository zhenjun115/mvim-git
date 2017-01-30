if exists("b:current_syntax")
    finish
endif

syntax keyword vimgitKeyword git add 
syntax keyword vimgitKeyword git reset 
syntax keyword vimgitKeyword git diff 
syntax keyword vimgitKeyword git checkout 

syntax match vimgitKeyword "^\v\+"
syntax match vimgitKeyword "^\v-"

highlight link vimgitKeyword Keyword

let b:current_syntax = "vimgit_diff"
