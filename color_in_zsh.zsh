# [[===========================插件 zsh-syntax-highlighting的syntax color definition====================================
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -A ZSH_HIGHLIGHT_STYLES

# ASCII
# 这里不是css的方式：
# CSS 里颜色值可以用#FFFFFF的方式表示, 对于rrggbb格式的颜色值可以用#rgb格式的简写表示.
# 不够6位的颜色值按 rgb=rrggbb的方式,自动扩展成6位颜色值
# 比如
# FFFFFF = #FFF  #00000 = #000
ZSH_HIGHLIGHT_STYLES[command]=fg=yellow,bold
# 左右两边同时开了个zsh，一个紫色 一个蓝色..
ZSH_HIGHLIGHT_STYLES[alias]=fg=33,bold
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=cyan
ZSH_HIGHLIGHT_STYLES[path]=fg=110,underline,bold
# ZSH_HIGHLIGHT_STYLES[assign]=111,bold 没变

# ZSH_HIGHLIGHT_STYLES[default]=none
# ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
# ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
# ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
# ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold
# ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
# ZSH_HIGHLIGHT_STYLES[commandseparator]=none
# ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
# ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
# ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
# ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
# ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
# ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009

# ZSH_HIGHLIGHT_STYLES[default]:=none
# ZSH_HIGHLIGHT_STYLES[unknown-token]:=fg=red,bold
# ZSH_HIGHLIGHT_STYLES[reserved-word]:=fg=yellow
# ZSH_HIGHLIGHT_STYLES[precommand]:=fg=green,underline
# ZSH_HIGHLIGHT_STYLES[commandseparator]:=none
# ZSH_HIGHLIGHT_STYLES[autodirectory]:=fg=green,underline
# ZSH_HIGHLIGHT_STYLES[path]:=underline
# ZSH_HIGHLIGHT_STYLES[path_pathseparator]:=
# ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]:=
# ZSH_HIGHLIGHT_STYLES[globbing]:=fg=blue
# ZSH_HIGHLIGHT_STYLES[history-expansion]:=fg=blue
# ZSH_HIGHLIGHT_STYLES[command-substitution]:=none
# ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]:=fg=magenta
# ZSH_HIGHLIGHT_STYLES[process-substitution]:=none
# ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]:=fg=magenta
# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]:=none
# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]:=none
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument]:=none
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]:=fg=magenta
# ZSH_HIGHLIGHT_STYLES[single-quoted-argument]:=fg=yellow
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument]:=fg=yellow
# ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]:=fg=yellow
# ZSH_HIGHLIGHT_STYLES[rc-quote]:=fg=cyan
# ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]:=fg=cyan
# ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]:=fg=cyan
# ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]:=fg=cyan
# ZSH_HIGHLIGHT_STYLES[assign]:=none
# ZSH_HIGHLIGHT_STYLES[redirection]:=fg=yellow
# ZSH_HIGHLIGHT_STYLES[comment]:=fg=black,bold
# ZSH_HIGHLIGHT_STYLES[named-fd]:=none
# ZSH_HIGHLIGHT_STYLES[numeric-fd]:=none
# ZSH_HIGHLIGHT_STYLES[arg0]:=fg=green
# ===========================插件 zsh-syntax-highlighting的syntax color definition====================================]]


# [[--------------------------------ls color-------------------------------------

 # See man dircolors for the command, and man dir_colors for the configuration file syntax.
LS_COLORS=''
LS_COLORS=$LS_COLORS:'ex=00'          # Executable file
LS_COLORS=$LS_COLORS:'no=0'           # Normal text   
LS_COLORS=$LS_COLORS:'*.csv=00'     
LS_COLORS=$LS_COLORS:'*.txt=0'        # Plain/Text

LS_COLORS=$LS_COLORS:'fi=47;30'       # Regular file
LS_COLORS=$LS_COLORS:'di=30'          # Directory     
#不行
#LS_COLORS=$LS_COLORS:'_*_=0'        # Plain/Text

#stiky
LS_COLORS=$LS_COLORS:'tw=34;4'
LS_COLORS=$LS_COLORS:'ow=34;4'


LS_COLORS=$LS_COLORS:'ln=34;4'       # Symbolic link
LS_COLORS=$LS_COLORS:'or=01;05;31'    # broken  link

LS_COLORS=$LS_COLORS:'*.md=30;47'    
LS_COLORS=$LS_COLORS:'*.py=47;33'
LS_COLORS=$LS_COLORS:'*.vim=34'       
LS_COLORS=$LS_COLORS:'*.json=36;47'   
LS_COLORS=$LS_COLORS:'*.swp=00;44;37' # Swapfiles (Vim)

LS_COLORS=$LS_COLORS:'*.c=1;33'       # Sources
LS_COLORS=$LS_COLORS:'*.C=1;33'       # Sources
LS_COLORS=$LS_COLORS:'*.h=1;33'       # Sources

LS_COLORS=$LS_COLORS:'*.jpg=1;32'     # Images
LS_COLORS=$LS_COLORS:'*.jpeg=1;32'    # Images
LS_COLORS=$LS_COLORS:'*.JPG=1;32'     # Images
LS_COLORS=$LS_COLORS:'*.gif=1;32'     # Images
LS_COLORS=$LS_COLORS:'*.png=1;32'     # Images

LS_COLORS=$LS_COLORS:'*.tar=31'       # Archive
LS_COLORS=$LS_COLORS:'*.tgz=1;31'       # Archive
LS_COLORS=$LS_COLORS:'*.gz=1;31'        # Archive
LS_COLORS=$LS_COLORS:'*.xz=1;31'        # Archive
LS_COLORS=$LS_COLORS:'*.zip=31'       # Archive
LS_COLORS=$LS_COLORS:'*.bz2=1;31'       # Archive
LS_COLORS=$LS_COLORS:'*.bz2=1;31'       # Archive

LS_COLORS=$LS_COLORS:'*.html=36'      # HTML
LS_COLORS=$LS_COLORS:'*.htm=1;34'     # HTML

LS_COLORS=$LS_COLORS:'*.sh=32'     # Shell-Scripts
LS_COLORS=$LS_COLORS:'*.n=36'

export LS_COLORS
# --------------------------------ls color-------------------------------------]]


wf_use_function_as_block_comment_color () {
00=none #和0一样？
01=bold
04=underscore
05=blink
07=reverse
08=concealed 隐藏

颜色表
Foreground:
30 - black
31 - red
32 - green
33 - yellow
34 - blue
35 - magenta
36 - cyan
37 - white

Background:
40 - black
41 - red
42 - green
43 - yellow
44 - blue
45 - magenta
46 - cyan
47 - white

CAPABILITY 30;41 # file with capability
OTHER_WRITABLE 34;42 # dir that is other-writable (o+w) and not sticky
STICKY 37;44 # dir with the sticky bit set (+t) and not other-writable

“\e” :  escape sequence.
“m”  :end of the command. 记作mark吧

\033[ 必须有。0是消除之前的设置 m或者M代表作用与文本，且在这里结束
black   = '\033[0;30M'
red     = '\033[0;31M'
green   = '\033[0;32M'
yellow  = '\033[0;33M'
blue    = '\033[0;34M'
magenta = '\033[0;35M'
cyan    = '\033[0;36M'
white   = '\033[0;37M'

; 给上面的颜色加粗而已
bright_black   = grey = '\033[1;30M'
bright_red     = '\033[1;31M'

black_background   = '\033[40M'

}
