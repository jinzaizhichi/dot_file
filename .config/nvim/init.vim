" modeline， 一定要在最后？
" vim: set filetype=vim :

    " 1.没懂
    " 2.autocmd
    " 3. If you start editing a new file, and the 'modeline' option is on,
        " a number of lines(默认是5) at the beginning and end of the file are checked for  modelines.
        " modeline默认 on (但对于root用户，反之，因为有可能执行有害的东西）

" filetype        on        " 检测文件类型
" filetype plugin on        " 针对不同的文件类型, load不同plugin
" filetype indent on        " 针对不同的文件类型采用不同的缩进格式
filetype plugin indent on " 实现了上面3行
                            " There is no need  to do ":filetype on" after ":syntax on".

" If the file type is not detected automatically, or it finds the wrong type,
" you can  add a modeline to your  file.
" for an IDL file use the command:
" :set filetype=vim
" 但我用笔记本时，root用户或者vscode-neovim使得modeline是off的，这时要靠这行：
filetype detect
echom "文件类型是"
echom &filetype
echom "文件类型输出结束】"

au BufNewFile,BufRead *.ahk  setf autohotkey

" ms: mark as searh, 回头敲's跳回来
" https://stackoverflow.com/a/3760486/14972148
" 据说map了slash会影响其他插件. 不过先用着吧
if &filetype == 'vim'
    nnoremap / msgg/\v^[^"]*
" 防止检测filetype不准
elseif expand('%:t') == 'init.vim'
    nnoremap / msgg/\v^[^"]*
    " 如果filetype检测错误，自己在文件里加上：
            " modeline
            "  一定要在最后？

" vim的某个文件已经设置了:  au BufNewFile,BufRead *.ahk  setf autohotkey
elseif &filetype == 'autohotkey'
    echo '检测到文件类型是ahk'
    nnoremap / msgg/\v^[^;]*
    " todo 装个插件
    " https://github.com/hnamikaw/vim-autohotkey
elseif expand('%:t') == 'wf_key.ahk'
    nnoremap / msgg/\v^[^;]*

elseif &filetype  == 'shell'
    nnoremap / msgg/\v^[^#]*
else
    " vscode neovim无法识别filetype?
    " 暂时一锅乱炖
    nnoremap / msgg/\v^[^#";(//)(/*)]*
endif

nnoremap ? msgg/\v
" nnoremap / /\v
cnoremap s/ s/\v

let g:selecmode="mouse"

set linebreak
set list

set listchars=


" 让配置变更立即生效
if has('autocmd') " ignore this section if your vim does not support autocommands
    " 1. Select the group with ":augroup {name}".
    augroup wf_reload_init.vim
        " 2. Delete any old autocommands with
        autocmd!
        " 3. Define the autocommands.   %表示当前文件
        " autocmd! BufWritePost $MYVIMRC,$MYGVIMRC nested source % | echo '改了init.vim'
                " Using :echom will save the output and let you run :messages to view it later.
        autocmd! BufWritePost $MYVIMRC,$MYGVIMRC nested source % | echom '改了init.vim'

        " 4. Go back to the default group：  END
    augroup END
endif


" I want to redefine :e * as :tab *
cnoreabbrev <expr> e getcmdtype() == ":" && getcmdline() == 'e' ? 'tabedit' : 'e'
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'
" 新tab打开help

" 竖着分屏打开help
" augroup my_filetype_settings
" autocmd!
" winnr: 当前window的编号，top winodw是1
" $  表示 last window
" autocmd FileType help if winnr('$') > 2 | wincmd K | else | wincmd L | endif
" augroup END

" 1.4 LISTING MAPPINGS					*map-listing*
" When listing mappings the characters in the first two columns are:

"       CHAR	MODE	~
"      <Space>	Normal, Visual, Select and Operator-pending
"     n	Normal
"     v	Visual and Select
"     s	Select
"     x	Visual
"     o	Operator-pending
"     !	Insert and Command-line
"     i	Insert
"     l	":lmap" mappings for Insert, Command-line and Lang-Arg
"     c	Command-line
"     t	Terminal-Job
"
" Just before the {rhs} a special character can appear:
"     *	indicates that it is not remappable
"     &	indicates that only script-local mappings are remappable
"     @	indicates a buffer-local mapping


" todo
" shif left
" map <S-Left>
" map <S-Right>
" map <C-Left>
" map <C-Right>

"  Use 系统粘贴板: "+
" inoremap <C-V> "+p
set clipboard+=unnamedplus

" 啥玩意?
" nnoremap <C-V> p|  " 现在的ctrl v能在normal模式下直接粘贴系统粘贴板的内容


noremap <Right> *
noremap <Left> #
" CTRL-O                Go to [count] Older cursor position in jump list
                        " (not a motion command).

" <Tab>
" CTRL-I                  Go to [count] newer cursor position in jump list
"                         (not a motion command).

" 在vusial mode下好像没功能
noremap <Up> <C-O>
vnoremap <Up> <Esc><C-O>
" CTRL-I <Tab>          Go to [count] newer cursor position in jump list
                        " (not a motion command)
" 在vusial mode下好像没功能
nnoremap <Down> <C-I>
vnoremap <Down> <Esc><C-I>


"       %       表示全文. Example: :%s/foo/bar/g.
"       $       表示结尾
"       .       当前行
"       .,$     from the current line to the end of the file.
nnoremap <TAB> :.,$s#\<\>##gc<Left><Left><Left><Left><Left><Left><C-R><C-W><Right><Right><Right><C-R><C-W><Left><Left>




noremap <Up> <C-O>



" block模式
" <C-q>用不了，可能是kite占用了  [好像又能用了]
" 记忆：c for block c发音:ke
nnoremap <C-c> <C-v>

" 变成^  作用是 显示ASCII码?:
" vscod里不生效：
inoremap <C-C> <C-V>


" nnoremap <C-J>  " vscode里是切到terminal

noremap <BS> X
" normal模式：<C-X>  数字减1
" shift在ctrl上，加1 vs 减一，刚好
nnoremap X <C-A>

" <C-X> 调自带的omnicomplete
inoremap <C-F> <C-X><C-F>
nnoremap <C-F> i<C-X><C-F>


" 对于vscode-nvim：insert mode is being handled by vscode 所以<C-X>没反应

						" *i_CTRL-X* *insert_expand*
" CTRL-X enters a sub-mode where several commands can be used.  Most of these
" commands do keyword completion; see |ins-completion|.


" no help for <C-X>
" no help for CTRL-X CRTL-O
" 这样才行：
" h i_CTRL-X




" 这样可以 不那么死板地 只能用~/AppData/Local/nvim/init.vim来进入windows的nvim, 从而管理插件(
    " windows的nvim和vscode的nvim共用):
"nvim -u '\\wsl$\Ubuntu\root\dot_file\.config\nvim\init.vim'
" 插件位置:
" C:\Users\noway\AppData\Local\nvim-data
" 把wsl下的dotfile发送快捷方式到 ~/AppData/Local/nvim/init.vim , 不行.因为shortcut和软链接还不一样
" https://superuser.com/questions/253935/what-is-the-difference-between-symbolic-link-and-shortcut

" todo:  有些粘贴来的配置，应该要清理掉


" 【【-----------------------------------------------------------begin
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
" end-------------------------------------------------------------】】



if &diff
    " 反应变慢，不好
    " map ] ]c
    " map [ [c
endif
" map 默认是recursive的

if exists('g:vscode')
    "set wrap 后，同物理行上线直接跳。
    map j gj
    map k gk

    " 还是跳到物理行的 空白开头 ? 现在是跳到非空白开头了，是vscode的设置起效了？
    map H g0
    " nmap H g$<ESC>wk
    map 0 g0
    map L g$

    omap <silent> j gj
    omap <silent> k gk
    " 不好：
        " nmap dd g^dg$i<BS><Esc>
        " nmap yy g^yg$
        " nmap cc g^cg$
    " 不行：
        " nmap A g$a
        " nmap I g^i

    " nmap gm g$
    " nnoremap M

    " vscode里，这样搞只退出插件，文件还打开着
    " noremap qq :q!<CR>
    " vscode-neovim 有map ZQ <Cmd>Quit!<CR>  但这么map还是不行
    " noremap qq ZQ

else
    noremap qq :q!<CR>
    " nnoremap q :wq<CR>  按一次q要等一会才退出， 不如连续按2次快
    " inoremap qq <ESC>:wq<CR>  别这么干，容易在编辑时敲错

    noremap j gj
    noremap k gk

    " map vs map! : map控制“字母不是用于输入”的几个mode，map！控制“字母 是用于输入的字符串的”mode
    noremap H g^
    " nnoremap H g0
    noremap 0 g0
    noremap <Home> g0
    noremap L g$
    noremap <End> g$

    onoremap <silent> j gj
    onoremap <silent> k gk
    " nnoremap dd g^dg$i<BS><Esc>
    " nnoremap yy g^yg$
    " nnoremap cc g^cg$
    nnoremap A g$a
    nnoremap I g^i

    nnoremap gm g$
    " nnoremap M

    nnoremap <c-\> <c-w>v
    nnoremap <c-w>-  <c-w>s
endif



func TabToSpace()
    " vscode 有个插件：takumii.tabspace
    set ts=4 | set expandtab | %retab! | echo" Tab变成4空格"
endfunc
" 完整命令是endfunction，类似python的argparser？没有混淆时，任意缩写都可以？endfunc

" autocmd对neovim-vscode无效？ 暂时手动敲吧
autocmd BufNewFile,BufRead *.py  exec ":call TabToSpace()"



" python文件中输入新行时#号注释不切回行首
" autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#

if exists('g:vscode')
    " 不行：
    " nnoremap gk :<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
    " nnoremap gj :<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
    " todo
    " insert mode下，neovim不管事，（但esc退回normal还是可以的），imap都用不了
    " nnoremap gd vaw<F12>
    " 不行
    " nnoremap zz ZZ
    " filetype on        " 检测文件类型  不会和vscode 打架吧
else
    " echo '没在用 vscode-neovim, 纯 nvim'

    " <C-]>只能在本文件内跳转
    nnoremap gd g<C-]>
    " nnoremap gd :KiteGotoDefinition<CR>

    set  number relativenumber
    nnoremap <F2> :call HideNumber()<CR>
    func HideNumber()
        if(&relativenumber == &number)
            " 叹号或者加inv：表示toggle
            set invrelativenumber invnumber
        elseif(&number)
            set invnumber
        else
            set relativenumber!
        endif

        " :se[t] {option}?	Show value of {option}.
        " set number?
    endfunc

    set wrap    " vscode里, 要在setting.json设置warp

    nnoremap <F4> :UndotreeToggle<CR>






    " vscode上有插件自动处理，不用加这些:
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

    func Indent_wf()
        set ts=2 | set noexpandtab | %retab! | set ts=4 | set expandtab | %retab! | echom "Indent 2缩进变4"
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

    " 保存python文件时删除多余空格
    func <SID>StripTrailingWhitespaces()
            let l = line(".")
            let c = col(".")
            %s/\s\+$//e
            call cursor(l, c)
    endfunc
    " autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,vimrc autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
    autocmd FileType c,cpp,javascript,python,vimrc autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()


    set hlsearch " 高亮search命中的文本
    " 要在设定颜色主题后面，覆盖颜色主题里面的设置

endif


 " 自动取消高亮
let s:current_timer = -1

func Highlight_Search_Off(timerId)
  set nohlsearch
endfunc

func ResetTimer()
  if s:current_timer > -1
    call timer_stop(s:current_timer)
  endif
  " 2秒
  let s:current_timer = timer_start(4000, 'Highlight_Search_Off')
endfunc

nnoremap <silent> N N:call ResetTimer()<CR>
 " 自动取消高亮




nnoremap yf ggyG<C-O>  " 让光标看着没动
nnoremap df ggdG
" p后面一般没有参数，所以pf不好。选中全文，一般只是为了替换。所以vf选中后，多了p这一步
nnoremap vf ggVGp:echo"已粘贴之前复制的内容"<CR>

" comment at the end of line


" vscode里不行，别试了:
" inoremap yf <Esc>ggyG<C-O>

let mapleader =" "
" https://stackoverflow.com/questions/54787831/map-space-to-leader-in-vim


" Lazy loading, my preferred way, as you can have both [避免被PlugClean删除没启动的插件]
" https://github.com/junegunn/vim-plug/wiki/tips
" leo改过
func VimPlugConds(arg1, ...)

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
endfunc



" =============================================vim-plug===============================begin
" 插件 (plugin) 在~/.local/share/nvim/plugged
call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/vim-plug' " 为了能用:help plug-options


Plug 'voldikss/vim-translator'
" <Leader>t 翻译光标下的文本，在命令行回显
nmap <silent> <Leader>t <Plug>Translate
vmap <silent> <Leader>t <Plug>TranslateV

" <Leader>h 翻译光标下的文本，在窗口中显示   h：here
nmap <silent> <Leader>h <Plug>TranslateW
vmap <silent> <Leader>h <Plug>TranslateWV


Plug 'jonathanfilip/vim-lucius'
Plug 'andymass/vim-matchup'
Plug 'junegunn/vim-easy-align'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}


" 装了没啥变化，neovim本身就可以实现：多个窗口编辑同一个文件时，只要一个窗口保存了，
" 跳到另一个窗口，会看到变化
    " Plug 'gioele/vim-autoswap'
    " set title
    " " the default titlestring will work just fine
    " set titlestring=
    " let g:autoswap_detect_tmux = 1



" 要编译python+，难搞 放弃
" 允许多人同时编辑一个文件。避免多处打开同一个文件
" Plug 'FredKSchott/CoVim', VimPlugConds(!exists('g:vscode'))

" ga :  记作 get alignment,  本来是get ascii
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" [[==============================easymotion 配置=====================begin

" Plug 'asvetliakov/vim-easymotion'   " vscode定制的easymotion
" Plug 'easymotion/vim-easymotion'    " 只用裸nvim下的easymotion  千万别这么干。会把正在编辑的文件全搞乱

Plug 'easymotion/vim-easymotion', VimPlugConds(!exists('g:vscode'))  " exists(): 变量存在，则返回TRUE，否则0
Plug 'asvetliakov/vim-easymotion', VimPlugConds(exists('g:vscode'), { 'as': 'leo-jump' })  " as的名字随便起，
                                                                                        " 下面map时，还是 nmap S <Plug>(easymotion-f2)之类的



" 这样可能更容易理解，没那么绕: 【an empty `on` or `for` option : plugin is registered but not loaded by default depending on the condition.】
" Plug 'easymotion/vim-easymotion',  has('g:vscode') ? { as': 'ori-easymotion', 'on': [] } : {}
" Plug 'asvetliakov/vim-easymotion', has('g:vscode') ? {} : { 'on': [] }

" map <Leader> <Plug>(easymotion-prefix)
" 默认:
map <Leader><Leader> <Plug>(easymotion-prefix)

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " 敲小写，能匹配大写。反之不然

" Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" todo  debug buggy 出了问题来这里
"s for search
" 用了vim-sandwich的默认keymapping，sa代表sandwich add.  sd 代表sandwich delete
" 干脆用大写的S算了，避免冲突
nmap S <Plug>(easymotion-f)
" nnoremap s <Plug>(easymotion-f)  " 用nnoremap不行
"
" Need one more keystroke
nmap f <Plug>(easymotion-f2)

" 会抽风颤抖
" nmap f <Plug>(easymotion-f) "f{char}
" map  <Leader>f <Plug>(easymotion-bd-f) " <Leader>f{char} to move to {char}
"" umap后，变回默然的功能
" unmap f

" 会显示高亮字母后，光标到下一行
" nmap S <Plug>(easymotion-f2) " {char}{char} 怎样可以上下文都搜索？现在只能搜下文
" map  <Leader>w <Plug>(easymotion-w) " Move to word    " buftype option is set??
" ================================easymotion 配置=====================]]

Plug 'kurkale6ka/vim-pairs'   " 和sandwich“互补”

Plug 'machakann/vim-sandwich'
" 别再试同类(前浪)
"  Plug 'tpope/vim-surround'
"  Plug 'kana/vim-textobj-user'
"  Plug 'sgur/vim-textobj-parameter'



Plug 'scrooloose/nerdcommenter'
Plug  'Yggdroot/LeaderF'
Plug 'sisrfeng/toggle-bool'

noremap <leader>r :ToggleBool<CR>

Plug 'mbbill/undotree'

if has("persistent_undo")
    let target_path = expand('~/.undodir')
    " let target_path = expand('~/.undodir_nvim_wf')
    if !isdirectory(target_path) " if the location does not exist.
        call mkdir(target_path, "p", 0700) " create the directory and any parent directories
    endif

    let &undodir=target_path
    set undofile
endif



" 同类:
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


if has('win32')
    " echo 'leo: 正在用win32，win32表示 32 or 64 bit的windows'
    let g:python3_host_prog = "F:\\python39\\python.exe"  " ToggleBool会用到
    " let g:python_host_prog = ""  " ToggleBool会用到   我fork了这个插件 并改了?
    " let g:loaded_python_provider = 0
endif

if !has('win32')
    " 从这里学来的：
    " https://github.com/SpaceVim/SpaceVim/blob/b2d1d7460690648951d6685a3a947e9b4248e38c/autoload/SpaceVim/layers/leaderf.vim#L489
    source ~/dot_file/.config/nvim/beautify_wf.vim

    " 这么写比较啰嗦：
    " let s:beauty_path = fnamemodify($MYVIMRC, ":p:h") . "/beautify_wf.vim"    " 字符串concat，用点号
    " exe 'source ' . s:beauty_path      " 这样不行： source  . s:beauty_path
endif



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
" <C-/> 在vim中由C-_表示 zsh下敲cat后，ctrl / 显示  ^_
nnoremap <C-_> :call nerdcommenter#Comment('n', 'toggle')<CR>j
inoremap <C-_> <ESC>:call nerdcommenter#Comment('n', 'toggle')<CR>j
vnoremap <C-_> :call nerdcommenter#Comment('n', 'toggle')<CR>


" 不行
" func! InlineCommentWf()
"     exec "normal A"
"     exec "normal o/"
"     call nerdcommenter#Comment("n", "Comment")
"     exec "normal kJA"
" endfunc



if exists('g:vscode')
    " vscode里，<C-_>注释，用的是vscode的"editor.action.comment"之类的,不是vim的命令,这样不行：
    " nnoremap ce A<space><space><Esc>o/<Esc><Esc><Esc><Esc><Esc><Esc><C-_>kJA<BS>

    " 有时会弄脏代码，可能是vscode-nvim弹出窗口太慢了？它不能接管inputmode？  " 提issue吧
    nnoremap ce A<space><space><Esc>o/<Esc><Esc>:::::call nerdcommenter#Comment("n", "Comment")<space><CR>kJA<BS>


    " vscode-neovim的 VSCodeCommentary is just a simple function which calls editor.action.commentLine.
    " xmap <C-_>  <Plug>VSCodeCommentary
    " nmap <C-_>  <Plug>VSCodeCommentary
    " omap <C-_>  <Plug>VSCodeCommentary
    " nmap <C-_>  <Plug>VSCodeCommentaryLine
else
    " let g:NERDCreateDefaultMappings = 0  " 之前设为1，导致vscode用不了nerdcommenter?
    nnoremap ce A<space><space><Esc>o/<Esc><Esc>:call nerdcommenter#Comment("n", "Comment")<CR>kJA<BS>
    " 有缩进时，有时会把开头的注释符号删掉，别完美主义吧
endif


nnoremap <M-/> yy:call nerdcommenter#Comment('n', 'toggle')<CR>p

" 好慢：
" nnoremap = :<plug>nerdcommentertoggle<cr>j
" nnoremap - :k<plug>nerdcommentertoggle<cr>
" 这行不行:
" nnoremap = :call <Plug>NERDCommenterInvert<CR>


"let g:NERDDefaultNesting = 1
" ---------------------------nerdcommenter-config----------------------------------end]]


" todo: vscode中会复制到 前后空格  " a变成i估计就行了
nnoremap vp viwp
" 类似于Y D C等，到行末
nnoremap P v$<left>p


" todo: `omap`代替下面的有点重复的各种operator的map
" omap ' i'
" omap " vi"
" omap ( i(
" omap ) i)
" omap [ i[
" omap ] i]
" omap { i{
" omap } i}
" omap } i}
" omap ' i'



nnoremap v" vi"
nnoremap v( vi(
nnoremap v) vi)
nnoremap v[ vi[
nnoremap v] vi]
nnoremap v{ vi{
nnoremap v} vi}
nnoremap v} vi}


nnoremap yp yyp
nnoremap yw yiw
nnoremap y' yi'
nnoremap y" yi"
nnoremap y( yi(
nnoremap y) yi)
nnoremap y[ yi[
nnoremap y] yi]
nnoremap y{ yi{
nnoremap y} yi}


nnoremap cw ciw



func! DoubleAsSingle()
    " When [!] is added, error messages will also be skipped,
    " and commands and mappings will not be aborted
    " when an error is detected.  |v:errmsg| is still set.
    let v:errmsg = ""
    silent! :s#\"\([^"]*\)\"#'\1'#g
    if (v:errmsg == "")
        echo "双变单"
    endif
endfunc

nnoremap c' :call DoubleAsSingle()<CR>ci'
nnoremap v' :call DoubleAsSingle()<CR>vi'
nnoremap y' :call DoubleAsSingle()<CR>yi'
nnoremap d' :call DoubleAsSingle()<CR>da'
" nnoremap c' :s#\"\([^"]*\)\"#'\1'#g<CR>ci'
" nnoremap d' :s#\"\([^"]*\)\"#'\1'#g<CR>da'
" nnoremap v' :s#\"\([^"]*\)\"#'\1'#g<CR>vi'
" nnoremap y' :s#\"\([^"]*\)\"#'\1'#g<CR>ya'



nnoremap c" ci"
nnoremap c( ci(
nnoremap c) ci)
nnoremap c[ ci[
nnoremap c] ci]
nnoremap c{ ci{
nnoremap c} ci}

nnoremap dw diw
nnoremap d" da"
nnoremap d( da(
nnoremap d) da)
nnoremap d[ da[
nnoremap d] da]
nnoremap d{ da{
nnoremap d} da}



" inoremap cb '''<Esc>Go'''<Esc><C-o>i
" change a block  " 百分号 能自动跳到配对的符号
onoremap b %ib
" nnoremap cb %cib
" nnoremap vb %vib
" nnoremap yb %yib

nnoremap db %dab


" nnoremap cb O'''<Esc>Go'''<Esc>
" inoremap cb '''<Esc>Go'''<Esc><C-o>i

"====https://github.com/ahonn/dotfiles/tree/master/vim/vscode================start
nnoremap < <<
nnoremap > >>
vnoremap < <gv


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




"" vim-textobj-parameter
"let g:vim_textobj_parameter_mapping = 'a'

"" vim-doge
"let g:doge_mapping = '<Leader>dc'


"====https://github.com/ahonn/dotfiles/tree/master/vim/vscode================end



" nnoremap  J j
" c b means: comment block


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
noremap <Leader>Y "+y
" noremap <Leader>p "*p
" noremap <Leader>P "+p

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

" let g:UltiSnipsJumpForwardTrigger="<CR>"
" let g:UltiSnipsJumpBackwardTrigger="<C-.>"
""" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"







" todo 不匹配行首空白符
"
" vscode里 按ctrl 】也不会搜到comment的内容
" Search_no_comment()



func! Wfprint_n()
        if &filetype == 'python'
            exec "normal yawoprint('看: ')" | exec "normal hhhhp" | exec "normal oprint()"  | exec "normal hp"
        elseif &filetype == 'cpp'
            exec 'normal yawocout<<""<<'| exec 'normal hhhpf<lpa<<endl;'
        elseif &filetype == 'sh'
        endif
endfunc

nnoremap _p :call Wfprint_n()<CR>
vnoremap _p :yoprint('看:') <ESC>hhhhpoprint()<ESC>hp

" 还不能用
func! Wfprint_v()
        if &filetype == 'python'
            exec "y" | exec "normal oprint('看: ')" | exec "normal hhhhp" | exec "normal oprint()"  | exec "normal hp"
        elseif &filetype == 'cpp'
            exec 'visual yocout<<""<<'| exec 'normal hhhpf<lpa<<endl;'
        elseif &filetype == 'sh'
        endif
endfunc
" 不行
" vnoremap _p :call Wfprint_v()<CR>



" <bar> : 表示 '|' ,  to separate commands, cannot use it directly in a mapping, since it would be seen as marking the end of the mapping.
" 百分号代表当前文件
" bash 的  &&  是前面的命令成功了，继续执行后面的
" autocmd filetype cpp nnoremap <C-c> :w <bar> !clear && g++ -std=gnu++14 -O2 % -o %:p:h/%:t:r.exe && ./%:r.exe<CR>

set autowrite

" mswin.vim会导致visual mode 光标所在字符不被选中
" ~/dot_file/mswin.vim里有用的内容都在这里
" [[---------------------------------------msvim-------------------------------


" saving,
noremap <C-S>		:update<CR>
inoremap <C-S>		<C-O>:update<CR>
" *v_CTRL-C*  v表示 Visual mode; Stop Visual mode
vnoremap <C-S>		<C-C>:update<CR>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
" if !has("unix")
"   set guioptions-=a
" endif


nnoremap <C-Z> u|  " CTRL-Z is Undo
" 竖线前的空格，视为map后的一部分。上行等价于：
" nnoremap <C-Z> u
"" CTRL-Z is Undo

inoremap <C-Z> <C-O>u

nnoremap <C-Y> <C-R>|   " CTRL-Y is Redo (although not repeat)
inoremap <C-Y> <C-O><C-R>

" ---------------------------------------msvim-------------------------------]]



noremap <F5> <ESC>oimport pudb<ESC>opu.db
inoremap <F5> <ESC>oimport pudb<ESC>opu.db

" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
func AutoSetFileHead()
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








" if 1
    " echo ' wf初始化的文件: ~/dot_file/vimrc'
" endif
" nvim中不了<HOME> <END>    $行末 ^行首 结合autohotkey


" <Plug>NERDCommenterToggle<CR>和 :call NERDComment('n', 'toggle')<CR> 应该一样
" nnoremap = :call nerdcommenter#Comment('n', 'toggle')<CR>j
" vim的等号：用来indent
" ==     4= 等
nnoremap - :call nerdcommenter#Comment('n', 'toggle')<CR>k

" 这行 不行:
" nnoremap = :call <Plug>NERDCommenterInvert<CR>




" 重复了
" autocmd filetype python nnoremap <C-c> :w <bar> !python % <CR>

cnoremap <F1> call WfRun()<CR>
inoremap <F1> <ESC>:call WfRun()<CR>
nnoremap <F1> :call WfRun()<CR>
func! WfRun()
    exec "w"
    echo "wf_已保存"
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




" CapsLock 识别不了
" map <CapsLock>[ #
" map <CapsLock>] *

let g:ackprg = 'ag --vimgrep'


set cmdheight=2
set fdm=indent




if exists('$TMUX')
    autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
    autocmd VimLeave * call system("tmux rename-window zsh")
    " autocmd BufEnter,FocusGained * call system("tmux rename-window " . expand("%:t"))
    " autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
    set title
endif


set title
set mouse=a
" syntax on  " 别用，会覆盖DIY的配置

set nocompatible  " 别兼容老的vi
set backspace=indent,eol,start
" indent  allow backspacing over autoindent
" eol     allow backspacing over line breaks (join lines)
" start   allow backspacing over the start of insert; CTRL-W and CTRL-U stop once at the start of insert.


set timeoutlen=800

set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030




" >>>`1.` 基础设置---------------------------------------------------------------------
" history存储容量
set history=2000

" 文件修改之后自动载入
set autoread

" shortmess: short messages, 简略提示
" I:启动的时候不显示多余提示
" t: trunc
set shortmess=tI

let s:noSwapSuck_file = fnamemodify($MYVIMRC, ":p:h")  . "/noswapsuck.vim"    " 字符串concat，用点号
            " fnamemodify比expand的功能更强
            " :echo @%                |" directory/name of file
            " :echo expand('%:p')     |" full path
            " :echo expand('%:p:h')   |" directory containing file ('head')
            " :echo expand('%:t')     |" name of file ('tail')
exe 'source ' . s:noSwapSuck_file
 " 这样不行： source  . s:noSwapSuck_file

        " 取代了这些：
                " set nobackup  取消备份。 视情况自己改
                " set noswapfile  关闭交换文件


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
set mousehide  " Hide the mouse cursor while typing

set title  " change the terminal's title

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



" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=5



" Turn off search wrapping:
" set nowrapscan
" It'll give an error and stop at both the top and bottom of the buffer:
" E384: search hit TOP without match for: set
" E385: search hit BOTTOM without match for: set

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
" func NumberToggle()
    " if(&relativenumber == 1)
        " set norelativenumber number
    " else
        " set relativenumber
    " endif
" endfunc
" nnoremap <C-n> :call NumberToggle()<cr>


"==========================================
" FileEncode Settings 文件编码,格式
"==========================================
" 设置新文件的编码为 UTF-8
set encoding=utf-8
" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,eu

" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
" Zoom / Restore window.
func s:ZoomToggle() abort
        if exists('t:zoomed') && t:zoomed
                execute t:zoom_winrestcmd
                let t:zoomed = 0
        else
                let t:zoom_winrestcmd = winrestcmd()
                resize
                vertical resize
                let t:zoomed = 1
        endif
endfunc
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>


" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <C-a> <Home>
cnoremap <C-e> <End>


" tab 操作
" http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim

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



"缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

map Y y$

" 复制选中区到系统剪切板中
vnoremap <leader>y "+y

" auto jump to end of select
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]


" 选中并高亮最后一次插入的内容
nnoremap gv `[v`]

" select block
nnoremap <leader>v V`}


" 滚动Speed up scrolling of the viewport slightly
" nnoremap <C-e> 2<C-e>
" nnoremap <C-y> 2<C-y>  " 用作tmux的激活键了


" Jump to start and end of line using the home row keys
" 增强tab操作, 导致这个会有问题, 考虑换键
"nmap t o<ESC>k
"nmap T O<ESC>j



" 交换 ' `, 使得可以快速使用'跳到marked位置
nnoremap ' `
nnoremap ` '

" remap U to <C-r> for easier redo
nnoremap U <C-r>




" 放前面会被某些内容覆盖掉
nnoremap <C-E> $


" >>>---------------------------------------------------------------------LeaderF
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1


" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>o"
let g:Lf_ShortcutF = "<leader>f"
noremap <leader>ob :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ot :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>ol :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

" noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
" noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

" search visually selected text literally
" xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
" noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
" noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
" noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
" noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
" ---------------------------------------------------------------------<<<LeaderF






let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
" 在vscode里 只有sa生效，其他不行，不知道为啥

" easy-motion的nmap用的是S
" let g:operator_sandwich_no_default_key_mappings = 1


" NOTE: To prevent unintended operation
" nmap s <Nop>
" xmap s <Nop>
" xmap creates a mapping for just Visual mode
" vmap creates one for both Visual mode and Select mode. select mode很少用
" <NOP>		no-opperation? do nothing (useful in mappings)

" 之前不知道为什么不生效： 现在 没加这几行,也能用,应该是默认的
xnoremap sa <Plug>(operator-sandwich-add)
" xnoremap sd <Plug>(operator-sandwich-delete)
" xnoremap sr <Plug>(operator-sandwich-replace)
"
" sc:  sandwich surround Code
" nnoremap <Leader>pb <Plug>(operator-sandwich-add-query1st)
" nnoremap sa <Plug>(operator-sandwich-add-query1st)
"
" 加了没反应
nnoremap sc <Plug>(operator-sandwich-add)

