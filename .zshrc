# todo 有人说，这样可以避免不明alias干扰
# unalias -a

# 敲`zsh 某.sh`时，这里的东西全都不起作用. 放心覆盖built-in命令

# export 了某个变量后，再从.zsrhc删除对应的代码，再开子zsh，该环境变量还在的哦，除非另写（覆盖）
export PYTHONPATH=

export PTPYTHON_CONFIG_HOME=$HOME/dot_file/.config/ptpython
export PTIPYTHON_CONFIG_HOME=$HOME/dot_file/.config/ptpython # ptipython
export PYTHONSTARTUP=$HOME/dot_file/leo_python_startup.py

# export PAGER='bat --theme="Solarized\ \(light\)"'  # 加了双引号反而不行
export PAGER='bat --theme="Coldark-Cold"' # 导致下面的v无效，“can not 修改stdin啥的”

# less 敲v，先找VIUSAL指定的编辑器，没有再找EDITOR
export VISUAL=vim  # vscode不行
# export EDITOR=vim

export LOGURU_FORMAT="{time} | <lvl>{message}</lvl>"

export PYTHON_PRETTY_ERRORS=1

export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

export TF_CPP_MIN_LOG_LEVEL=2

# 如果因为locales无法安装，locale-gens啥的失败，报LC等错误，删掉这行：
export LC_ALL=zh_CN.UTF-8
# 待阅: https://www.linux.com/news/controlling-your-locale-environment-variables/

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH


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
autoload -U compinit # -U : suppress alias expansion for functions
compinit

setopt autocd
setopt globdots
setopt interactivecomments




autoload -U promptinit # -U: suppress alias expansion for functions
promptinit
autoload -U colors && colors
#Red, Blue, Green, Cyan, Yellow, Magenta, Black & White




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
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

zplug "rupa/z", use:z.sh # 这样不行： zplug "rupa/z", as:plugin, use:"*.sh"

# 下面这个插件，must be loaded after:
# 1. executing compinit command (让defer>= 2 )
# 2. sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# zplug "softmoth/zsh-vim-mode"
# zplug "jeffreytse/zsh-vi-mode"  # 有奇怪错误，提issue很繁琐，不用了。自己配吧。
# zplug "hchbaw/zce.zsh"


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load     # source plugins and add commands to $PATH
# zplug load --verbose

# zplug update  #需要时，自己敲
# ==================================zsh插件管理：zplug=================================]]


source $HOME/dot_file/completion.zsh
source $HOME/dot_file/history.zsh
source $HOME/dot_file/color_in_less.zsh
source $HOME/dot_file/color_in_zsh.zsh
source $HOME/dot_file/bindkey.zsh

source $HOME/dot_file/alias.zsh   # 里面有：chpwd_functions=(${chpwd_functions[@]} "list_all_after_cd")
autoload -Uz chpwd_recent_dirs  cdr add-zsh-hook  # -U: suppress alias expansion for functions
add-zsh-hook chpwd chpwd_recent_dirs




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

# =============================================================================================
# 放到zplug的东西前 会报错
# setopt ignorebraces     #  turns off csh-style brace ({)   expansion.  不知道哪里复制来的
# 设置前后：
#  echo x{y{z,a},{b,c}d}e
            # xyze xyae xbde xcde

#  echo x{y{z,a},{b,c}d}e
            # xyze xyae xbde xcde
# =============================================================================================


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

if [ -z "$TMUX" ]; then
    echo $DISPLAY > ~/.t/display.txt
fi

dis_tmux(){
    export DISPLAY=$(cat ~/.t/display.txt) # todo DISPLAY还是空白
}
