bindkey "\033[1~" beginning-of-line # HOME键
bindkey "\033[4~" end-of-line # END

# A key sequence typed by the user can be turned into a command name 

# bindkey [ options ] -s in-string out-string
bindkey -s "\C-o" "cle \C-j"


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
bindkey '\ej' down-line-or-history
bindkey '\ek' up-line-or-history
#可以换成别的功能
bindkey '\eJ' beginning-of-line
bindkey '\eK' end-of-line
# bindkey '\eo' end-of-line
bindkey '\ee' backward-word
bindkey '\eh' backward-word
bindkey '\el' forward-word
# bindkey -s '\e/' 'll\n'
# 留给vim 用作复制一行并注释

# bindkey -r '^l'   # -r unbind  r记作reload吧
bindkey -s '^l'   'echo "ctrl加L, 待用" \n'

# bindkey -s '^i'   'echo "ctrl加I, 待用" \n'  # 不能改, 这货和tab一样

bindkey -s '\eu' '..\n' # u for up
bindkey -s '\eo' 'echo "待用" \n'

# setup for deer
# autoload -U deer
# zle -N deer
# bindkey ............

# bindkey -v vi模式的键位

# 改了不生效
# bindkey '^x^e' vi-find-next-char
# 暂时没有用的键
# 没有用：
# bindkey '^j' peco-history-selection
# bindkey '^j' peco-history-selection
# bindkey '^m' peco-history-selection
# bindkey '^g' peco-history-selection
# bindkey '^i' peco-history-selection
# bindkey '^s' peco-history-selection
# 设不设好像都一样，默认的吧
# bindkey '^q' push-line-or-edit
