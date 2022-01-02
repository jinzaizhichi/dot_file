set -x
setopt aliases
apt install -y -qq
alias ai='apt install -y -qq'
alias apt='apt -y -qq'
alias pip3='pip3 -qq'
alias cp='cp -r'

git clone --depth 1 https://github.com/junegunn/fzf.git /.fzf
/.fzf/install


ln -sf ~/dotF/.pip/ ~/
ln -sf ~/dotF/cfg/.condarc ~/
ln -sf ~/dotF/ssh/config ~/.ssh/config
ln -sf ~/dotF/cfg/git/ ~/.ssh/config
ln -sf ~/dotF/cfg/git/gitconfig ~/.gitconfig