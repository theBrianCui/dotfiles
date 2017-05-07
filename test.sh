#!/bin/bash
<<README

This script creates symbolic links from dotfiles in your home directory
to any and all of the dotfiles (incl. directories) stored in this repository.
Old dotfiles will get backed up to ~/dotfiles_old before they are overwritten.

README


# $dir is the absolute location of this shell script, where the synced dotfiles are
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 
olddir=~/dotfiles_old # old dotfiles backup directory
cd $dir

# create dotfiles_old in homedir
echo "Creating $olddir to backup existing dotfiles."
mkdir -p $olddir

# iterate through all dotfiles
for file in .[^.]* ; do
    # filter out common but unwanted dotfiles
    if [ ".git" != $file ] \
        && [ ".DS_STORE" != $file ] \
        && [ ".osx" != $file ]; then

        # backup existing dotfile (or symlink?) if any
        if [ -e ~/$file ] || [ -L ~/$file ]; then
            echo "Moving old $file into to $olddir."
            # may need to delete before moving, cannot replace directory with non-directory
            rm -rf $olddir/$file 
            mv ~/$file $olddir/
        fi

        # link dotfile from home -> $dir
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/$file
    fi
done
