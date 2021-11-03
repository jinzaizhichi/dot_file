echo "vscode-nvim用的是wsl下的dot_file的init.vim"
" 这样可以 不那么死板地 只能用~/AppData/Local/nvim/init.vim来进入windows的nvim, 从而管理插件(
    " windows的nvim和vscode的nvim共用): 
"nvim -u '\\wsl$\Ubuntu\root\dot_file\.config\nvim\init.vim'
" 插件位置:
" C:\Users\noway\AppData\Local\nvim-data
" 把wsl下的dotfile发送快捷方式到 ~/AppData/Local/nvim/init.vim , 不行.因为shortcut和软链接还不一样
" https://superuser.com/questions/253935/what-is-the-difference-between-symbolic-link-and-shortcut

" todo:  有些粘贴来的配置，应该要清理掉

" Return to last edit position when opening files 
" 有bug: autocmd BufReadPost * normal! g`"zv
"  normal! 表示 Execute Normal mode commands,   If the [!] is given, mappings will not be used.
"  g`"表示 跳到 the last known position in a file
"  zv 取消折叠光标所在行
" 如果: the file is truncated outside of vim, and vim's mark is on a line that no longer exists, vim throws an error. Fixed that with:
" autocmd BufReadPost * silent! normal! g`"zv
" 或者:
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"zv" |
     \ endif

if has('win32')
    " echo 'leo: 正在用win32，win32表示 32 or 64 bit的windows'
    let g:python3_host_prog = "F:\\python39\\python.exe"  " ToggleBool会用到
    " let g:python_host_prog = ""  " ToggleBool会用到   我fork了这个插件 并改了?
    " let g:loaded_python_provider = 0
endif


func! TabToSpace()
    " vscode 有个插件：takumii.tabspace
    set ts=4 | set expandtab | %retab! | echo" Tab变成4空格"
endfunc
" autocmd对neovim-vscode无效？ 暂时手动敲吧
autocmd BufNewFile,BufRead *.py  exec ":call TabToSpace()"


if exists('g:vscode')
    " set MYVIMRC = "C:\Users\noway\AppData\Local\nvim\init.vim"
    highlight OperatorSandwichBuns guifg='#aa91a0' gui=underline ctermfg=172 cterm=underline
    highlight OperatorSandwichChange guifg='#edc41f' gui=underline ctermfg='yellow' cterm=underline
    highlight OperatorSandwichAdd guibg='#b1fa87' gui=none ctermbg='green' cterm=none
    highlight OperatorSandwichDelete guibg='#cf5963' gui=none ctermbg='red' cterm=none

    " todo
    " insert mode下，neovim不管事，（但esc退回normal还是可以的），imap都用不了
    " nnoremap gd vaw<F12>
    unmap gd
    " 不行
    " nnoremap zz ZZ
    "echo 'wf: using vscode-neovim '
else
    echo '没在用 vscode-neovim, only nvim'
    " 有些内容可能可以复制到vscode-nvim中用
    
    nnoremap <F8> :call HideNumber()<CR>  " 8 for byebye number
    function! HideNumber()
        if(&relativenumber == &number)
            set relativenumber! number!
        elseif(&number)
            set number!
        else
            set relativenumber!
        endif
        set number?
    endfunc

    set wrap    " vscode里设置了不wrap

    "set wrap 后，同物理行上线直接跳。vscode中不行
    nnoremap k gk
    nnoremap gk k

    nnoremap j gj
    nnoremap gj j

    nnoremap <F4> :UndotreeToggle<CR>
    " [[==============================缩进==============================
    " vscode上有插件自动处理，不用加这些:
    "
    " filetype 和 setlocal 一般成对出现？
    " autocmd Filetype python setlocal et sta sw=4 sts=4
    " Put them in vimfiles/ftplugin/python.vim (but change set to setlocal) and add filetype plugin on to .vimrc.

    filetype on        " 检测文件类型
    filetype indent on " 针对不同的文件类型采用不同的缩进格式
    filetype plugin on " a file's plugin file is loaded (if there is one for the detected filetype).
    filetype plugin indent on  " 启动自动补全 

    set expandtab " 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
    set tabstop=4 " 设置Tab键等同的空格数

    set shiftwidth=4 " 每一次缩进对应的空格数

    set smarttab " insert tabs on the start of a line according to shiftwidth
    set shiftround " 用shiftwidth的整数倍， when indenting with '<' and '>'

    set softtabstop=4 " 按退格键时可以一次删掉 4 个空格

    " 如果要仅对python有效：
    " autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab shiftround

    set smartindent
    " `各种indent方法`
    " 只是对c语言家族而言？
    " 'autoindent'	uses the indent from the previous line.
    " 'smartindent'	is like 'autoindent' but also recognizes some C syntax to
    "                 increase/reduce the indent where appropriate.
    " 'cindent'	Works more cleverly than the other two and is configurable to
    "             different indenting styles.
    " 'indentexpr'	The most flexible of all: Evaluates an expression to compute
    " 		the indent of a line.  When non-empty this method overrides
    " 		the other ones.  See |indent-expression|.
    " set cindent
    
    func! Indent_wf()
        set ts=2 | set noexpandtab | %retab! | set ts=4 | set expandtab | %retab! | echo"Indent 2缩进变4"
    endfunc
    nnoremap <F10> :call Indent_wf()<CR>
    inoremap <F10> <ESC>:call Indent_wf()<CR>i
    " 遇到保存了tab作为缩进的文件，可以替换：
    " %s/\t/    /g
    " %retab中的%：表示在全文中

    " 考虑用谷歌的规范？ setlocal indentexpr=GetGooglePythonIndent(v:lnum)
    " https://github.com/google/styleguide/blob/gh-pages/google_python_style.vim

    " ==============================缩进==============================]]

    noremap <silent><leader>/ :nohls<CR> " 搜索时 不高亮
    " vscode里不行
    " nnoremap zz :wq<C-R>
    " inoremap zz <ESC>:wq<CR>
    " cnoremap q1 q!
    " Quickly close the current window
    " nnoremap <leader>q :q<CR>
    " Quickly save the current file
    " nnoremap <leader>w :w<CR>

    " 使用方向键切换buffer 。 vscode的map，别用command mode ?
    nnoremap <C-I> :bprevious<CR>
    noremap <left> :bp<CR>  " 和ctrl O 一样
    noremap <right> :bn<CR>

    " 保存python文件时删除多余空格
    fun! <SID>StripTrailingWhitespaces()
            let l = line(".")
            let c = col(".")
            %s/\s\+$//e
            call cursor(l, c)
    endfun
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,vimrc autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

    let g:airline_theme='solarized'
    if &diff
        " colorscheme github
        set cursorline

        " 反应变慢，不好
        " map ] ]c
        " map [ [c

        hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
        hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
        hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
    endif

    " 要在设定颜色主题后面，覆盖颜色主题里面的设置
    highlight  Search cterm=NONE ctermfg=white ctermbg=gray

endif

nnoremap yf ggyG<C-O>
" p后面一般没有参数，所以pf不好。选中全文，一般只是为了替换。所以vf选中后，多了p这一步
nnoremap vf ggVGp
" comment at the end of line
nnoremap ce A<space><space>#<space>

" vscode里失灵了:
" inoremap yf <Esc>ggyG<C-O>"

let mapleader =" "     
" https://stackoverflow.com/questions/54787831/map-space-to-leader-in-vim


" Lazy loading, my preferred way, as you can have both [避免被PlugClean删除没启动的插件] 
" https://github.com/junegunn/vim-plug/wiki/tips
" leo改过
function! VimPlugConds(arg1, ...)

    " a: 表示argument
    " You must prefix a parameter name with "a:" (argument).
        " a:0  等于 len(a:000)), 
        " a:1 first unnamed parameters, and so on.  `a:1` is the same as "a:000[0]".
    " A function cannot change a parameter
    
            " To avoid an error for an invalid index use the get() function
            " get(list, idx, default)
    let leo_opts = get(a:000, 0, {})  "  a:000 (list of all parameters), 获得该list的第一个元素
    " Borrowed from the C language is the conditional expression:
    " a ? b : c
    " If "a" evaluates to true "b" is used
    let out = (a:arg1 ? leo_opts : extend(leo_opts, { 'on': [], 'for': [] }))  " 括号不能换行
    " an empty `on` or `for` option : plugin is registered but not loaded by default depending on the condition.
    return  out
endfunction



" =============================================vim-plug===============================begin
call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/vim-plug' " 为了能用:help plug-options


" [[==============================easymotion 配置=====================begin

" Plug 'asvetliakov/vim-easymotion'   " 不用裸nvim下的easymotion
" Plug 'easymotion/vim-easymotion'    " 只用裸nvim下的easymotion  千万别这么干。会把正在编辑的文件全搞乱

" Plug 'easymotion/vim-easymotion', VimPlugConds(!exists('g:vscode'))  " exists(): 变量存在，则返回TRUE，否则0
Plug 'asvetliakov/vim-easymotion', VimPlugConds(exists('g:vscode'), { 'as': 'leo-jump' })  " as的名字随便起，
                                                                                        " 下面map时，还是 nmap s <Plug>(easymotion-f2)之类的

" 这样可能更容易理解，没那么绕: 【an empty `on` or `for` option : plugin is registered but not loaded by default depending on the condition.】
" Plug 'easymotion/vim-easymotion',  has('g:vscode') ? { as': 'ori-easymotion', 'on': [] } : {}
" Plug 'asvetliakov/vim-easymotion', has('g:vscode') ? {} : { 'on': [] }

map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " 敲小写，能匹配大写。反之不然

" Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" todo  debug buggy 出了问题来这里
"s for search 
nmap s <Plug>(easymotion-f)
" Need one more keystroke
nmap f <Plug>(easymotion-f2)

" 会抽风颤抖
" nmap f <Plug>(easymotion-f) "f{char}
" map  <Leader>f <Plug>(easymotion-bd-f) " <Leader>f{char} to move to {char}
" unmap f  " umap后，变回默然的功能

" 会显示高亮字母后，光标到下一行
" nmap s <Plug>(easymotion-f2) " {char}{char} 怎样可以上下文都搜索？现在只能搜下文
" map  <Leader>w <Plug>(easymotion-w) " Move to word    " buftype option is set??
" ================================easymotion 配置=====================]]

Plug 'machakann/vim-sandwich'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'sagarrakshe/toggle-bool'
noremap <leader>r :ToggleBool<CR>
" nnoremap <F2> cawTrue<ESC>
" nnoremap <F3> cawFalse<ESC>

Plug 'mbbill/undotree'
if has("persistent_undo")
    let target_path = expand('~/.undodir')
    if !isdirectory(target_path) " if the location does not exist.
        call mkdir(target_path, "p", 0700) " create the directory and any parent directories
    endif

    let &undodir=target_path
    set undofile
endif


" 同类:
"  Plug 'tpope/vim-surround'
"  Plug 'kana/vim-textobj-user'
"  Plug 'sgur/vim-textobj-parameter'

"  Plug 'tpope/vim-repeat'
"  Plug 'chaoren/vim-wordmotion'
"  Plug 'kkoomen/vim-doge'
"  Plug 'mattn/emmet-vim'
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

call plug#end()
" 用了vim-pug, 会自动 `filetype plugin indent on` and `syntax enable`?
" =============================================vim-plug===============================end



" [[----------------------------nerdcommenter-config-------------------------------begin
" g代表Global Variable
let g:NERDCreateDefaultMappings = 0    " 别用默认的键位

let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters
let g:NERDCompactSexyComs = 1 " Use compact syntax for  multi-line comments
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/*','right': '*/' } }
let g:NERDCommentEmptyLines = 1  " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1 " check all selected lines is commented or not

" 对vscode无效,不知道为啥
" <C-/> 在vim中由C-_表示
nnoremap <C-_> :call nerdcommenter#Comment('n', 'toggle')<CR>j
inoremap <C-_> <ESC>:call nerdcommenter#Comment('n', 'toggle')<CR>j
vnoremap <C-_> :call nerdcommenter#Comment('n', 'toggle')<CR>
" 哪里map了<leader>cc ?

nnoremap <M-/> yy:call nerdcommenter#Comment('n', 'toggle')<CR>p


" 好慢：
" nnoremap = :<plug>nerdcommentertoggle<cr>j
" nnoremap - :k<plug>nerdcommentertoggle<cr>
" 这行不行:
" nnoremap = :call <Plug>NERDCommenterInvert<CR>

"let g:NERDDefaultNesting = 1
" ---------------------------nerdcommenter-config----------------------------------end]]


" todo: vscode中会复制了 前后空格
nnoremap vp vawp

nnoremap v' vi'
nnoremap v" vi"
nnoremap v( vi(
nnoremap v) vi)
nnoremap v[ vi[
nnoremap v] vi]
nnoremap v{ vi{
nnoremap v} vi}
nnoremap v} vi}


nnoremap yp yyp
nnoremap yw yaw
nnoremap y' yi'
nnoremap y" yi"
nnoremap y( yi(
nnoremap y) yi)
nnoremap y[ yi[
nnoremap y] yi]
nnoremap y{ yi{
nnoremap y} yi}

nnoremap cw caw
nnoremap c' ci'
nnoremap c" ci"
nnoremap c( ci(
nnoremap c) ci)
nnoremap c[ ci[
nnoremap c] ci]
nnoremap c{ ci{
nnoremap c} ci}

nnoremap dw daw
nnoremap d' da'
nnoremap d" da"
nnoremap d( da(
nnoremap d) da)
nnoremap d[ da[
nnoremap d] da]
nnoremap d{ da{
nnoremap d} da}

"====https://github.com/ahonn/dotfiles/tree/master/vim/vscode================start
nnoremap < <<
nnoremap > >>
vnoremap < <gv



noremap H ^
noremap L $

noremap K r<CR><UP>
nnoremap J Ji <Esc>

set pastetoggle=<F9>

"有空再搞

"nnoremap <silent> <C-j> :<C-u>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
"nnoremap <silent> <C-k> :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
"nnoremap <silent> <C-h> :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
"nnoremap <silent> <C-l> :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

"nnoremap <silent> <C-b> :<C-u>call VSCodeNotify('workbench.action.toggleSidebarVisibility')

"nnoremap <silent> <C-w>H :<C-u>call VSCodeNotify('workbench.action.moveEditorToLeftGroup');<CR>
"nnoremap <silent> <C-w>L :<C-u>call VSCodeNotify('workbench.action.moveEditorToRightGroup');<CR>

"nnoremap <silent> <Leader>f :<C-u>call VSCodeNotify('editor.action.formatDocument')<CR>
"


"nnoremap <silent> <Leader>pi :PlugInstall<Cr>
"nnoremap <silent> <Leader>pc :PlugClean<Cr>
"nnoremap <silent> <Leader>pu :PlugUpdate<Cr>


"" vim-surround
"nmap <silent> , ysiw
"let g:surround_35 = "#{\r}"
"let g:surround_36 = "${\r}"


"" vim-textobj-parameter
"let g:vim_textobj_parameter_mapping = 'a'

"" vim-doge
"let g:doge_mapping = '<Leader>dc'


"====https://github.com/ahonn/dotfiles/tree/master/vim/vscode================end



" nnoremap  J j
" c b means: comment block

" block模式
" As far as Vim is concerned, <C-M> and <CR> 一样
" <C-q>用不了，可能是kite占用了  [好像又能用了]
" 记忆：c for block c发音:ke
nnoremap <C-c> <C-v>
inoremap <C-c> <C-v>

" pressing  Ctrl[   will usually get you the equivalent of pressing Esc.
" *i_CTRL-V*
" CTRL-V	Insert next non-digit `literally`.  For special keys, the
"         terminal code is inserted.  
"         The characters typed right after CTRL-V are not considered for
"         mapping.
"
" *i_CTRL-Q*
" CTRL-Q		Same as CTRL-V.



" 这两个都不行， airblade/vim-rooter也不行了
" :lcd吧
" set autochdir
" autocmd BufEnter * silent! lcd %:p:h
autocmd VimEnter * set autochdir


" 数字加15
nnoremap <C-k> <C-a>
inoremap <C-a> <ESC>I
nnoremap <C-a> ^h

noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" 有个自动补全插件 导致(变成选中候选，只能这样map
inoremap ( (

set completeopt=noinsert,menuone


let g:spacevim_force_global_config = 0
" let g:spacevim_snippet_engine = 'ultisnips'

" disable neosnippet to avoid conflict with UltiSnips
let g:spacevim_disabled_plugins=[ ['Shougo/neosnippet.vim'], ]
" custom plugin
" let g:neosnippet#snippets_directory = '~/.SpaceVim.d/snippets'

" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<C-m>"
" let g:UltiSnipsJumpBackwardTrigger="<C-.>"
""" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"


inoremap _pp print()<ESC>i
" 不行
" vnoremap _p :call Wfprint_v()<CR>
vnoremap _p :yoprint('看:') <ESC>hhhhpoprint()<ESC>hp

nnoremap _p :call Wfprint_n()<CR>
func! Wfprint_n()
        if &filetype == 'python'
            exec "normal yawoprint('看: ')" | exec "normal hhhhp" | exec "normal oprint()"  | exec "normal hp"
        elseif &filetype == 'cpp'
            exec 'normal yawocout<<""<<'| exec 'normal hhhpf<lpa<<endl;'
        elseif &filetype == 'sh'
        endif
endfunc


" 还不能用
func! Wfprint_v()
        if &filetype == 'python'
            exec "y" | exec "normal oprint('看: ')" | exec "normal hhhhp" | exec "normal oprint()"  | exec "normal hp"
        elseif &filetype == 'cpp'
            exec 'visual yocout<<""<<'| exec 'normal hhhpf<lpa<<endl;'
        elseif &filetype == 'sh'
        endif
endfunc



" <bar> : 表示 '|' ,  to separate commands, cannot use it directly in a mapping, since it would be seen as marking the end of the mapping.
" 百分号代表当前文件
" bash 的  &&  是前面的命令成功了，继续执行后面的
" autocmd filetype cpp nnoremap <C-c> :w <bar> !clear && g++ -std=gnu++14 -O2 % -o %:p:h/%:t:r.exe && ./%:r.exe<CR>

set autowrite

" mswin.vim会导致visual mode 光标所在字符不被选中
" source ~/dot_file/mswin.vim
" ---------------------------------------msvim-------------------------------
"其他地方实现了。
"Use the + register (clipboard) :   "+g
"gP : paste before the current position, placing the cursor after the new text.
"nnoremap <C-V> "+gP


" Use CTRL-S for saving,
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" CTRL-Z is Undo
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat)
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" ---------------------------------------msvim-------------------------------

autocmd BufWritePost * if &diff == 1 | diffupdate | endif
if &diff
    colorscheme one
    set cursorline
    " 反应变慢，不好
    " map ] ]c
    " map [ [c
    " hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
    " hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
    " hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
endif


noremap <F5> <ESC>oimport pudb<ESC>opu.db
" 不指定模式，只在normal中生效，insert moed不生效
inoremap <F5> <ESC>oimport pudb<ESC>opu.db

set clipboard+=unnamedplus
" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
        if &filetype == 'sh'
                call setline(1, "\#!/bin/zsh")
        endif

        if &filetype == 'python'
                " google Python风格规范
                " 不要在行尾加分号, 也不要用分号将两条命令放在同一行。
                " 但不会报错
                call append(2, 'from dot_file.wf_snippet import *')
                call append(2, 'sys.path.append(wf_home)')
                call append(2, 'wf_home = os.path.expanduser("~/")')
                call append(2, 'import cv2 as cv; import numpy as np ; import json ; import sys; import os')
                call append(2, '#-----------------------------^_^------------------------#')


                " call append(2, '    ')
                " call append(2, '    print(round(wf_str,2))')
                " call append(2, '    if type(wf_variable) ==r ')
                " call append(2, 'def xprint(wf_variable):')
                " 括号内部不能换行
        endif

        normal G
        normal o
        normal o
endfunc

" 全文替换
" 分隔符#可以换成 / _        You can use most non-alphanumeric characters (but not \, " or |)
"% for the whole file. Example: :%s/foo/bar/g.
" .,$ from the current line to the end of the file.
" nnoremap <TAB> :%s#\<\>##gc<Left><Left><Left><Left><Left><Left><C-R><C-W><Right><Right><Right><C-R><C-W>
nnoremap <TAB> :.,$s#\<\>##gc<Left><Left><Left><Left><Left><Left><C-R><C-W><Right><Right><Right><C-R><C-W><Left><Left>


" 不在下面加这行，<C-i>会等效于TAB  Ctrl-p用不了
" noremap <C-z> <C-i>

" vim中:map看现在的绑定, 能看到spacevim的


" kite捣乱：
" inoremap <C-E> o<BS>
nnoremap <C-E> $


" 用不了

nnoremap gd g<C-]>
" nnoremap gd :KiteGotoDefinition<CR>

inoremap <C-F> <C-X><C-F>

" if 1
    " echo ' wf初始化的文件: ~/dot_file/vimrc'
" endif
" nvim中不了<HOME> <END>    $行末 ^行首 结合autohotkey


" <Plug>NERDCommenterToggle<CR>和 :call NERDComment('n', 'toggle')<CR> 应该一样
nnoremap = :call nerdcommenter#Comment('n', 'toggle')<CR>j
nnoremap - :call nerdcommenter#Comment('n', 'toggle')<CR>k

" 这行 不行:
" nnoremap = :call <Plug>NERDCommenterInvert<CR>


" 按一次z要等一会才退出， 不如连续按2次快
" nnoremap q :wq<CR>
" nnoremap qq :wq<CR>
" inoremap qq <ESC>:wq<CR>



" 重复了
" autocmd filetype python nnoremap <C-c> :w <bar> !python % <CR>

" Quickly Run
cnoremap <F1> call WfRunScript()<CR>
inoremap <F1> <ESC>:call WfRunScript()<CR>
nnoremap <F1> :call WfRunScript()<CR>
func! WfRunScript()
    exec "w"
    echo"wf_已保存"
    if &filetype == 'python'
        "跑votenet的某个文件时,若这样执行,pc_util.write_ply没被调用; 若正常敲python执行,则正常
        "% 代表当前文件
        exec "! python %"
    elseif &filetype == 'sh'
        exec "! zsh %"
    elseif &filetype == 'cpp'
        exec " ! rm -f /d/script.wf_cpp; g++ -std=c++11 % -Wall -g -o /d/script.wf_cpp `pkg-config --cflags --libs opencv` ; /d/script.wf_cpp "
    endif
endfunc




" 让配置变更立即生效
" 有变化, 但spacevim在捣乱 , 但各种报错
" autocmd! bufwritepost vimrc source $MYVIMRC| echo '改了nvim配置'

autocmd! bufwritepost .vimrc source %

" CapsLock 识别不了
" map <CapsLock>[ #
" map <CapsLock>] *

let g:ackprg = 'ag --vimgrep'


set cmdheight=2
set fdm=indent

" todo
" set termguicolors   " Nvim emits true (24-bit) colours in the terminal, if 'termguicolors' is set.

set cursorline
" hi CursorLine cterm=NONE ctermbg=NONE
" hi Cursor cterm=inverse

" For terminal Vim, with colors, we're most interested in the cterm
" term=reverse is for B&W terminal, the gui ones are primarily for gvim.



if exists('$TMUX')
    autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
    autocmd VimLeave * call system("tmux rename-window zsh")
    " autocmd BufEnter,FocusGained * call system("tmux rename-window " . expand("%:t"))
    " autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
    set title
endif

set title
set mouse=a
syntax enable
set background=light

set nocompatible  " 别兼容老的vi
set backspace=indent,eol,start
" indent  allow backspacing over autoindent
" eol     allow backspacing over line breaks (join lines)
" start   allow backspacing over the start of insert; CTRL-W and CTRL-U stop once at the start of insert.


set history=2000
set timeoutlen=800

set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030


" <Leader>t 翻译光标下的文本，在命令行回显
" nmap <silent> <Leader>t <Plug>Translate
" vmap <silent> <Leader>t <Plug>TranslateV
" Leader>w 翻译光标下的文本，在窗口中显示
" nmap <silent> <Leader>w <Plug>TranslateW
" vmap <silent> <Leader>w <Plug>TranslateWV


"==========================================
" Author:  wklken
" Sections:
"               -> Initial Plugin 加载插件
"               -> General Settings 基础设置
"               -> Display Settings 展示/排版等界面格式设置
"               -> 文件编码设置
"               -> Others 其它配置
"               -> HotKey Settings  自定义快捷键
"               -> 针对文件类型的设置
"               -> Theme Settings  主题设置
"
"               -> 插件配置和具体设置在vimrc.bundles中

"==========================================
" Initial Plugin 加载插件
"==========================================


" 开启语法高亮
syntax on


" General Settings 基础设置

" history存储容量
set history=2000


" 文件修改之后自动载入
set autoread
" 启动的时候不显示那个援助乌干达儿童的提示
set shortmess=atI

" 备份,到另一个位置. 防止误删, 目前是取消备份
"set backup
"set backupext=.bak
"set backupdir=/tmp/vimbk/

" 取消备份。 视情况自己改
set nobackup
" 关闭交换文件
set noswapfile


" TODO: remove this, use gundo
" create undo file
" if has('persistent_undo')
    " " How many undos
    " set undolevels=1000
    " " number of lines to save for undo
    " set undoreload=10000
    " " So is persistent undo ...
    " "set undofile
    " set noundofile
    " " set undodir=/tmp/vimundo/
" endif


" 突出显示当前行
set cursorline


" 启用鼠标
set mouse=a
" Hide the mouse cursor while typing
set mousehide

" change the terminal's title
set title

" Remember info about open buffers on close
set viminfo^=%


"==========================================
" Display Settings 展示/排版等界面格式设置
"==========================================

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 没啥用，文字容易跑走
" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
" set scrolloff=7

" set winwidth=79


" set statusline=
" set statusline +=%<%f\ %h%m%r%{kite#statusline()}%=%-14.(%l,%c%V%)\ %P
" set statusline +=%1*\ %n\ %*                      "buffer number
" set statusline +=%5*%{&ff}%*                      "file format
" set statusline +=%3*%y%*                              "file type
" set statusline +=%4*\ %<%F%*                      "full path
" set statusline +=%2*%m%*                              "modified flag
" set statusline +=%1*%=%5l%*                           "current line
" set statusline +=%2*/%L%*                             "total lines
" set statusline +=%1*%4v\ %*                           "virtual column number
" set statusline +=%2*0x%04B\ %*                    "character under cursor


" set statusline +=%<%f\ %h%m%r%{kite#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2    " always display the status line


" 命令行（在状态行下）的高度，默认为1，这里是2
" set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P

" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=5


" Turn off search wrapping:
" set nowrapscan
" It'll give an error and stop at both the top and bottom of the buffer:
" E384: search hit TOP without match for: set
" E385: search hit BOTTOM without match for: set

set hlsearch " 高亮search命中的文本
set incsearch " 增量搜索模式,随着键入即时搜索
set ignorecase " 搜索时忽略大小写 , 但,
" 敲了大写字母时, 仍大小写敏感:
set smartcase

" 代码折叠
set foldenable
set foldmethod=indent  " 初步尝试, 缩进最好
set foldlevel=99


" nnoremap <F1> :set number! number?<CR>
" 开了这个, 按F 1还是去不掉相对行号, 除非进入insert mode
" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
" set relativenumber number
" au FocusLost * :set norelativenumber number
" au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
" autocmd InsertEnter * :set norelativenumber number
" autocmd InsertLeave * :set relativenumber
" function! NumberToggle()
    " if(&relativenumber == 1)
        " set norelativenumber number
    " else
        " set relativenumber
    " endif
" endfunc
" nnoremap <C-n> :call NumberToggle()<cr>

" 防止tmux下vim的背景色显示异常
" Refer: http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

"==========================================
" FileEncode Settings 文件编码,格式
"==========================================
" 设置新文件的编码为 UTF-8
set encoding=utf-8
" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,eu

" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
" Zoom / Restore window.
function! s:ZoomToggle() abort
        if exists('t:zoomed') && t:zoomed
                execute t:zoom_winrestcmd
                let t:zoomed = 0
        else
                let t:zoom_winrestcmd = winrestcmd()
                resize
                vertical resize
                let t:zoomed = 1
        endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>


" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <C-a> <Home>
cnoremap <C-e> <End>


" 用了它，看着有点晕
" Keep search pattern at the center of the screen.
" nnoremap  n nzz
" nnoremap <silent> N Nzz



" python文件中输入新行时#号注释不切回行首
" autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#



" tab 操作
" http://vim.wikia.com/wiki/Alternative_tab_navigation
" http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim

" tab切换
map <leader>th :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tj :tabnext<cr>
map <leader>tk :tabprev<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprev<cr>
map <leader>te :tabedit<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabm<cr>

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>0 :tablast<cr>

" Toggles between the active and last active tab "
" The first tab is always 1 "
let g:last_active_tab = 1
" nnoremap <leader>gt :execute 'tabnext ' . g:last_active_tab<cr>
" nnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
" vnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
autocmd TabLeave * let g:last_active_tab = tabpagenr()


" => 选中及操作改键

" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" 复制到行末
map Y y$

" 复制选中区到系统剪切板中
vnoremap <leader>y "+y

" auto jump to end of select
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" select all
map <Leader>sa ggVG

" 选中并高亮最后一次插入的内容
nnoremap gv `[v`]

" select block
nnoremap <leader>v V`}


" 滚动Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>


" Jump to start and end of line using the home row keys
" 增强tab操作, 导致这个会有问题, 考虑换键
"nmap t o<ESC>k
"nmap T O<ESC>j



" 交换 ' `, 使得可以快速使用'跳到marked位置
nnoremap ' `
nnoremap ` '

" remap U to <C-r> for easier redo
nnoremap U <C-r>

"==========================================
" FileType Settings  文件类型设置
"==========================================

autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd

" Todo
" 设置可以高亮的关键字
if has("autocmd")
    " Highlight TODO, FIXME, NOTE, etc.
    if v:version > 701
        autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
        autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
    endif
endif

"==========================================
" TEMP 设置, 尚未确定要不要
"==========================================

" https://dougblack.io/words/a-good-vimrc.html
"==========================================
" Theme Settings    主题设置
hi! link SignColumn     LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" 防止错误整行标红 导致看不清
" highlight clear SpellBad
" highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
" highlight clear SpellCap
" highlight SpellCap term=underline cterm=underline
" highlight clear SpellRare
" highlight SpellRare term=underline cterm=underline
" highlight clear SpellLocal
" highlight SpellLocal term=underline cterm=underline


" 放前面会被某些内容覆盖掉
nnoremap <C-E> $



" Using this operator we can surround swaths of text using it as you would any other operator within Vim:
" ds' to delete the surrounding ' (ds{char})
" cs'" to change the surrounding ' for " (cs{old}{new})
" ysaptli> to surround a paragraph with an <li> tag (ys{motion}{char})
" You can also use vim-surround by selecting a bit of text in visual mode and then using S{desired character}

" 自动换行是每行超过 n 个字的时候 , vim 自动加上换行符用。最好别用，坑
" set textwidth=30

nnoremap  cb O'''<Esc>Go'''<Esc>
inoremap  cb '''<Esc>Go'''<Esc><C-o>i


" 用过，垃圾，别用：

" Plug 'unblevable/quick-scope'
" Trigger a highlight in the appropriate direction when pressing these keys:
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']  " qs是quick-scope的意思
" highlight QuickScopePrimary guifg='#7cbd3c80' gui=underline ctermfg=155 cterm=underline
" highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

