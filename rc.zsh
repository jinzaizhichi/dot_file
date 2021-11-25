# echo "$foo" instead of just echo $foo.
# Without double-quotes the variable's contents get parsed in a somewhat weird way that tends to cause bugs.



# [[===========================================================================begin
# 为了交互使用zsh时可以 通配, 比如 mv ~/Linux/Old/^Tux.png ~/Linux/New/   (mv除了Tux.png的所有文件)
setopt extended_glob  # 可能导致这些命令出bug, 使用时要注意:   git diff HEAD^
# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc.
# (An initial unquoted ‘~’ always produces named directory expansion.)
#
#  https://www.techrepublic.com/article/globbing-wildcard-characters-with-zsh/
#
# end==============================================================================]]


# todo 有人说，这样可以避免不明alias干扰
# unalias -a

# 敲`zsh 某.sh`时，这里的东西全都不起作用. 放心覆盖built-in命令

# export 了某个变量后，再从.zsrhc删除对应的代码，再开子zsh，该环境变量还在的哦，除非另写（覆盖）

export PYTHONPATH=
export PTPYTHON_CONFIG_HOME=$HOME/dot_file/.config/ptpython
export PTIPYTHON_CONFIG_HOME=$HOME/dot_file/.config/ptpython # ptipython
export PYTHONSTARTUP=$HOME/dot_file/leo_python_startup.py

# export PAGER=less
# export PAGER='bat --theme="Solarized\ \(light\)"'  # 加了双引号反而不行
export PAGER='bat --theme="Coldark-Cold"' # 导致下面的v无效，“can not 修改stdin啥的”

# less 敲v，先找VIUSAL指定的编辑器，没有再找EDITOR
# pudb 敲ctrl E能用EDITOR打开文件编辑
export VISUAL=~/dot_file/nvim-linux64/bin/nvim  # vscode不行
export EDITOR=~/dot_file/nvim-linux64/bin/nvim   # 不用加-u 指定init.vim 因为默认就在~/.config/下
# export EDITOR="~/dot_file/nvim-linux64/bin/nvim -u ~/dot_file/.config/nvim/init.vim"

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

if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi

export PAHT="$PATH:/usr/lib/w3m/w3mimagedisplay"

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

# export TERM="xterm-256color" # Enable 256 color to make auto-suggestions look nice
# export TERM="xterm-truecolor"   # 报错

# 如果终端支持truecolor, 用之
case $TERM in
  iterm            |\
  linux-truecolor  |\
  screen-256color |\
  tmux-256color   |\
  xterm-256color  )    export COLORTERM=truecolor ;;
  vte*)
esac

fpath=(~/dot_file/zfunc_in_fpath_leo $fpath)  # zfunc_in_fpath_leo用于存放自动补全命令  要在compinit之前.
autoload -U compinit # -U : suppress alias expansion for functions
compinit

setopt autocd
setopt globdots
setopt interactivecomments




autoload -U promptinit # -U: suppress alias expansion for functions
promptinit
autoload -U colors && colors
#Red, Blue, Green, Cyan, Yellow, Magenta, Black & White


autoload -U select-word-style
select-word-style bash  # 斜杠 下划线等 会作为单词的分隔
# zplug里面的vim-mode搞鬼，导致放在zplug load后 会不起作用

# [[==================================zsh插件管理：zplug=================================
export ZPLUG_HOME=$HOME/.zplug
export ZPLUG_CACHE_DIR=$ZPLUG_HOME/.cache  # 默认就是这样
export ZPLUG_REPOS=$ZPLUG_HOME/repos  # 默认就是这样

source $ZPLUG_HOME/init.zsh

# zplug "modules/prompt", from:prezto
# use double quotes
zplug "zplug/zplug", hook-build:"zplug --self-manage"

zplug "srijanshetty/zsh-pip-completion" # 能补全pip包的名字，但没生效
zplug "zsh-users/zsh-completions"

# 避免冲突，顺序： zsh-autosuggestions > zsh-syntax-highlighting > zsh-vim-mode

zplug "zsh-users/zsh-autosuggestions"  # 弹出之前敲过的命令
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888,bg=bold"

zplug "rupa/z", use:z.sh # 这样不行： zplug "rupa/z", as:plugin, use:"*.sh"

# 下面这个插件，must be loaded after:
# 1. executing compinit command (让defer>= 2 )
# 2. sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2  # 对命令行中的目录 可执行文件等 进行语法高亮

zplug "zsh-users/zsh-history-substring-search"  # 要在syntax-highlighting后面  , 在我建的bindky.zsh里面改快捷键

# zplug "jeffreytse/zsh-vi-mode"  # 有奇怪错误，提issue很繁琐，不用了。自己配吧。
#

zplug "softmoth/zsh-vim-mode"


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


# 放在插件管理后面，避免被别人的配置覆盖
source $HOME/dot_file/color_highlight_style.zsh
source $HOME/dot_file/color_completion_of敲tab.zsh  #  不只是颜色, 但为了想改颜色时容易找，这么命名。
source $HOME/dot_file/color_ls.zsh
source $HOME/dot_file/color_less.zsh


source $HOME/dot_file/bindkey.zsh
source $HOME/dot_file/history.zsh

source $HOME/dot_file/alias.zsh   # 里面有：chpwd_functions=(${chpwd_functions[@]} "list_all_after_cd")
autoload -Uz chpwd_recent_dirs  cdr add-zsh-hook  # -U: suppress alias expansion for functions
add-zsh-hook chpwd chpwd_recent_dirs


alias -- -='cd -'

function d () {
    dirs -v | head -10
}
compdef _dirs d
# If you want to preserve (and don't want to alter) the existing definition, you can :
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
dis_tmux

# if [[ -z  $DISPLAY ]]; then
#    echo "if DISPLAY isn't set, it's no use setting it manually"
# fi



# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
# compctl -K _pip_completion /data/wf/anaconda3/envs/py38_torch18/bin/python3 -m pip
compctl -K _pip_completion pip
compctl -K _pip_completion pip3

# pip zsh completion end
