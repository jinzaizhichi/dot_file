# Oh-My-Terminal

**zsh+tmux+vim**

 ```bash
 rm -r ~/dot_file
 export ALL_PROXY=socks5://你的ip:端口
 yes | (apt-get install git) 
 cd ~ && git clone https://github.com/sisrfeng/dot_file.git && cd ~/dot_file
 bash auto_install.sh 
 ```
 
 ## git skills
 this arrow means a soft link OR a submodule   
 ![image](https://user-images.githubusercontent.com/53520949/134790530-feaea641-0da6-4483-b311-3f8301f9629b.png)   
 git submodule:
 > github套娃(submodules)
孤单彼岸：Git中submodule的使用
如果希望git clone时，子模块代码也能获取到：
方法1:
git clone https://github.com/username/repo名字.git --recurse-submodules 
此时project-main/project-sub-1文件夹是有内容的，（但不是project-sub-1的原作者的最新版本？）

方法2：
git clone外层repo后，
git submodule init
git submodule update
拉取子模块的原作者的最新代码
在antigen套在prezto外，官方的prezto变了，antigen会自己git pull，然后使用起来受到影响？
Git submodule | Atlassian

 ---
 ## Just for Backup
1. 【已修复】ctrl R 一直是tmux的reload的快捷键，改了~/.tmux.conf还是不行，导致vim中用不了ctrl R
2. Something strange:    
 And in `~/.zshrc`, I write `source ~/dot_file/.zshrc` then `export PS1="@ "  `    
 In `~/dot_file/.zshrc`, there was already `export PS1=">>at_here>>"`  
 Surprisingly,  `~/dot_file/.zshrc`, instead of `~/.zshrc` takes effect.    
 After removing `~/dot_file/.zshrc`, things go right.  



