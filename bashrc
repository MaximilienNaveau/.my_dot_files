#!/bin/bash

# only run the following on interactive shells
##############################################
if [ -z "$PS1" ]; then
   return
fi

# Manage the history
####################
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

export PROMPT_COMMAND="history -a ; history -c ; history -r ; $PROMPT_COMMAND"

# set the printer name
######################
export PRINTER=davinci

# update the values of LINES and COLUMNS.
#########################################
# check the window size after each command and, if necessary,
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
###################################################################
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set the fancy prompt
######################
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# manage PATH
#############

# add_to_env is a function that modify a BASH env var
# it will add a user defined path and check if it already exist.
# if so the function does nothing
# if not the function adds the given path to the env var
#   USAGE : add_to_env $arg1 $arg2
#   $arg1 is the path to add
#   $arg2 is the BASH environment to modify 
add_to_env(){
    if [ "$#" -ne 2 ]
    then
	echo "Illegal number of parameters"
    else
	envVar=$1
	pathToAdd=$2
	if [[ :${!envVar}: == *:$pathToAdd:* ]] ; then
	    echo "$pathToAdd is already in the $envVar"
	else
	    export $envVar=$pathToAdd:${!envVar}
	fi
#	echo "$pathToAdd $envVar=${!envVar}" 
    fi
}

append_to_env(){
    if [ "$#" -ne 2 ]
    then
	echo "Illegal number of parameters"
    else
	envVar=$1
	pathToAdd=$2
	if [[ :${!envVar}: == *:$pathToAdd:* ]] ; then
	    echo "$pathToAdd is already in the $envVar"
	else
	    export $envVar=${!envVar}:$pathToAdd
	fi
#	echo "$pathToAdd $envVar=${!envVar}" 
    fi
}

# master pdf editor
add_to_env PATH ~/Software/master-pdf-editor-4

# QtCreator
add_to_env PATH ~/Software/Qt/Tools/QtCreator/bin

# Set fancy aliases
###################
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Manage completion
###################
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# autocompletion git
if [ -f $HOME/.git-completion.bash ]; then
    source $HOME/.git-completion.bash
fi

# setup robotpkg
################
source ~/.bash_robotpkg

# setup ccache
##############
source ~/.bash_ccache

# Gurobi
########
#source ~/.bash_gurobi

# SNOPT python "not working"
############################
#add_to_env SNOPT7 $HOME/devel/workspace/build/catkin/third_party/snopt_cpp/snopt_extern/snopt7
#add_to_env LD_LIBRARY_PATH $HOME/devel/workspace/build/catkin/third_party/snopt_cpp/snopt_extern/lib
#add_to_env PYTHONPATH $HOME/.local/lib/python2.7/site-packages

# local install (IPOPT, ...)
add_to_env LD_LIBRARY_PATH $HOME/Software/install/lib
add_to_env PYTHONPATH $HOME/Software/install/lib/python

add_to_env PYTHONPATH $HOME/devel/workspace/src/catkin/wip/nmpc_multicontact/python

# hack to keep a bash open when starting it with a command
[[ $startup_cmd ]] && { declare +x "$startup_cmd"; eval "$startup_cmd"; }
