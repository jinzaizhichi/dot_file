# 改了这文件，要新开zsh才生效
#[[[--------------------------------less color-------------------------------------

# termcap(被淘汰了) terminfo
# ks                smkx      make the keypad send commands
# ke                rmkx      make the keypad send digits

# vb                flash     emit visual bell
# mb                blink     start blink
# me                sgr0      # turn off bold, blink and underline
# so                smso      start standout (reverse video)
# se                rmso      stop standout
# us                smul      start underline
# ue                rmul      stop underline

export LESS_TERMCAP_md=$(tput bold; tput setaf 22) # Stop bold effect.
export LESS_TERMCAP_me=$(tput sgr0)  # turn off bold, blink and underline


# export LESS_TERMCAP_so=$(tput bold; tput setaf "#ff0000";   # 只支持256色
# 更新:
# todo
# Terminfo has supported the 24-bit TrueColor capability since ncurses-6.0-20180121, under the name "RGB".
# You need to use the "setaf" and "setab" commands to set the foreground and background respectively.

export LESS_TERMCAP_so=$(tput bold; tput setaf 37; tput setab 255)  # stand-out (reverse text).
export LESS_TERMCAP_se=$(tput rmso; tput sgr0) # Stop stand-out effect  和下面这行效果一样？


export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 54) # Underline effect Start
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)  # Stop underline effect.

# todo 有些蓝色字后面的字是灰的 dim？
# 不知道是啥：
# export LESS_TERMCAP_mr=$(tput rev)
# export LESS_TERMCAP_mh=$(tput dim)
# export LESS_TERMCAP_ZN=$(tput ssubm)
# export LESS_TERMCAP_ZV=$(tput rsubm)
# export LESS_TERMCAP_ZO=$(tput ssupm)
# export LESS_TERMCAP_ZW=$(tput rsupm)
# export GROFF_NO_SGR=1         # For Konsole and Gnome-terminal



# https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
# export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --no-init '

# 不能用\换行
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=2'
# export LESS='-R --use-color -Dd+r$Du+b'
# Man-db passes extra options to the pager via the `LESS` environment variable,
# which Less interprets in the same way as command line options.
# The setting is hard-coded at compile time and starts with -i.
# (The value is "-ix8RmPm%s$PM%s$" as of Man-db 2.6.2; the P…$ part is the prompt string.)

# Get color support for 'less'
# export LESS="--RAW-CONTROL-CHARS"


# --------------------------------less color-------------------------------------]]]

