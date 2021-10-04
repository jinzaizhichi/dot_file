#自动补全功能
setopt AUTO_LIST
setopt AUTO_MENU
setopt MENU_COMPLETE #开启此选项，补全时会直接选中菜单项

##[[------------------------过滤external-command---------------------
zstyle ':completion:*:matches' group 'yes'
# zstyle ':completion:*' group-name ''
##加了没变化:
# zstyle ':completion:*:*:-command-:*' group-order 'alias external-command local-directories'
zstyle ':completion:*:*:-command-:*' group-order local-directories
##加了没变化:
#zstyle ':completion:*:*:-command-:*' ignored-patterns 'external-command'
zstyle ':completion:*:complete:-command-:*:*' tag-order 'external-command' 'local-directories'

##----------------------过滤external-command---------------------]]

zstyle ':completion:*:*sh:*:' tag-order files

#自动补全缓存
zstyle ':completion:*:(approximate|correct)' format ' %F{yellow}近似__校正_%d for %B%o%b (errors: %e)%f'
zstyle ':completion:*:*expansions' format ' %F{cyan}扩展_%d for %B%o%b%f'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- leo:没有合适的命令 --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m --wf_校正 (错误字母数: %e) --\e[0m'
zstyle ':completion:*:descriptions' format $'\e[01;33m --wf_描述 %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m --wf_信息 %d --\e[0m'

zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path .zcache

zstyle ':completion:*:cd:*' ignore-parents parent pwd

zstyle ':completion:*' list-separator '|'

zstyle ':completion:*' format ' %F{green} -- _%d%f --'
zstyle ':completion:*:default' list-prompt '%S%m matches | line %l | %p%s'
zstyle ':completion:*:default' select-prompt '%S%m matches | line %l | %p%s'
#自动补全选项
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'
#zstyle ':completion:*:match:*' original only
#zstyle ':completion::prefix-1:*' completer _complete
#zstyle ':completion:predict:*' completer _complete
#zstyle ':completion:incremental:*' completer _complete _correct
#zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

##路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
#zstyle ':completion::complete:*' '\\'

##彩色补全菜单
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

##修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
##错误校正
zstyle ':completion:*' completer _complete _match _approximate
#zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 2 numeric

##kill 命令补全
#compdef pkill=kill
#compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

##补全类型提示分组
