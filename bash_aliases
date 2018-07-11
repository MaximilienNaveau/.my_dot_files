#!bin/bash

# Manage nice personnal aliases
###############################

# Set up some useful short versions of often used commands.
alias cpfr='cp -fr'
#alias cp='cp -i'
alias dir='ls -1 -F -t -l \!* | more'
#alias fi='find . \( -name "\!*" \) -print'
alias imake='imake -I$LAB_ROOT/imake -TLAB_Imake.tmpl -D$MACHTYPE'
alias ls='ls -F --color=auto'
alias l='ls -F --color=auto'
alias ll='ls -alF --color=auto'
alias mv='mv -i'
alias rm='rm -i'

# Set handy command
alias emacsbashrc='emacs $HOME/.bashrc'
alias emacsaliases='emacs $HOME/.bash_aliases'
alias sourcebashrc='source $HOME/.bashrc'
alias sourcealiases='source $HOME/.bash_aliases'

# color for grep
alias grep='grep --color=auto'

# cd aliases
alias cddevel='cd /home/'$USER'/devel/workspace'
alias cdsrc='cd /home/'$USER'/devel/workspace/src/catkin'
alias cdhumanoid='cd /home/'$USER'/devel/workspace/src/catkin/humanoids/humanoid_control/'
alias cdathenauser='cd /home/'$USER'/devel/workspace/src/catkin/robots/athenaUser'

alias cdwritting='cd $HOME/Documents/writting'
alias cdtalk='cd $HOME/Documents/talk'

# virtual environment
#####################

alias venv_activate='source /home/$USER/devel/devel_venv/bin/activate'
alias venv_deactivate='deactivate'

# Manage cmake version
######################
alias cmake3='$HOME/Software/cmake-3.8.0-rc1/bin/cmake'
alias ccmake3='$HOME/Software/cmake-3.8.0-rc1/bin/ccmake'

# Manage working environment
############################

# reset PATH
#alias resetbash='export PATH=/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin

# roscore: make sure that ros is sourced
alias roscore='sourceindigo ; roscore'

# for ros
indigo=/opt/ros/indigo/setup.bash
alias sourceindigo='if [ -f $indigo ]; then
        source $indigo
else
	echo "no file $indigo"
fi'

if_exist(){
    if [ -f $1 ]
    then
        $2 $1
    else
	echo $3
    fi
}

source_devel_workspace(){
    venv_activate
    sourceindigo
    develworkspace='/home/'$USER'/devel/workspace/devel/setup.bash'
    if_exist $develworkspace source "no ros workspace in $develworkspace"
    add_to_env PATH /home/$USER/devel/amd-clmc/scripts
}
alias sourcedevelworkspace='source_devel_workspace'

source_eth_workspace(){
    sourceindigo
    workspace='/home/'$USER'/devel/eth_workspace/devel/setup.bash'
    if_exist $workspace source "no ros workspace in $workspace"
}
alias sourceethworkspace='source_eth_workspace'


# Some git aliases
##################

alias gits='git status'
alias gitl='git logg'
alias gitp='git push'
alias gitf='git fetch'

# Qtcreator dark style
######################
qtcreator_devel(){
    source_devel_workspace
    qtcreator
}
alias qtcreator='qtcreator_devel'
alias qtcreator_dark_scheme='qtcreator -stylesheet=~/Software/Qt-Creator-Darcula/darcula.css'


#echo "~/.bash_aliases sourced"

# Matlab aliase
###############
alias matlab=/is/software/matlab/linux/R2017a/bin/matlab

# SSH
#####
# ssh laas
alias sshaddlaas='ssh-add ~/.ssh/laas/id_rsa'

# Eclipse
#########
alias eclipse='~/eclipse/java-oxygen/eclipse/eclipse'
