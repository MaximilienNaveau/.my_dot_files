#!bin/bash

if_exist(){
    if [ -f $1 ]
    then
        $2 $1
    else
	echo $3
    fi
}

if_exist_quiet(){
    if [ -f $1 ]
    then
        $2 $1
    fi
}

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
alias cdcontrolgraph='cd /home/'$USER'/devel/workspace/src/catkin/control_graph/'
alias cdcbcom='cd /home/'$USER'/devel/workspace/src/catkin/humanoids/humanoid_hardware/cb_communication/'
alias cdathenauser='cd /home/'$USER'/devel/workspace/src/catkin/robots/athenaUser'

alias cdwritting='cd $HOME/Documents/writting'
alias cdtalk='cd $HOME/Documents/talk'

# virtual environment
#####################

alias venv_activate='if_exist_quiet ~/devel_venv/bin/activate source'
alias venv_deactivate='deactivate'

alias venv_activate3='if_exist_quiet ~/devel_venv3/devel_venv3/bin/activate source'
alias venv_deactivate3='deactivate'

# Manage cmake version
######################
alias cmake3='$HOME/Software/cmake-3.8.0-rc1/bin/cmake'
alias ccmake3='$HOME/Software/cmake-3.8.0-rc1/bin/ccmake'

# Manage working environment
############################

# roscore: make sure that ros is sourced
alias roscore='sourceindigo ; roscore'

# for ros
indigo=/opt/ros/indigo/setup.bash
kinetic=/opt/ros/kinetic/setup.bash

source_ros(){
    if [ -f $kinetic ]; then
	source $kinetic
    elif [ -f $indigo ]; then
	source $indigo
    else
	echo "no file $indigo or $kinetic found"
    fi    
}

alias roscore='source_ros ; roscore'
alias sourceros='source_ros'

launch_roscore(){
    sourceros
    roscore
}
alias roscore='launch_roscore'

source_decomposed_workspace(){
    venv_activate
    sourceros
    if_exist $1'workspace_ros/devel/setup.bash' source "ERROR: cannot source $1workspace_ros/devel/setup.bash"
    if_exist $1'workspace_core_robotics/devel/setup.bash' source "ERROR: cannot source $1workspace_core_robotics/devel/setup.bash"
    if_exist $1'workspace/devel/setup.bash' source "ERROR: cannot source $1workspace/devel/setup.bash"
    if_exist ~/.bash_robotpkg source "ERROR: ~/.bash_robotpkg does not exists"
}

install_robotpkg_python2(){
    source ~/.bash_local/install_robotpkg2
}

install_robotpkg_python3(){
    source ~/.bash_local/install_robotpkg3
}

source_workspace(){
    if [ $2 = 2 ]
    then
        venv_activate
        if_exist ~/.bash_robotpkg source "ERROR: ~/.bash_openrobots does not exists"
        sourceros
        cd $1/workspace && catkin profile set python2 && catkin config && cd -
    else
        venv_activate3
        if_exist ~/.bash_robotpkg source "ERROR: ~/.bash_openrobots does not exists"
        sourceros
        cd $1/workspace && catkin profile set python3 && catkin config && cd -
    fi
    develworkspace=$1'workspace/devel/setup.bash'
    if_exist $develworkspace source "ERROR: no ros workspace in $develworkspace"
}

alias sourcedevelworkspace='source_workspace /home/'${USER}'/devel/ 3'

# visual studio code
alias visual_studio_code='/usr/share/code/code --unity-launch'

# Some git aliases
##################

alias gits='git status'
alias gitl='git logg'
alias gitp='git push'
alias gitf='git fetch'

#echo "~/.bash_aliases sourced"

# Matlab aliase
###############
alias matlab=/is/software/matlab/linux/R2017a/bin/matlab

# SSH
#####
# ssh laas
alias sshaddlaas='ssh-add ~/.ssh/laas/id_rsa'

# start an agent and add a key
ssh_init(){
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
}
alias sshinit='ssh_init'

# Eclipse
#########
alias eclipse='~/eclipse/java-oxygen/eclipse/eclipse'
