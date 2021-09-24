unsetopt share_history
#setopt prompt_subst

# HISTTIMEFORMAT is for bash
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

setopt histignoredups
setopt histignorespace

# Peco history selection
function peco-history-selection() {
    # echo 'leo: using peco. '
    local tac
    if which tac > /dev/null; then
    tac="tac"
    else
    tac="tail -r"
    fi
    BUFFER=$(history -1000 | eval $tac | cut -c 8- | $HOME/dot_file/peco --query "$LBUFFER")
    CURSOR=$#BUFFER
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# todo : 会找不到部分历史吗
setopt histignorespace           # skip cmds w/ leading space from history