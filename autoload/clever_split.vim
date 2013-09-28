function! clever_split#split(...)
    execute 'split' join(a:000, ' ')
    call clever_split#resize_winwidth()
endfunction

function! clever_split#vsplit(...)
    execute 'vsplit' join(a:000, ' ')
    call clever_split#resize_winwidth()
endfunction

function! clever_split#clever_split(...)
    if winwidth(0) < get(g:, 'clever_split#winwidth_limit', 0)
        execute 'tabnew' join(a:000, ' ')
    endif
    if winwidth(0) > winheight(0) * get(g:, 'clever_split#width_height_rate', 2)
        call clever_split#vsplit(join(a:000, ' '))
    else
        call clever_split#split(join(a:000, ' '))
    endif
endfunction

function! clever_split#resize_winwidth()
    let max_col = 0
    for lnum in range(1, line('$'))
        let len = len(getline(lnum))
        if len > winwidth(0) | return | endif
        if max_col < len | let max_col = len | endif
    endfor
    execute 'vertical resize' max_col
endfunction

function! clever_split#resize_winwidth_by_current_screen()
    let pos_save = getpos('.')
    let scrolloff_save = &scrolloff
    try
        set scrolloff=0
        normal! L
        let stop = line('.')
        normal! H
        let max_col = 0
        while line('.') <= stop
            let len = len(getline('.'))
            if max_col < len
                let max_col = len
            endif
        endwhile
        execute 'vertical resize' max_col
    finally
        call setpos('.', pos_save)
        let &scrolloff = scrolloff_save
    endtry
endfunction

function! clever_split#help(...)
    let args = join(a:000, ' ')

    if winwidth(0) > winheight(0) * get(g:, 'clever_split#width_height_rate', 2)
        execute 'vertical topleft help ' . args
    else
        execute 'aboveleft help ' . args
    endif

    if winwidth(0) < 80
        quit
        execute 'tab help ' . args
    else
        call clever_split#resize_winwidth()
    endif
endfunction
