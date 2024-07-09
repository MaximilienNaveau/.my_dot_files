#! /bin/bash

declare -a git_filter=`git log --diff-filter=D --summary | grep delete `
delete_files=()
for el in $git_filter
do
    if ! [ $el = "delete" ] && ! [[ $el =~ ^-?[0-9]+$ ]] && ! [ $el = "mode" ] ; then
        delete_files=("${delete_files[@]}" $el)
        echo $el

        git filter-branch -f --index-filter "git rm -rf --cached --ignore-unmatch $el" HEAD
    fi
done

