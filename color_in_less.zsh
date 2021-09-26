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

