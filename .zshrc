export PYTHONPATH=

export PTPYTHON_CONFIG_HOME=$HOME/dot_file/.config/ptpython
export PTIPYTHON_CONFIG_HOME=$HOME/dot_file/.config/ptpython # ptipython
export PYTHONSTARTUP=$HOME/dot_file/leo_python_startup.py

# less 敲v，先找VIUSAL指定的编辑器，没有再找EDITOR
export VISUAL=vim  # vscode不行
export EDITOR=vim

export LOGURU_FORMAT="{time} | <lvl>{message}</lvl>"

export PYTHON_PRETTY_ERRORS=1

export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

export TF_CPP_MIN_LOG_LEVEL=2

# 交互式模式的初始化脚本, 防止被加载两次
if [ -z "$_INIT_SH_LOADED" ]; then   # test -z returns true, if the parameter is empty
    _INIT_SH_LOADED=1
else
    return  #不再执行剩下的才做，退出.zshrc
fi

# exit for non-interactive shell:
# `$-` : 获取“-”这个变量的值(类似于$PAHT  $HOME)。他表示zsh -c 等参数(类似rm -rf中的r和f)，又称flag
# i: 表示interactive，[但自动补全时，显示I h等，不显示i，因为没有意义] --
    # 只敲zsh时，默认就是进了交互式程。
    # 另外，在bash命令行下，敲zsh -i my_echo.sh，echo里面的东西之后，还是回到bash
[[ $- != *i* ]] && return

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# https://zsh.sourceforge.io/Intro/intro_6.html
DIRSTACKSIZE=15 # Setup dir stack
setopt autopushd  pushdminus pushdsilent pushdtohome pushdignoredups cdablevars

# -U  | suppress usual alias expansion for functions, recommended for the use of
    # functions supplied with the zsh distribution.
# for functions precompiled with the zcompile builtin command,
# the flag `-U must be provided` when the `.zwc file is created`
autoload -Uz run-help
autoload -Uz run-help-ip # -z  | mark function for zsh-style autoloading
autoload run-help-git

export TERM="xterm-256color" # Enable 256 color to make auto-suggestions look nice
ZSH_AUTOSUGGEST_USE_ASYNC=1
autoload -U compinit # -U : suppress alias expansion for functions
compinit


# [[==================================zsh插件管理：zplug=================================
export ZPLUG_HOME=$HOME/dot_file/zplug
source $ZPLUG_HOME/init.zsh
export ZPLUG_LOADFILE=$HOME/dot_file/zplug/zplug_loadfile.sh

# use double quotes
zplug "zplug/zplug", hook-build:"zplug --self-manage"

# zplug "modules/prompt", from:prezto

# 避免冲突，顺序： zsh-autosuggestions > zsh-syntax-highlighting > zsh-vim-mode
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "rupa/z", use:z.sh # 这样不行： zplug "rupa/z", as:plugin, use:"*.sh"

# 下面这个插件，must be loaded after:
# 1. executing compinit command (让defer>= 2 )
# 2. sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# zplug "softmoth/zsh-vim-mode"
# zplug "jeffreytse/zsh-vi-mode"  # 有奇怪错误，提issue很繁琐，不用了。自己配吧
# zplug "hchbaw/zce.zsh"


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# source plugins and add commands to $PATH
# zplug load --verbose
zplug load

# zplug update  #需要时，自己敲
# ==================================zsh插件管理：zplug=================================]]

source $HOME/dot_file/completion.zsh
source $HOME/dot_file/history.zsh
source $HOME/dot_file/alias.zsh
source $HOME/dot_file/color_in_less.zsh
source $HOME/dot_file/color_in_zsh.zsh
source $HOME/dot_file/bindkey.zsh

setopt autocd
setopt globdots
setopt ignorebraces
setopt interactivecomments
export UPDATE_ZSH_DAYS=30


# 如果因为locales无法安装，locale-gens啥的失败，报LC等错误，删掉这行：
export LC_ALL=zh_CN.UTF-8
# 待阅: https://www.linux.com/news/controlling-your-locale-environment-variables/

autoload -U promptinit # -U: suppress alias expansion for functions
promptinit
autoload -U colors && colors
#Red, Blue, Green, Cyan, Yellow, Magenta, Black & White


alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'

function d () {
    dirs -v | head -10
}
compdef _dirs d
# If you want to preserve (and don't want to alter) the existing definition, you can use that approach:
# prmptcmd() { eval "$PROMPT_COMMAND" }
# precmd_functions=(prmptcmd)


autoload -Uz chpwd_recent_dirs  cdr add-zsh-hook  # -U: suppress alias expansion for functions
add-zsh-hook chpwd chpwd_recent_dirs

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH


# 改变目录后 自动ls
function list_all_after_cd() {
# if [[ $PWD != '/home/' ]]; then
    print -Pn "\e]2;%~\a" #在terminal的tittle显示路径
    emulate -L zsh
    \ls -gGhtrFB --color=always --classify $* | cut -c 14- | tail -5
	tmp=$((`\ls -l | wc -l`-1-5)) #文件总数: `\ls -l | wc -l`-1
	if [ $tmp -lt 0 ]; then
        echo "------no more files--------"
	else
        echo "--------未显示文件数：$tmp---------"
	fi
}
# $chpwd_functions:  shell parameter
# This is an array of function names.
# All of these functions are executed `in order` when changing the current working directory.
chpwd_functions=(${chpwd_functions[@]} "list_all_after_cd")


# done附近报错：
## 整理 PATH，删除重复路径:
# if [ -n "$PATH" ]; then
#     old_PATH=$PATH:; PATH=
#     while [ -n "$old_PATH" ]; do
#         x=${old_PATH%%:*}
#         case $PATH: in
#            *:"$x":*) ;;
#            *) PATH=$PATH:$x;;
#         esac
#         old_PATH=${old_PATH#*:}
#     done
#     PATH=${PATH#:}
#     unset old_PATH x
# fi