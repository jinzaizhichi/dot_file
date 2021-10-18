mkdir -p /etc/apt/

mv /etc/apt/sources.list /etc/apt/sources.list.origin_useless
string=`cat /etc/issue`
if [[ $string =~ "Ubuntu 18" ]]  # regex
then
	cp -rf sources_china_ubuntu18.py /etc/apt/sources.list
fi

if [[ $string =~ "Ubuntu 20" ]]  # regex
then
	cp -rf sources_china_ubuntu20.py /etc/apt/sources.list
fi


# export ALL_PROXY=socks5://你的ip:端口
echo  'ALL_PROXY is:  ------------------begin'
echo  $ALL_PROXY
echo  'ALL_PROXY is:  -------------------end'

mv ~/.pip  ~/.pip_wf_bk
ln -s ~/dot_file/.pip/ ~/


set -x
ln -s ~/d/dot_file ~/


cat git_url.txt>>/etc/hosts
#### Ubuntu uses network-manager instead of the traditional Linux networking model. so you should restart the network-manager service instead of the network service
# /etc/rc.d/init.d/network restart
service network-manager restart

shopt -s  expand_aliases
# alias apt='apt -y -qq'
alias apt='apt -y -q'
alias pip='\pip3 -qq'
alias pip3='\pip3 -qq'
alias cp='cp -r'

\mkdir -p $HOME/.local/bin
touch "$HOME/.z" # 这是zsh的z跳转的记录文件

# upgrade可能把别人容器的依赖关系破坏了
# yes | (apt update && apt upgrade ; apt install  nscd )
yes | (apt update ; apt install  nscd )
/etc/init.d/nscd restart

ln -s ~/dot_file/.condarc ~/

[[ -d /d ]] && ln -s /d ~/d
[[ -d /opt/data/private/anaconda3 ]] && ln -s /opt/data/private/anaconda3 ~/

yes | unminimize
yes | (apt install software-properties-common)
yes | (add-apt-repository ppa:ultradvorka/ppa && apt -qq update)
yes | (apt install sudo)
alias ai='\sudo apt install -y -qq'

yes | (ai aptitude ;aptitude update -q ; ai zsh; ai progress; ai libevent-dev)
yes | (ai htop ;ai ack ;ai axel; ai intltool; ai tmux ; ai fontconfig; ai xdg-utils)
yes | (ai exiftool htop tree tzdata locales language-pack-zh-hans language-pack-zh-hans-base)
yes | (ai ctags; ai build-essential; ai cmake; ai python-dev)
yes | (ai curl  ffmpeg libsm6 libxext6)
yes | (ai python3-setuptools ;  ai xsel)
# under ubuntu16 try this:
yes | (ai language-pack-zh-hans language-pack-zh-hans-base ; ai peco wget ; ai tldr)
yes | (ai rename)
# yes | (mutt msmtp)
# touch ~/.msmtp.log



# chmod u+x nvim.appimage
# ./nvim.appimage --appimage-extract

#已经存在目录的话,会啥都不干
#目录~/.d 专门放各机器都需要且体积大的工具
rm -rf ~/.SpaceVim.d ~/.Spacevim
mkdir ~/.d
cp ./squashfs-root ~/.squashfs-root

yes |(ln -s  ~/dot_file/vimrc ~/.config/nvim/init.vim)
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


#Linux日期不准确，要更改 Linux 系统整个系统范围的时区可以使用如下命令：
locale-gen zh_CN.UTF-8
rm -f /etc/localtime &&  ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
mkdir ~/.cache
yes |(mv ~/.tmux ~/.tmux_bk ; ln -s ~/dot_file/tmux ~/.tmux)
yes |(mv ~/.config/ ~/.old_config ;  ln -s ~/dot_file/.config ~)
yes |(cp ~/dot_file/local_template_zshrc.zsh ~/.zshrc )


# 不知道和github下载的nvim是否冲突
ai python-neovim
ai python3-neovim


yes | (ai silversearcher-ag)

#应该需要手动
##需要交互; aptitude install -y postfix
postconf smtputf8_enable=no
postfix start
postfix reload
yes | (cp -rf .muttrc ~ ;cp -rf .msmtprc ~ ; touch ~/.msmtp.log)
# 修改默认python
rm /usr/bin/python
ln -s /usr/bin/python3.? /usr/bin/python
chsh -s `which zsh`



export ZPLUG_HOME=$HOME/dot_file/zplug
export ZPLUG_LOADFILE=$HOME/dot_file/zplug/zplug_loadfile.sh
git clone https://github.com/zplug/zplug $ZPLUG_HOME


mkdir -p ~/.config/nvim/pack/kite/start/kite
git clone https://github.com/kiteco/vim-plugin.git ~/.config/nvim/pack/kite/start/kite/

echo 'LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN:zh:en_US:en"'>>/etc/environment
touch /var/lib/locales/supported.d/local
echo 'en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
zh_CN.GBK GBK
zh_CN GB2312'>>/var/lib/locales/supported.d/local
locale-gen
ai fonts-droid-fallback ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming

git config --global pull.rebase true
git config --global fetch.prune true
git config --global diff.colorMoved zebra

apt-get install libatlas-base-dev
apt-get install gfortran libopenblas-dev liblapack-dev

sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.9
apt install python3.9-distutils

# 别改系统默认python啊，不然apt都会出问题
# sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
# sudo update-alternatives --config python3

# 考虑这个：
# alias p9='/usr/bin/python3.9'

yes | (ai python3.9-pip)

yes | (unset ALL_PROXY ; pip install --upgrade pip ; pip3 install --upgrade pip ; pip3 install pysocks)


pip install -r pip_useful_tool.txt
# 不删会报错
pip uninstall pynvim

echo '如果有网络问题，这2行要在 设置PROXY后，手动敲: \n
pip install -r pip_useful_tool.txt  \n
pip uninstall pynvim  \n'

# git config --global credential.helper store
zsh
