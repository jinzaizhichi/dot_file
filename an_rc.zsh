# This is antigenrc file


# Declare modules
zstyle ':prezto:*:*' color 'yes'
# todo
# zstyle ':prezto:module:editor' key-bindings 'vi'  #要适应
# zstyle ':prezto:module:git:alias' skip 'yes'
# zstyle ':prezto:module:prompt' pwd-length 'long'
# zstyle ':prezto:module:autosuggestions' color 'yes'
# zstyle ':prezto:module:python' autovenv 'yes'
# zstyle ':prezto:load' pmodule \
	# 'environment' \
	# 'editor' \
	# 'history' \
	# 'utility' \
	# 'history-substring-search' \
	# 'autosuggestions' \
	# 'completion' \
	#'prompt' \
# antigen use prezto

# [[===============bundle/plugin/插件/zshrc外的函数==============================================
# 手动更新
# antigen bundle unixorn/autoupdate-antigen.zshplugin


# antigen use oh-my-zsh
antigen bundle pip  # 加了这行，会自动装oh-my-zsh, 但没用上
# Load bundles from the default repo (oh-my-zsh) oh_my_zsh ohmyzsh
# antigen bundle git
# antigen bundle command-not-found
# antigen bundle docker

antigen bundle zsh-users/zsh-autosuggestions
# antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions # 容易安装失败?
antigen bundle rupa/z z.sh

# antigen bundle jeffreytse/zsh-vi-mode # 报错： zvm_zle-line-init啥的找不到
# antigen bundle hchbaw/auto-fu.zsh # 垃圾，别用:

# ======================zsh comand time=================================================
# Sleep don't consume any cpu time and REPORTTIME "don't see" such idle commands.
# If you need to monitor only cpu-angry commands, use REPORTTIME instead this plugin.
# antigen bundle popstas/zsh-command-time

# ZSH_COMMAND_TIME_MIN_SECONDS=4
# # Message to display (set to "" for disable).
# ZSH_COMMAND_TIME_MSG="耗时: %s "
# # Message color.
# ZSH_COMMAND_TIME_COLOR="cyan"
# # Exclude some commands
# ZSH_COMMAND_TIME_EXCLUDE=(tmux vim vscode)
# # customize the plugin by redefinition of function
# zsh_command_time() {
#     if [ -n "$ZSH_COMMAND_TIME" ]; then
#         hours=$(($ZSH_COMMAND_TIME/3600))
#         min=$(($ZSH_COMMAND_TIME/60))
#         sec=$(($ZSH_COMMAND_TIME%60))
#         if [ "$ZSH_COMMAND_TIME" -le 60 ]; then
#             timer_show="$fg[green]$ZSH_COMMAND_TIME s."
#         elif [ "$ZSH_COMMAND_TIME" -gt 60 ] && [ "$ZSH_COMMAND_TIME" -le 180 ]; then
#             timer_show="$fg[yellow]$min min. $sec s."
#         else
#             if [ "$hours" -gt 0 ]; then
#                 min=$(($min%60))
#                 timer_show="$fg[red]$hours h. $min min. $sec s."
#             else
#                 timer_show="$fg[red]$min min. $sec s."
#             fi
#         fi
#         echo "leo改过的zsh_command_time:"
#         printf "${ZSH_COMMAND_TIME_MSG}\n" "$timer_show"
#     fi
# }
# ======================zsh comand time=================================================]]



# ===============bundle/plugin/插件/zshrc外的函数=======================================================]]


# antigen cleanup # 要放在antigen bundle 某某某 后面 ?
antigen apply # Tell Antigen that you're done
#====================================================== Antigen: done===============