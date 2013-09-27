if exists('g:loaded_clever_split')
    finish
endif

command! -nargs=* CleverHSplit call clever_split#split(<q-args>)
command! -nargs=* CleverVSplit call clever_split#vsplit(<q-args>)
command! -nargs=* CleverSplit call clever_split#clever_split(<q-args>)

if exists('g:clever_split#overwrite_default_mappings')
    nnoremap <silent><C-w>s :<C-u>CleverHSplit<CR>
    nnoremap <silent><C-w>v :<C-u>CleverVSplit<CR>
    nnoremap <silent><C-w><Leader> :<C-u>CleverSplit<CR>
endif

let g:loaded_clever_split = 1