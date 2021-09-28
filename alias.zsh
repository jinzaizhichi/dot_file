# todo 函数名不要起一两个字，不然容易覆盖built-in
alias cle='clear -x'
alias pipc='pqi' # pip change
alias q='tree -L 2 --filelimit=30 | bat'

# alias git='LANG=en_GB git' # 不行

zi_leo_func(){
    # https://unix.stackexchange.com/questions/161905/adding-unzipped-files-to-a-zipped-folder

    # [[ -a FILE_NAME ]], the "! -a" asks if the file does not exist.
    # https://www.cnblogs.com/itxdm/p/If_in_the_script_determine_the_details.html
    # https://zhuanlan.zhihu.com/p/361667506

    # test 等价于 [ 你的条件 ], 这个更先进： [[ 你的条件 ]]
    if [[ -f ~/tmp_at_home.zip ]]; then
    # if [[ -f '~/zip_folder/' ]]; then   # 用引号包住文件路径，就成了string， -f判断的是file。这里才要加引号(包住的是$加上变量）： if [ "$testv" = '!' ]; then
        t ~/tmp_at_home.zip
    else
        echo "放心, tmp_at_home.zip之前不存在"
    fi

    # todo
    # zip -r foo foo --exclude \*.cpp \*.py
    # if [[ -d $2 ]]   #$2是文件或目录
    # then
        # echo 不收纳"$2" 但貌似会在压缩包里 建立一个同名目录
        # zip -r ~/tmp_at_home.zip "$1"  -x  "$2"
    # else
        # zip -r ~/tmp_at_home.zip $1
    # fi

    zip -r ~/tmp_at_home.zip $1
    # alias hl='f_hl(){ du -sh $1* | sort -h; }; f_hl'
    du -sh  ~/tmp_at_home.zip
}
alias zi=zi_leo_func

# () 含义：declaring a function.
unzip_multi(){
#  for 循环不放文件最开头 就报错，奇怪了
for x in $*
do
    #${varible:n1:n2}:截取变量varible从n1到n2之间的字符串。 类似python
    dir=${x:0:-4}
    \mkdir ${dir}
    unzip ${x} -d ${dir} && t ${x}
done
}
alias -s zip=unzip_multi

# Use [] : if you want your script to be portable across shells.
# Use [[]] : if you want conditional expressions not supported by `[]` and don't need to be portable.
alias nls='export chpwd_functions=()'
alias fv='fv(){ find . -path '~/d/docker' -prune -o -path '~/.t' -prune -o -path '/proc' -prune -o -name "*$1*" -exec ~/.squashfs-root/AppRun {} + ; }; fv'
alias h='help'
# alias cd='export chpwd_functions=() ; builtin cd' #  加了这行，就算没敲cd，chpwd_functions也废掉了


# u for use
# alias u='git clone'

# 改变目录后 自动ls
list_all_after_cd() {
# if [[ $PWD != '/home/' ]]; then
print -Pn "\e]2;%~\a" #在terminal的tittle显示路径
emulate -L zsh
\ls -gGhtrFB --color=always --classify $* | cut -c 14- | tail -5
tmp=$((`\ls -l | wc -l`-1-5)) #文件总数: `\ls -l | wc -l`-1
if [ $tmp -lt 0 ]; then
    echo "------no more files--------"
else
    echo "--------未显示文件数：$tmp---------"
fi
}
# $chpwd_functions:  shell parameter
# This is an array of function names.
# All of these functions are executed `in order` when changing the current working directory.
chpwd_functions=(${chpwd_functions[@]} "list_all_after_cd")
# alias cd='export chpwd_functions=() ; builtin cd' #  加了这行，就算没敲cd，chpwd_functions也废掉了


# 第一次用才需要
# alias p='python3 -W ignore -m pretty_errors'

function python_go(){
    chpwd_functions=()
    python3 -W ignore $*  # 打断后就不再执行下面几行
    chpwd_functions=(${chpwd_functions[@]} "list_all_after_cd")
}
alias p='python_go'
alias python='p'
alias pv='p'
alias vv='p'



# -----------------------------------------------------------------mt()---------------------------------------
# -print0: uses a null character to split file names, and
# -0:  uses it as delimiter
# stat --format ''
# %y :  time of last data `modification`
mt_leo_func(){ find $1 -type f -print0 | xargs -0 stat --format '%y 改%n' | sort -nr | head -15 | cut --delimiter=' ' --fields=1,2,4 | tac | grep :;  }
alias mt=mt_leo_func
# access time
access_time_leo_func(){ find $1 -type f -print0 | xargs -0 stat --format '%x 读%n' | sort -nr | head -15 | cut --delimiter=' ' --fields=1,2,4 | tac | grep :;  }
alias a_t=access_time_leo_func
# alias mt="modified_time(){ find $1 -type f -print0  -printf '%Cm月%Cd日   %CH:%CM:%CS    %s         %f \n'   | sort -nr | cut -d: -f2- | head -15 | tac ;  }; modified_time"
# alias st='find -type f | xargs stat --format "modify时间: %y 文件:%n" | sort -nr |cut -d " " -f 1,2,3,5 | head -20 | tac'
# | cut -d: -f2-
# todo mt现在输出的垃圾消息有点多,可以考虑：
# echo "$(stat -c '%n %A' $filename) $(date -d "1970-01-01 + $(stat -c '%Z' $filename ) secs"  '+%F %X')"
# -----------------------------------------------------------------mt()---------------------------------------

alias vsc='code'
#移到垃圾箱
alias tvsc='t'
# alias hg='history -i 1000 | bat' # 待用
alias his='noglob history -i 1000 | bat'
# 统计命令输入频率
alias hist-stat='history 0 | awk ''{print $2}'' | sort | uniq -c | sort -n -r | head -n 30'

ag_by_leo(){
echo "需要转义的字符：'#'等"
echo "这里指定的类型不搜: '~/dot_file/ag_ignore_pattern/.ignore' "
# cat ~/dot_file/ag_ignore_pattern/.ignore
echo "======================================"
echo " "
nocorrect ag \
--before=2  \
--after=2  \
--color-line-number=47 \
--color-path=1 \
--stats \
--hidden \
--all-text \
--max-count 3  \
--path-to-ignore ~/dot_file/ag_ignore_pattern/.ignore \
--silent \
"$*"
}

alias a='ag_by_leo'
alias ac='_ack(){ nocorrect ack "$*";};_ack'

#找到软链接的真实路径
alias rl='readlink -f'
#j for jump
alias j='ln -s --interactive --verbose --logical'
#logical: dereference TARGETs that are symbolic links
#alias lk='ln -s'
#
# co for command
# 代替where which type
# -v for verbose, 不过好像没用
alias co='whence -ca'
alias help=run-help

#==============================ls相关===================================
alias ls='\ls -hrt --color=always'
# alias ls='ls | awk "{print $4,$5,$6,$7, $3}"'
alias la='\ls -ACF1GhFtr --color=always --classify'
alias lc='lt -c'
alias lla='\ls -gGhtrFA --color=always'
alias lm='la | "$PAGER"'
alias lr='ls -gGhtF --color=always'
alias lt='ll -tr'
alias lx='\ls -l'
alias l.='\ls -d1 .* --color=always --classify'
alias ll='\ls -1htr --color=always --classify | head -30'
# list full:
alias lf='_l(){  \ls -gGhtrF --color=always --classify $* ; };_l'

alias l=leo_func_ls
#写成l()会报错。可能和built-in冲突了
leo_func_ls(){
    # --classify:   append indicator (one of */=>@|) to entries
    #-g  -l时不显示用户名
    \ls -g -htrF \
        --no-group \
        --color=always --classify $* \
        | cut -c 14- \
        | tail -25 \
        | sed 's/月  /月/' \
        | sed 's/月 /月_/' \
        | grep ':' --colour=always \
        | grep '月' --colour=always
    tmp=$((`\ls -l | wc -l`-1))
	if [   $tmp     -lt      25 ]
	then
		echo "--------------"
	else
        echo "--------文件数：25/${tmp}---------"
	fi
}

#==============================ls相关===================================]]


# 这个还在生效，注意别搞混。可借鉴
alias di='code -d'

# ~/.antigen/bundles/sorin-ionescu/prezto/modules/utility
md(){
    for x in $*
    do
        if [ -d "${x}" ]; then
            echo "已存在:$x"
        else
            \mkdir -p "$x"
        fi
    done
}
alias mkdir='md'

cl(){
    echo $((`\ls -l | wc -l`-1))
    }


# alias t=to_trash  # 函数后别加()
# 直接写成下面这样更好：
t() {
    the_time=$(date  +"%H时%M分-%m月%d日")
    #trash_bin1
    #命令的结果 赋值给变量.shell的数据类型只有字符串
    tb1=~/.t/${the_time}
    if [ -d ${tb1} ]; then                                  # [ your_code ]才对  [your_code]少了空格
        tb2=~/.t/${the_time}_2
        if [ -d "${tb2}" ]; then
            #万一 时间__3 也存在，就会报错，别移动文件
            tb3=~/.t/${the_time}_3
            echo "新建垃圾箱： ${tb3}"  #这里如果有单引号，$后面的值就取不出来
            md ${tb3} && mv -ft ${tb3} $*
            echo '就算看见"已存在 某某"，还是会移到这个目录，不会新建目录--时间_4'
        else
            echo "新建垃圾箱： ${tb2}"
            md ${tb2} && mv -ft ${tb2} $*
        fi
    else
        echo "新建垃圾箱：${tb1}"
        md ${tb1} ; mv -ft ${tb1} $*
    fi
    # 星号通配失败时，就算加了分号,后面的命令也不会执行"
}

# ps 表头
# USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
psu () {
        # @argv ：操作参数
        # https://perlmaven.com/argv-in-perl#:~:text=%40ARGV%20is%20just%20a%20regular%20array%20in%20Perl.,them%20one%20by%20one%20using%20an%20index%3A%20%24ARGV.
        # ps -U "${1:-$LOGNAME}" -o 'pid,%cpu,%mem,command' "${(@)argv[2-1]}"
        ps -U "${1:-$LOGNAME}" --format 'pid,%cpu,%mem,command'
}

# conda create --name new_name --clone old_name
# conda remove --name old_name --all # or its alias: `conda env remove --name old_name`

# gpustat and grep wf
alias g='gpustat  --show-user --no-header'
alias gw='g --your-name wf '
alias gwf='g --your-name wf '

alias gi='gpustat  --show-user --no-header --show-pid'
alias giw='gi --your-name wf'
alias giwf='gi --your-name wf'

# alias g="gpu | cut -d' ' -f1,8- | cut -d'|' -f2 | cut -d'/' -f1"
alias gitp='git add . ; git commit -m "wf" ; git push ; cd - ; zsh'
alias gip='git add . ; git commit -m "wf" ; git push ; cd - ; zsh'
alias au='apt update'
alias nv='nvidia-smi'
alias pid='ps -aux |grep -v grep|grep'

# PyQuickInstall
alias pq='pqi'
# count line number
#$ echo "$((20+5))"
#25
#$ echo "$((20+5/2))"
#22

alias ctp='code ~/d/tmp.py'
alias tp='vim ~/d/tmp.py'
# try tempt
alias tt='python ~/d/tmp.py'
# bd : 本地
alias bd='code ~/.zshrc ; zsh'
alias jn='jupyter notebook'
alias ci='conda install -y'
alias snp='~/dot_file/wf_snippet.py'
alias sy='cd ~/dot_file ; git pull ; git add . ; git commit -m "wf" ; git push ; cd - ; zsh'
alias tmux='$HOME/dot_file/tmux3_1_b.AppImage -L wfwfwf'

tm() {
    if [ "$1" != "" ] # or better, if [ -n "$1" ]
    then
        tmux -f ~/dot_file/tmux.conf new -s wf_$1 || tmux attach -t wf_$1  -d
    else
        tmux -f ~/dot_file/tmux.conf new -s wf_0 || tmux attach -t wf_0 -d
    fi
}

bk(){
    for my_file in $*
    do
        echo ${my_file}
        mv ${my_file} .bk_${my_file}_`date  +"%m月%d日%H时%M分"`
    done
    }

# if you used git commit -m "${1:-update}" (a parameter expansion with a default provided), then you wouldn't need the if statement at all
# gitall() {
    # git add .
    # if [ "$1" != "" ] # or better, if [ -n "$1" ]
    # then
        # git commit -m "$1"
    # else
        # git commit -m update
    # fi
    # git push
# }

# alias example='f() { echo Your arg was $1. };f'
# use anonymous function: alias example='(){ echo Your arg was $1. ;}'
# Why make an alias at all? Just call the function example


#find . -maxdepth 1 -printf '%Cm月%Cd日   %CH:%CM:%CS    %s         %f \n'
#要传参，比如用$,要用函数，不能直接用别名
# http://blog.tangzhixiong.com/post-0035-pkg-config.html

# if $1 expands to demo , then ${1%.wf_run} 把传进来的文件名的后缀wf_run扔掉
# if $1 expands to demo , then ${1%.*} expands to demo  ??
alias oc='_oc(){ g++ -g $* -o ${1%.*} `pkg-config --cflags --libs opencv` ; ./${1%.*}; };_oc'
# oc demo.cpp draw.h draw.cpp
# ./demo

alias vi='~/.squashfs-root/AppRun -u ~/dot_file/.config/nvim/init.vim'
# alias vi='~/.squashfs-root/AppRun'
alias vim='~/.squashfs-root/AppRun -u ~/dot_file/.config/nvim/init.vim'



alias v='code'
alias vp='code'   #p wf_run.py 跳到开头加个v，不用删p就能编辑

alias gr='grep'
alias ec='echo'

alias sc='scp'
alias scp='scp -r'
# alias scp='sshpass -p "你的密码" scp -r '
# tr本来是linux的builtin
# 最近15个文件
# printf 命令 指定格式

# zsh启动不了时, 并不会启动bash, 搁置
alias dk='wf_docker(){ docker start $1 ; docker exec -it $1 zsh; docker exec -it $1 bash}; wf_docker'
#都说别改动或者覆盖linux的builtin!
# 最规范的语法 alias custom-alias='command'  command 里面没空格就不用引号
# {后一定要有空格
# []  和{}内侧左右都留一个空格 不然可能报错
# [ your_code ]才对  [your_code]少了空格
# 需要vim的语法检查时，改后缀名.sh再打开
# 双引号换成单引号就不行
# alias vj='_j(){ jq -C '' $1 ; }; _j'
# 最外层用双引号也不行
# alias vj="_j(){ jq -C "" $1 |bat -R;};_j"

# 还可以用:
# n
# p
# x

# Localhost: server that is used on your own computer
w(){
if [[ -z $DISPLAY ]];then
# -z: 看是否empty
    bat $1
else
    bat $1
    cat $1 | xsel -ib
fi
}
# 没有x11时, 不启用复制功能

alias wv='w'
alias ca=cat
alias ba='bat'
alias le="less --lesskey-file=$HOME/dot_file/.lesskey"


alias vpv='vim'
alias vpp='vim'
# alias vb='vim'  修改别名 占用了
alias vbv='vim'

alias pvp='python'
alias pvv='python'
alias pbv='python'
alias pbp='python'
alias pb='python'

alias bp='b'
alias bv='b'


alias sa='chmod -R 777'  #share to all
alias t_a='t *'
# see json
alias cj='_j(){ jq -C "" $1 |bat -R; };_j'
alias sc='noglob scp -r'
alias scp='noglob scp -r'
# tac:
# Print and concatenate files in reverse (last line first)



alias dkr='docker'
alias dk='wf_docker(){ docker start $1 ; docker exec -it $1 zsh; }; wf_docker'

##tr 更合适 但它是translate命令
##q for query查询
##换行输出
##echo "${PATH//:/$'\n'}"
##echo "${fpath// /$\n}"
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e ''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'')"'


alias pt='ptpython --vi'
#alias pt='ptpython --vi --config-dir=~/dot_file/.config/ptpython'
alias pti='ptipython --vi'
alias alert='notify-send --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e ''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'')"'
alias matlab='matlab -nosplash -nodesktop'
alias ml='matlab -nosplash -nodesktop'
alias do='cd ~/dot_file/'
#不记得当时为啥加了这个
#alias sudo=''
alias va='cd ~/dot_file ; git pull ; code ~/dot_file/auto_install.sh ; git add . ;git config --global user.email liuweifengemail@163.com ; git config --global user.name sisrfeng ; git commit -m "wf" ; git push ; cd -'
alias vb='cd ~/dot_file ; git pull ; code ~/dot_file/alias.zsh ; git add . ;git config --global user.email liuweifengemail@163.com ; git config --global user.name sisrfeng ; git commit -m "wf" ; git push ; cd -;zsh'
alias vt='cd ~/dot_file ; git pull ; code ~/dot_file/tmux.conf; sy'

# i for init.vim
alias ji='code ~/dot_file/.config/nvim/init.vim; echo '改配置后记得sync' '
# 想改成vi ，但vi本来打开neovim
alias vr='cd ~/dot_file ; git pull ; code ~/dot_file/.config/nvim/init.vim ; git add . ;git config --global user.email liuweifengemail@163.com ; git config --global user.name sisrfeng ; git commit -m "wf" ; git push ; cd -;zsh'

alias jt='code ~/dot_file/tmux.conf; echo '改配置后记得sync''
# alias js='code ~/dot_file/spacevim_conf.vim; echo '改配置后记得sync''
alias s='code ~/dot_file/rc.zsh ; zsh'
alias jb='code ~/dot_file/alias.zsh; echo '改配置后记得sync''
alias ja='code ~/dot_file/auto_install.sh; echo '改配置后记得sync''


#同步
alias y='cd ~/dot_file ; git pull ; git add . ; git commit -m "wf" ; git push ; cd - ; zsh'

# alias -g ...='../..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'

# 光标
alias gb='echo -e "\033[?25h"'
#加了这行导致./build_ops.sh等执行不了
#alias alias -s sh=vi
#大小写不敏感  If you want to ignore .gitignore and .hgignore, but still take .ignore into account, use -U
alias b='pudb3'
alias db=pudb3
alias c=cp
alias cp='cp -ivr'
alias c.='cp -ivr -t `pwd`'
alias d='dirs -v | head -6'
alias df='df -h'
alias du='du -h'
#e for exit 离开代理
alias e='unset ALL_PROXY'

find_a_file(){
    find . \
    -path '/d/docker' -prune -o  \
    -path '~/.t' -prune -o       \
    -path '/proc' -prune -o      \
    -name "*$1*"  |  bat
}
alias f=find_a_file

# /proc写成/proc/据说不行
alias f/='f_2(){ find / -path '/proc' -prune -o -path '/proc' -prune -o  -name "*$1*" | grep $1;}; f_2'
alias f12='f_wf(){ find "$1" -name "*$2*" | grep $1; }; f_wf'

alias th='f_touch(){ touch $1.n; };f_touch '
# noglob
# Filename generation (globbing) is not performed on any of the words.
# 又叫 filename generation 或者 globbing，对特殊字符 *、?、[ 和 ]进行处理，试着用对应目录下存在文件的文件名来进行补全或匹配，如果匹配失败，不会进行扩展。
## 例子
#$ ls
#test1 test2 test3
#$ echo *
#test1 test2 test3
#$ echo test?
#test1 test2 test3
#$ echo test[1-3]
#test1 test2 test3
#$ echo l*
#l*

alias dkrps='docker ps -a --format "table {{.Names}} 我是分隔符 {{.Image}}  "'
alias fsh-alias=fast-theme
alias ftp='noglob ftp'
alias gc='echo "using proxy>>> ${ALL_PROXY}" ; dl ; git clone'  # dl for  dai li
alias gcc='nocorrect gcc'
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
alias gist='nocorrect gist'
# alias git='pro &&  git'
alias globurl='noglob urlglobber '
alias grep='grep --color=always'
alias hl='f_hl(){ du -sh $1* | sort -h; }; f_hl'
alias ht='houtai(){ nohup  >$1 2>&1 &; }; houtai'
alias http-serve='python3 -m http.server'
alias i='curl cip.cc'
alias k='kill -9'


alias locate='noglob locate'


alias m='\mv -iv'
alias mv='\mv -iv'
alias mm='\mv -iv -t `pwd`'
alias m.='\mv -iv -t `pwd`'

alias man='nocorrect man'

# Makes a directory and changes to it.
mcd() {
    #这么写，要放到开头才行，不然说  "done 附近有错”
    #for x in $*
    #do
        #if [ -d "${x}" ]; then
            #echo "已存在:$x"
        #else
            #\mkdir -p "$x"
        #fi
    #done

    #[[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
    #mkdir 会变成上面我自己写的md，有暂时无法解释的bug
    [[ -n "$1" ]] && \mkdir -p "$1" && builtin cd "$1"
    #-n:
#   string is not null.
}

alias mi='curl cip.cc'

alias pi='pip3 install'
alias pip='pip3'
alias po=popd
alias pu=pushd


# alias r='~/.local/bin/tldr'  # pip安装的，比apt安装的显示好些 但不翻墙就有时连不上网。。。。。
alias r='/usr/bin/tldr'

# alias rake='noglob rake'
alias rm='rm -Irv --preserve-root'
alias rmi='nocorrect rm -i'
alias rsync='noglob rsync'
# o for open (source .zsrc,  as if opening a new zsh, to make new config take effect)
alias o='source ~/.zshrc'  # 有时source后，alias就算在文件中被删了，还在"
# search alias
alias sftp='noglob sftp'
alias sl=ls
# rm safely
alias rs='rm -Irf --preserve-root'
alias to=htop
alias top=htop
alias toc='htop -s %CPU'
alias tom='htop -s %MEM'
alias type='type -a'

alias vd='vim -d'
alias wg='axel'
alias wget='echo "using axel" ; axel'
alias wgname='wget -c -O "wf_need_to_change_name"'
alias z='_z 2>&1'


# alias oc='_oc(){ g++ $* -o ${1%.*} `pkg-config --cflags --libs opencv` ; ./${1%.*}; };_oc'
# -f指定归档文件
#  -z (同 --gzip, --gunzip, --ungzip)  通过 gzip 过滤归档
# alias -s gz='wf_gz(){ tar -xzf $* ; t $* ; };wf_gz'
alias -s gz='tar -xzf'
alias -s tgz='tar -xzf'
# -j   可以处理有bz2属性的
alias -s bz2='tar -xjf'

alias -s tar='tar -xf'
alias -s tar.gz='tar -xzf'
alias -s tar.bz2='tar --extract --bzip2 --verbose -f' #-f指定文件
alias -s tar.xz='tar -xJf'

##加了这行导致./build_ops.sh等执行不了
#alias -s sh=vi
# 会导致执行不了?
# alias -s make='vim'

alias -s md=bat
alias -s log=bat
alias -s txt=bat
alias -s html=bat
alias -s yaml=bat


alias -s cpp=code
alias -s py=code
alias -s toml=code
alias -s vim=code
alias -s zsh=code
alias -s conf=code
alias -s m=code
alias -s cfg=code


if [[ -n "$TMUX" ]];
then
    alias code=vim
    alias -s cpp=vim
    alias -s py=vim
    alias -s toml=vim
    alias -s vim=vim
    alias -s zsh=vim
    alias -s conf=vim
    alias -s m=vim
    alias -s cfg=vim
fi

alias ai='apt -q install'
alias apt='apt -q -y'
alias apt-get='apt -q -y'


# unix software resoure python
# alias up='/usr/bin/python'

# 函数开头, 比如下面的echo, 前少了空格，在用这个alias时，报错zsh: parse error near `}
alias ma='mail(){ echo "done" | mutt -s "$1" 584400706@qq.com;}; mail'

# 方法名后面可以有多个空格
# 括号内可以有多个空格
# 括号可以不要，但是为了美观，建议加上括号
# 如果方法体写成一行，需要在语句后面加分号“;”
# $*表示除$0外的所有参数
# http://faculty.salina.k-state.edu/tim/unix_sg/shell/variables.html

#变量名=$(命令名)
#result=$(password_formula)
