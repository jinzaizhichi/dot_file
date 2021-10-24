# [[--------------------------------ls color-------------------------------------

 # See man dircolors for the command, and man dir_colors for the configuration file syntax.
LS_COLORS=''
LS_COLORS=$LS_COLORS:'ex=00'          # Executable file
LS_COLORS=$LS_COLORS:'no=0'           # Normal text
LS_COLORS=$LS_COLORS:'*.csv=00'
LS_COLORS=$LS_COLORS:'*.txt=0'        # Plain/Text

LS_COLORS=$LS_COLORS:'fi=47;30'       # Regular file
LS_COLORS=$LS_COLORS:'di=30'          # Directory
#不行
#LS_COLORS=$LS_COLORS:'_*_=0'        # Plain/Text

#stiky
LS_COLORS=$LS_COLORS:'tw=34;4'
LS_COLORS=$LS_COLORS:'ow=34;4'


LS_COLORS=$LS_COLORS:'ln=34;4'       # Symbolic link
LS_COLORS=$LS_COLORS:'or=01;05;31'    # broken  link

LS_COLORS=$LS_COLORS:'*.md=30;47'
LS_COLORS=$LS_COLORS:'*.py=47;33'
LS_COLORS=$LS_COLORS:'*.vim=34'
LS_COLORS=$LS_COLORS:'*.json=36;47'
LS_COLORS=$LS_COLORS:'*.swp=00;44;37' # Swapfiles (Vim)

LS_COLORS=$LS_COLORS:'*.c=1;33'       # Sources
LS_COLORS=$LS_COLORS:'*.C=1;33'       # Sources
LS_COLORS=$LS_COLORS:'*.h=1;33'       # Sources

LS_COLORS=$LS_COLORS:'*.jpg=1;32'     # Images
LS_COLORS=$LS_COLORS:'*.jpeg=1;32'    # Images
LS_COLORS=$LS_COLORS:'*.JPG=1;32'     # Images
LS_COLORS=$LS_COLORS:'*.gif=1;32'     # Images
LS_COLORS=$LS_COLORS:'*.png=1;32'     # Images

LS_COLORS=$LS_COLORS:'*.tar=31'       # Archive
LS_COLORS=$LS_COLORS:'*.tgz=1;31'       # Archive
LS_COLORS=$LS_COLORS:'*.gz=1;31'        # Archive
LS_COLORS=$LS_COLORS:'*.xz=1;31'        # Archive
LS_COLORS=$LS_COLORS:'*.zip=31'       # Archive
LS_COLORS=$LS_COLORS:'*.bz2=1;31'       # Archive
LS_COLORS=$LS_COLORS:'*.bz2=1;31'       # Archive

LS_COLORS=$LS_COLORS:'*.html=36'      # HTML
LS_COLORS=$LS_COLORS:'*.htm=1;34'     # HTML

LS_COLORS=$LS_COLORS:'*.sh=32'     # Shell-Scripts
LS_COLORS=$LS_COLORS:'*.n=36'

export LS_COLORS
# --------------------------------ls color-------------------------------------]]


