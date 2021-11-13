#[[[--------------------------------less color-------------------------------------

#definitions of the less termcap settings:

# LESS_TERMCAP_md: Start bold effect (double-bright).
# LESS_TERMCAP_me: Stop bold effect.
# LESS_TERMCAP_us: Start underline effect.
# LESS_TERMCAP_ue: Stop underline effect.
# LESS_TERMCAP_se: Stop stand-out effect (similar to reverse text).
#
#
#
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
# LESS_TERMCAP_so: stand-out effect (similar to reverse text).
export LESS_TERMCAP_so=$(tput bold; tput setaf 37; tput setab 255) # yellow on blue
# export LESS_TERMCAP_so=$'\E[01;37;40m'
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
export GROFF_NO_SGR=1         # For Konsole and Gnome-terminal

# export LESS_TERMCAP_md=$'\E[1;36m'
# export LESS_TERMCAP_us=$'\E[1;32m'

# 0    : Turn off all effects.
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'

# https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
# export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --no-init '
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=2'
# export LESS='-R --use-color -Dd+r$Du+b'

# Get color support for 'less'
# export LESS="--RAW-CONTROL-CHARS"


# --------------------------------less color-------------------------------------]]]

