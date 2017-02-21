"nnoremap <Leader>vimgit :call vimgit#Load()<CR> 

function! vimgit#Init()
endfunction

function! vimgit#Load()
    " new tab
    tabnew __vimgit__
    setlocal buftype=nofile
    setlocal filetype=gitbuf_status
    setlocal nofoldenable 
    call vimgit#Status()
endfunction

function! vimgit#Status()
    setlocal modifiable
    "clear
    normal! ggdG
    "draw
    let line_num = 0
    for line in split( system( "git status" ), '\v\n' )
        call append( line_num, line )
        if line ==? b:vimgit_cursor_ref_line
            call cursor( line_num, 0 )
        endif
        let line_num = line_num + 1
    endfor
    "call append( 0, split( system( "git status" ), '\v\n' ) )
    "not allow editable
    setlocal nomodifiable

endfunction

function! vimgit#Log()
    " open left side window
    " check bufname
    if bufname( "%" ) ==? __vimgit__
        return
    endif
    " clear buf
    " draw buf
endfunction

function! vimgit#Add( file )
    only!
    call system( "git add " . a:file )
    call vimgit#Status()
endfunction

function! vimgit#Reset( file )
    only!
    call system( "git reset HEAD " . a:file )
    call vimgit#Status()
endfunction

function! vimgit#Diff( file )
    if bufexists( "__vimgit_diff__" ) > 0
        "normal! <CTRL>W w
        execute bufwinnr("__vimgit_diff__")."wincmd w"
    else
        vertical rightb split __vimgit_diff__
    endif
    setlocal buftype=nofile
    setlocal filetype=gitbuf_diff
    setlocal nofoldenable 
    let b:vimgit_diff_file = a:file

    set modifiable
    normal! ggdG
    call append( 0, split( system( "git diff " . b:vimgit_diff_file ), '\v\n' ) )
    normal! gg
    set nomodifiable
endfunction

function! vimgit#Commit()
endfunction

function! vimgit#Push()
endfunction

function! vimgit#Pull()
    set modifiable
    normal! ggdG
    call append( 0, split( system( "git pull" ), '\v\n' ) )
    normal! gg
    set nomodifiable
endfunction

function! vimgit#Stash()
endfunction


function! vimgit#LeaderEnter()
    let _file_str          = getline( "." )
    let _file_str_list     = split( _file_str, ":" )
    let _file_str_list_len = len( _file_str_list )

    if _file_str_list_len == 0
        return
    elseif _file_str_list_len == 1

        call vimgit#RecordCursorPos( getcmdpos() )
        call vimgit#Add( _file_str_list[0] )
    elseif _file_str_list_len > 1

        "echo [_file_str_list[0], strlen(_file_str_list[0])]
        "return
        if stridx( _file_str_list[0], 'modified' ) == 1

            call vimgit#RecordCursorPos( getcmdpos() )
            call vimgit#Diff( strpart( _file_str, 13 ) )
        elseif stridx( _file_str_list[0], 'new file' ) == 1

            call vimgit#RecordCursorPos( getcmdpos() )
            call vimgit#Reset( strpart( _file_str, 13 ) )
        endif

    endif

endfunction

function! vimgit#RecordCursorPos( line_num )
    let line_num_pre = a:line_num - 1
    if line_num_pre < 0
        return
    endif

    let b:vimgit_cursor_ref_line = getline( line_num_pre )

endfunction

function! vimgit#Info()
    echo b:vimgit_info
endfunction
