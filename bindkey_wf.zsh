# bindkey "^C" self-insert  # 原样输入




# 声明key这个变量是not local的,且是arrays?
typeset -g -A key
# -g do not restrict parameter to local scope
# -A specify that arguments refer to associative arrays

# 这些都叫function keys?
key[F1]='^[OP'
key[F2]='^[OQ'
key[F3]='^[OR'
key[F4]='^[OS'
key[F5]='^[[15~'
key[F6]='^[[17~'
key[F7]='^[[18~'
key[F8]=''''
key[F9]='^[[20~'
key[F10]='^[[21~'
key[F11]='^[[23~'
key[F12]='^[[24~'

key[Backspace]='^?'
key[Insert]='^[[2~'

key[Home]='^[[1~'
key[End]='^[[4~'

key[Delete]='^[[3~'

key[PageUp]='^[[5~'
key[PageDown]='^[[6~'

key[Up]='^[[A'
key[Down]='^[[B'
key[Right]='^[[C'
key[Left]='^[[D'
key[Menu]=''''



# bindkey -m
# -m  | add builtin meta-key (win键) bindings to selected keymap

# bindkey [ options ] -s in-string out-string
bindkey -s "\C-o" "cle \C-j"

# todo  ^[^H等hard coded的鬼画符 换成这些
# 系统的zshrc(就算我没source,开新的zsh时会自动source)里设置了:
    # typeset -A key
    # key=(
        # BackSpace  "${terminfo[kbs]}"
        # Home       "${terminfo[khome]}"
        # End        "${terminfo[kend]}"
        # Insert     "${terminfo[kich1]}"
        # Delete     "${terminfo[kdch1]}"
        # Up         "${terminfo[kcuu1]}"
        # Down       "${terminfo[kcud1]}"
        # Left       "${terminfo[kcub1]}"
        # Right      "${terminfo[kcuf1]}"
        # PageUp     "${terminfo[kpp]}"
        # PageDown   "${terminfo[knp]}"
    # )


# autoload一个函数和source函数所在文件，效果一样？

# autoload -U:
# 1. autoload: 把fpath定义的函数load进来，这样才能调用。类似python的import？
# 2. -U  | suppress alias expansion for functions  (记作unalias?  )


# https://unix.stackexchange.com/a/677162/457327
autoload -U history-search-end
# -k  | mark function for ksh-style autoloading
# -z  | mark function for zsh-style autoloading

zle -N   history-beginning-search-backward-end        history-search-end
zle -N   history-beginning-search-forward-end         history-search-end

# ^A: start of hearder
# ^H: back space 退格键

# 别用"^[[A"了,$key[Up]好看
# bindkey "$key[Up]" history-beginning-search-backward-end
# bindkey "$key[Down]" history-beginning-search-forward-end
### 比上面2行更灵活
bindkey "$key[Up]" history-substring-search-up
bindkey "$key[Down]" history-substring-search-down


bindkey "$key[Home]" beginning-of-line
# `Escape character`的ascii码的十进制 十六进制 表示:
    # 八进制          \033
    # 十进制          27
    # 16进制          \x1b  或者\x1B
    # 用转义序列表示  \e
    # ctrl-key        ^[      ^是Caret(敲ctrl), 加上[ 就成了ESC


# Control Sequence Introducer: sequence starting with `ESC [`,  即`^[[`


bindkey "$key[End]" end-of-line # END  "\033[4~"
# 或者
# bindkey "\e[F"  end-of-line

# todo 参考:
# bindkey "\e[3~" delete-char  # del
# bindkey "\e\d"  undo  # alt-bs



# t for try
# bindkey -s "\C-t" "run_l \C-j" 不知道是啥

# vi mode 出问题来这里

# alt键：\e

# ctrl作为前缀：
# 1. `\C-x',
# 2.  `^x'
# `-m' option to bindkey tells zsh that wherever it binds an escape sequence like `\eb', itshould also bind the corresponding meta sequence like `\M-b'.
# 不加-m的话：you can rebind them separately. and if you want both sequences to be bound to a new command, you have to bind them both explicitly.


# ctrl p/n  和 上下箭头 只能找到以特定内容开头的历史命令，这个可以所有？
#  <alt>+b, \eb, <esc>+b, <Meta>+b or M-b. These are all the same.
#  e: 表示escap吧

# bindkey -s '^j' 'echo "vscode在用" \n'  #别改^j ，^j和\n同体？
# bindkey '^m' 和回车键 同体
#


bindkey -s '\eo' 'echo "待用" \n'
bindkey -s '\ei' 'echo "待用" \n'
bindkey -s '\ep' 'echo "待用" \n'

# todo
# DIRSTACKSIZE=15 # Setup dir stack
# setopt autopushd  pushdminus pushdsilent pushdtohome pushdignoredups cdablevars
bindkey -s '\eu' '..\n' # u for up  # 不行： bindkey -s '<atl>+u' '..\n'

# bindkey -s '\ek' '.. \n'  # 目录 前进一次

# # autohotkey 使得lalt & vk88, 实现了这功能.避免干扰zsh-vim-mode:
# bindkey -s '\el' 'cd - \n'  # 目录 后退一次

# bindkey '\ek' up-line-or-history
bindkey '^p'  up-line-or-history  # 有了history-substring-search-up 似乎用不到了
# ^p 本来是 history-beginning-search-forward, 搜以当前已敲内容开头的history 用↑代替了

# bindkey '\ej' down-line-or-history
bindkey '^n'  down-line-or-history

#可以换成别的功能
bindkey '\eJ' beginning-of-line
bindkey '\eK' end-of-line
# bindkey '\eo' end-of-line
bindkey '\ee' backward-word
# bindkey '\eh' backward-word  # 行首

# bindkey '\el' forward-word  # 被插件改了？行末
# bindkey -r '\el'  # 不生效，被zsh vim模式插件占了？

# bindkey -s '\e/' 'll\n'
# 留给vim 用作复制一行并注释

bindkey '\ex' execute-named-cmd
# 待阅 https://www.cs.colostate.edu/~mcrob/toolbox/unix/keyboard.html
# https://sgeb.io/posts/zsh-zle-custom-widgets/
bindkey -s '^[^H' 'echo "待用" \n'  # ASCII BS == 0x08 == ^H  改了不生效
bindkey -s '^[^?' 'echo "待用" \n'  # ASCII DEL == 0x7f == 0177 == ^?
bindkey -s '^h' 'echo "被tmux占了" \n'


# bindkey -r '^l'   # -r unbind  r记作reload吧
bindkey -s '^l'   'echo "tmux要用" \n'
bindkey -s '^s'  'echo "覆盖了原来的锁屏" \n'


#
# bindkey -s '^i'   # 不能改, 这货和tab同体


# setup for deer
# autoload -U deer
# zle -N deer
# bindkey ............

# select viins keymap and bind it to main
# bindkey -v 别在这里用,放在rc.zsh的zplug那块的zsh-vim-mode插件附近吧

# 改了不生效
# bindkey '^x^e' vi-find-next-char
# 暂时没有用的键
# bindkey '^g'
# 设不设好像都一样，默认的吧
# bindkey '^q' push-line-or-edit


