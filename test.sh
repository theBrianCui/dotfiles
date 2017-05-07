#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # get the absolute location of this shell script, where the synced dotfiles are
olddir=~/dotfiles_old             # old dotfiles backup directory

cd $dir

# create dotfiles_old in homedir
echo "Creating $olddir to backup existing dotfiles."
mkdir -p $olddir

for file in .[^.]* ; do
    echo $file
    if [ ".git" != $file ] \
        && [ ".DS_STORE" != $file ] \
        && [ ".osx" != $file ]; then

        if [ -e ~/$file ]; then
            echo "Moving old $file into to $olddir."
            mv ~/$file $olddir/
        fi

        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/$file
    fi
done
