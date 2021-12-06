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

function peco-history-selection() {
    local tac
    # GNU 'tail' can output any amount of data (some other versions of 'tail' cannot).
    # It also has no '-r' option (print in reverse), since reversing a file is really a different job from printing the end of a file;
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
        # BSD 'tail' (the one with '-r') can only reverse files that are at most as large as its buffer, which is typically 32k.
        # A more reliable and versatile way to reverse files is the GNU 'tac' command.
    fi
    # 别用系统的根目录下的peco，太老，用dot_file下的
    # -1000: 最近1000条历史
    # tac后，最新的在最上
    # cut -c 8-  去掉序号和空格
    BUFFER=$(history -i -2000 | eval $tac | cut -c 8- | $HOME/dot_file/peco --query "$LBUFFER")
    BUFFER=${BUFFER:18}  # history加了-i，显示详细时间，回车后删掉时间
    CURSOR=$#BUFFER 
    # 这个表示 数后面的字符串长度 ：$#
    # BUFFER改成其他的，不行
    # CURSOR变成小写 就不行了

     # 我没存peco的源码 “Yes, it is a single binary! You can put it anywhere you want"
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# todo : 会找不到部分历史吗
setopt histignorespace           # skip cmds w/ leading space from history

