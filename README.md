# Oh-My-Terminal

**zsh+tmux+vim**

 ```bash
 rm -r ~/dot_file
 export ALL_PROXY=socks5://你的ip:端口
 yes | (apt-get install git) 
 cd ~ && git clone https://github.com/sisrfeng/dot_file.git && cd ~/dot_file
 bash auto_install.sh 
 ```
 ---
 ## Just for Backup
1. 【已修复】ctrl R 一直是tmux的reload的快捷键，改了~/.tmux.conf还是不行，导致vim中用不了ctrl R
2. Something strange:    
 And in `~/.zshrc`, I write `source ~/dot_file/.zshrc` then `export PS1="@ "  `    
 In `~/dot_file/.zshrc`, there was already `export PS1=">>at_here>>"`  
 Surprisingly,  `~/dot_file/.zshrc`, instead of `~/.zshrc` takes effect.    
 After removing `~/dot_file/.zshrc`, things go right.  



