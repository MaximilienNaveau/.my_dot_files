#!/bin/bash

pwd_local=$PWD
tmpname="deprecated"

# create a deprecated folder t store the previous bash configuration
if [ ! -d ~/.bash_local/$tmpname ]
then
    echo "no folder named $tmpname, creating one"
    mkdir $tmpname
fi

move () {
    if [ -f $1 ] && [ ! -L $1 ]
    then 
	mv $1 $tmpname
    else
	echo "$1 is not a file or already a symbolik link"
    fi
} 

# if ~/.bash_local is an existing directory
if [ -d ~/.bash_local ]
then
    cd ~/.bash_local
    move ~/.bash_aliases
    move ~/.bash_ccache
    move ~/.bash_logout
    move ~/.bash_robotpkg
    move ~/.bashrc
    move ~/.bash_gurobi
    move ~/.Xresources
    move ~/.inputrc
    cd ~
    ln -s ~/.bash_local/bash_aliases .bash_aliases  
    ln -s ~/.bash_local/bash_ccache .bash_ccache   
    ln -s ~/.bash_local/bash_logout .bash_logout   
    ln -s ~/.bash_local/bash_robotpkg .bash_robotpkg 
    ln -s ~/.bash_local/bashrc .bashrc
    ln -s ~/.bash_local/bash_gurobi .bash_gurobi
    ln -s ~/.bash_local/bash_smartgit .bash_smartgit
    ln -s ~/.bash_local/Xresources .Xresources
    ln -s ~/.bash_local/inputrc .inputrc
else
    echo "~/.bash_local do not exist please move this git directory into ~/.bash_local"
fi

cd $pwd_local
