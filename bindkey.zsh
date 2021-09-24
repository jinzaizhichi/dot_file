bindkey "\033[1~" beginning-of-line # HOME键
bindkey "\033[4~" end-of-line # END

# A key sequence typed by the user can be turned into a command name for use in user-defined widgets with the read-command widget
# bindkey [ options ] -s in-string out-string
bindkey -s "\C-o" "cle \C-j"
# t for try
bindkey -s "\C-t" "run_l \C-j"
# vi mode 出问题来这里

# todo
# alt键：\e
bindkey -s '\ee' backward-word
bindkey '\eh' backward-word
bindkey '\el' forward-word
bindkey '\ej' down-line-or-history
bindkey '\ek' up-line-or-history
#可以换成别的功能
bindkey '\eJ' beginning-of-line
bindkey '\eK' end-of-line
# bindkey '\eo' end-of-line

bindkey -s '\eu' '..\n' # u for up
bindkey -s '\eo' 'echo "待用" \n'
bindkey -s '\e/' 'll\n'

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