# .bashrc

# keep from going insane when referencing the info pages
alias info="pinfo"
alias cls="clear"

# see what i'm looking for
export GREP_COLOR="32"
alias grep="grep --color"

# FiX up less
export LESS="-FiX"

# make sure everything uses less
export PAGER="less -FiX"

# make sure vim is used for editing stuff
export EDITOR="vim"

# set up readline preferences
export INPUTRC="~/.inputrc"
grep -qs "editing-mode" ~/.inputrc &> /dev/null || echo "set editing-mode vi" >> ~/.inputrc

# use text-mode browser whenever possible
export BROWSER="elinks"

# always use ssh for rsync'ing
export RSYNC_RSH="ssh"

# set my preferred printer for command-line stuff
# sysV-style
#export PRINTER="printername"
# bsd-style
#export LPDEST="$PRINTER"

# history options
# 1st, don't put successive, duplicate commands in history file
export HISTIGNORE="&"
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=10000

# 2nd, append each shell's history to my main history file on exit
shopt -s histappend

# just stuff I like
alias ssh='ssh -Y -C'
alias ls='ls -lh'
alias xclock='xclock -digital -update 1'
alias df='df -Ph'
alias exit='clear && exit'

# set my proxy pref's
#export HTTP_PROXY="http://username:password@host:port"
#export FTP_PROXY="$HTTP_PROXY"

# some programs expect proxy in lower-case
#export http_proxy="$HTTP_PROXY"
#export ftp_proxy="$FTP_PROXY"

# dummy-check before destroying a file (after all, i can always use -f )
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -iv"

# automatically log out of a shell after 300 seconds of idle time
#export TMOUT=300

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#export JAVA_HOME="/usr/lib/jvm/java-6-sun-1.6.0.06/"
#export CLASSPATH="/usr/lib/jvm/java-6-sun/bin/:/usr/lib/jvm/java-6-sun/jre/lib/rt.jar:/usr/lib/jvm/java-6-sun/jre/lib/comm.jar:./"
export CLASSPATH=$CLASSPATH:/usr/share/java/mysql-connector-java.jar
