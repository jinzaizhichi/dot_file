# [[=================================syntax color definition====================================
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -A ZSH_HIGHLIGHT_STYLES

# 不知道三位代码 什么意思
ZSH_HIGHLIGHT_STYLES[command]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[alias]=fg=111,bold
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
# =================================syntax color definition====================================]]


# [[--------------------------------ls color-------------------------------------

LS_COLORS=''
LS_COLORS=$LS_COLORS:'ex=0'          # Executable file
LS_COLORS=$LS_COLORS:'no=0'           # Normal text       = Default foreground
LS_COLORS=$LS_COLORS:'fi=35'           # Regular file      = Default foreground
LS_COLORS=$LS_COLORS:'di=30'       # Directory         = Bold, Blue

#stiky
LS_COLORS=$LS_COLORS:'tw=34;4'
LS_COLORS=$LS_COLORS:'ow=34;4'


LS_COLORS=$LS_COLORS:'ln=34;4'       # Symbolic link
LS_COLORS=$LS_COLORS:'or=01;05;31'    # broken  link
LS_COLORS=$LS_COLORS:'pi=34;4'          # Named pipe
LS_COLORS=$LS_COLORS:'so=34;4'       # Socket
LS_COLORS=$LS_COLORS:'do=34;4'       # DO
LS_COLORS=$LS_COLORS:'bd=34;4'       # Block device
LS_COLORS=$LS_COLORS:'cd=34;4'       # Character device

LS_COLORS=$LS_COLORS:'*.sh=47;31'     # Shell-Scripts
LS_COLORS=$LS_COLORS:'*.md=30;47'     # Shell-Scripts
#不行
#LS_COLORS=$LS_COLORS:'_*_=0'        # Plain/Text
LS_COLORS=$LS_COLORS:'*.vim=34'       # Vim-"Scripts"
LS_COLORS=$LS_COLORS:'*.or=34;47'       # original  用于临时放没改动的原文件
LS_COLORS=$LS_COLORS:'*.json=36;47'       # original  用于临时放没改动的原文件
LS_COLORS=$LS_COLORS:'*.swp=00;44;37' # Swapfiles (Vim)
LS_COLORS=$LS_COLORS:'*,v=5;34;93'    # Versioncontrols
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
LS_COLORS=$LS_COLORS:'*.jpeg=1;32'    # Images
LS_COLORS=$LS_COLORS:'*.tar=31'       # Archive
LS_COLORS=$LS_COLORS:'*.tgz=1;31'       # Archive
LS_COLORS=$LS_COLORS:'*.gz=1;31'        # Archive
LS_COLORS=$LS_COLORS:'*.xz=1;31'        # Archive
LS_COLORS=$LS_COLORS:'*.zip=31'       # Archive
LS_COLORS=$LS_COLORS:'*.bz2=1;31'       # Archive
LS_COLORS=$LS_COLORS:'*.html=36'      # HTML
LS_COLORS=$LS_COLORS:'*.htm=1;34'     # HTML
LS_COLORS=$LS_COLORS:'*.txt=0'        # Plain/Text
LS_COLORS=$LS_COLORS:'*.n=43;37'        # Plain/Text

export LS_COLORS
# --------------------------------ls color-------------------------------------]]


#[[[--------------------------------less color-------------------------------------

#definitions of the less termcap settings:

# LESS_TERMCAP_md: Start bold effect (double-bright).
# LESS_TERMCAP_me: Stop bold effect.
# LESS_TERMCAP_us: Start underline effect.
# LESS_TERMCAP_ue: Stop underline effect.
# LESS_TERMCAP_so: Start stand-out effect (similar to reverse text).
# LESS_TERMCAP_se: Stop stand-out effect (similar to reverse text).


# export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_so=$'\E[01;37;40m'
# export LESS_TERMCAP_us=$'\E[1;32m'

# 0    : Turn off all effects.
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'

# https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --no-init '
# export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-2'
# export LESS='-R --use-color -Dd+r$Du+b'

# --------------------------------less color-------------------------------------]]]

function wf_use_function_as_block_comment_color () {
“\e” :  escape sequence.
“m”  :end of the command.
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

00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
NORMAL 00 # no color code at all
FILE 00 # regular file: use no color at all
RESET 0 # reset to "normal" color
MULTIHARDLINK 00 # regular file with more than one link
FIFO 40;33 # pipe
SOCK 01;35 # socket
DOOR 01;35 # door
BLK 40;33;01 # block device driver
CHR 40;33;01 # character device driver
ORPHAN 40;31;01 # symlink to nonexistent file, or non-stat'able file ...
MISSING 00 # ... and the files they point to
SETUID 37;41 # file that is setuid (u+s)
SETGID 30;43 # file that is setgid (g+s)
CAPABILITY 30;41 # file with capability
STICKY_OTHER_WRITABLE 30;42 # dir that is sticky and other-writable (+t,o+w)
OTHER_WRITABLE 34;42 # dir that is other-writable (o+w) and not sticky
STICKY 37;44 # dir with the sticky bit set (+t) and not other-writable
# This is for files with execute permission:
EXEC 01;32

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
bright_green   = '\033[1;32M'
bright_yellow  = '\033[1;33M'
bright_blue    = '\033[1;34M'
bright_magenta = '\033[1;35M'
bright_cyan    = '\033[1;36M'
bright_white   = '\033[1;37M'

black_background   = '\033[40M'
red_background     = '\033[41M'
green_background   = '\033[42M'
yellow_background  = '\033[43M'
blue_background    = '\033[44M'
magenta_background = '\033[45M'
cyan_background    = '\033[46M'
white_background   = '\033[47M'

}
