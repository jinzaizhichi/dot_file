#自动补全功能
setopt AUTO_LIST
setopt AUTO_MENU
setopt MENU_COMPLETE #开启此选项，补全时会直接选中菜单项

# ':completion:<function>:<completer>:<command>:<argument>:<tag>'
# tag as a type of match. For example “files”, “domains”, “users”`用户自定义？`, or “options” are tags.
#  即： information displayed during completion
#
##彩色补全菜单
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist

setopt MENU_COMPLETE
setopt LIST_ROWS_FIRST
setopt LIST_PACKED  # 排得更紧凑
# setopt AUTO_MENU   # 加不加好像都一样
# CTRL+x i
# bindkey -M menuselect '^xi' vi-insert

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' file-list false  # 太啰嗦
zstyle ':completion:*' list-separator '|'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'


##[[------------------------过滤external-command---------------------
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
##加了没变化:
# zstyle ':completion:*:*:-command-:*' group-order 'alias external-command local-directories'
# zstyle ':completion:*:*:-command-:*' group-order local-directories
zstyle ':completion:*:*:-command-:*:*' group-order alias functions commands builtins  #` -command- means any word in the “command position”. ` 没懂
##加了没变化:
#zstyle ':completion:*:*:-command-:*' ignored-patterns 'external-command'
zstyle ':completion:*:complete:-command-:*:*' tag-order 'external-command' 'local-directories'

##----------------------过滤external-command---------------------]]


zstyle ':completion:*:*sh:*:' tag-order files

zstyle ':completion:*:*:*:*:descriptions' format $'\e[01;33m %d \e[0m'  # 表示补全类型:   %d
zstyle ':completion:*:*:*:*:corrections' format $'\e[01;32m 校正 (错误字数: %e) \e[0m'
zstyle ':completion:*:(approximate|correct)' format ' %F{yellow}近似__校正_%d for %B%o%b (errors: %e)%f'
zstyle ':completion:*:*expansions' format ' %F{cyan}扩展_%d for %B%o%b%f'
zstyle ':completion:*:warnings' format $'\e[01;31m 无法补全 \e[0m'
# zstyle ':completion:*:descriptions' format $'\e[01;33m  %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m 补全信息 %d --\e[0m'

zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# =[[====================================参考=======================================begin]]
# %B (%b)
# Start (stop) boldface mode.

# %E
# Clear to end of line.

# %U (%u)
# Start (stop) underline mode.

# %S (%s)
# Start (stop) standout mode.

# %F (%f)
# Start (stop) using a different foreground colour, if supported by the terminal. The colour may be specified two ways: either as a numeric argument, as normal, or by a sequence in braces following the %F, for example %F{red}. In the latter case the values allowed are as described for the fg zle_highlight attribute; Character Highlighting. This means that numeric colours are allowed in the second format also.

# %K (%k)
# Start (stop) using a different bacKground colour. The syntax is identical to that for %F and %f.

# %{...%}
# Include a string as a literal escape sequence. The string within the braces should not change the cursor position. Brace pairs can nest.

# A positive numeric argument between the % and the { is treated as described for %G below.

# %G
# =[[====================================参考=======================================end]]


zstyle ':completion::complete:*' use-cache on
# todo  为什么试了几次， 还是没东西写进这文件？
# zstyle ':completion::complete:*' cache-path "$HOME/.completion_cache_wf.zsh"
zstyle ':completion:*' cache-path "$HOME/.completion_cache_wf.zsh"

zstyle ':completion:*:cd:*' ignore-parents parent pwd


zstyle ':completion:*:default' select-prompt '第 %m '  # %S：standout mode
zstyle ':completion:*:default' list-prompt '%S%m 不知道什么时候生效 matches | line %l | %p%s'
# zstyle ':completion:*:default' select-prompt '%S%m matches | line %l | %p%s'
# zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select 
zstyle ':completion:*:*:default' force-list always
#zstyle ':completion:*:match:*' original only
#zstyle ':completion::prefix-1:*' completer _complete
#zstyle ':completion:predict:*' completer _complete
#zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

##路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
#zstyle ':completion::complete:*' '\\'


##修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
##错误校正
zstyle ':completion:*' completer _complete _match _approximate
#zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 2 numeric

##kill 命令补全
#compdef pkill=kill
#compdef pkill=killall
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

##补全类型提示分组
