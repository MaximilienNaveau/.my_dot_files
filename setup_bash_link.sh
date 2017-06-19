#!/bin/bash

pwd_local=$PWD
tmpname="tmp_container"
if [ -f $tmpname ]
then
    echo "no tmp_container folder"
    exit 0
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
    if [ ! -d ~/.bash_local/tmp_container ]
    then 
	mkdir tmp_container
    fi
    move ~/.bash_aliases
    move ~/.bash_ccache
    move ~/.bash_logout
    move ~/.bash_robotpkg
    move ~/.bashrc
    move ~/.bash_gurobi
    cd ~
    ln -s ~/.bash_local/bash_aliases .bash_aliases  
    ln -s ~/.bash_local/bash_ccache .bash_ccache   
    ln -s ~/.bash_local/bash_logout .bash_logout   
    ln -s ~/.bash_local/bash_robotpkg .bash_robotpkg 
    ln -s ~/.bash_local/bashrc .bashrc
    ln -s ~/.bash_local/bash_gurobi .bash_gurobi
    ln -s ~/.bash_local/bash_smartgit .bash_smartgit
fi

cd $pwd_local
