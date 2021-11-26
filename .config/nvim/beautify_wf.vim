
" [[---------------------------------------Theme Settings    主题设置



set background=light
if !exists('g:vscode')
    colorscheme PaperColor
endif

if &diff
    " colorscheme PaperColor  " 默认就和 if &diff外设置的主题一致
    set cursorline
    " 反应变慢，不好
    " map ] ]c
    " map [ [c

    " hi DiffAdd    guifg=#003300 guibg=#DDFFDD gui=none
    " hi DiffChange guibg=#ececec gui=none
    " hi DiffText   guifg=#000033 guibg=#DDDDFF gui=none
endif

autocmd BufWritePost * if &diff == 1 | diffupdate | endif


set cursorline
hi CursorLine guibg=#bbddcc
" hi Cursor guibg=#0000cc  " 似乎被mobaxterm控制着

" 古老：For terminal Vim, with colors, we're most interested in the cterm
" 支持真彩色 true color
set termguicolors   " true (24-bit) colours. 下面改颜色只用改 guibg guifg
hi Search guibg=#ffffff guifg=#00aeae  " 放文件前部分不行


"  ---------------------------------------------------------------------《《《底栏--]]
" let g:airline_theme     = 'papercolor'
" let g:airline_section_b = ''
" let g:airline_section_c = ''
" let g:airline_section_gutter = ''
" let g:airline_section_x = ''
" let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
" let g:airline_section_y       (fileencoding, fileformat, 'bom', 'eol')
" let g:airline_section_z=      (percentage, line number, column number)
" let g:airline_section_error   (ycm_error_count, syntastic-err, eclim,  languageclient_error_count)
" let g:airline_section_warning (ycm_warning_count, syntastic-warn,  languageclient_warning_count, whitespace)
"  ---------------------------------------------------------------------《《《底栏--]]



let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1  " 被下面的代替了
" 不生效
" set guicursor=n-v-c:block,
"             \i-ci-ve:ver25,
"             \r-cr:hor20,
"             \o:hor50
"             \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
"             \,sm:block-blinkwait175-blinkoff150-blinkon175

syntax enable


highlight OperatorSandwichBuns guifg='#aa91a0' gui=underline ctermfg=172 cterm=underline
highlight OperatorSandwichChange guifg='#edc41f' gui=underline ctermfg='yellow' cterm=underline
highlight OperatorSandwichAdd guibg='#b1fa87' gui=none ctermbg='green' cterm=none
highlight OperatorSandwichDelete guibg='#cf5963' gui=none ctermbg='red' cterm=none


" 防止tmux下vim的背景色显示异常
" http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color'
    set t_ut=
endif
" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.




" Todo
" 设置可以高亮的关键字
if has("autocmd")
    " Highlight TODO, FIXME, NOTE, etc.
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(todo\|FIXME\|CHANGED\|DONE\|Todo\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
endif
