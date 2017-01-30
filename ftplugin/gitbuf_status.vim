" prevent reload
if exists( "b:gitbuf_ftplugin" )
    finish
endif
let b:gitbuf_ftplugin = 1

let b:vimgit_info = { '_version': '0.1', '_vim_version': '', '_git_version': '', '_project': '', '_current_file': '' }
"let b:vimgit_untracked_files = []
"let b:vimgit_modified_files = []
let b:vimgit_cursor_ref_line = ""

" bind event
nnoremap <buffer> <Cr> :call vimgit#LeaderEnter()<Cr>h 
