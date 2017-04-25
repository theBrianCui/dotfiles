# dotfiles
A repository for syncing all of my dotfiles. Original shell script taken from [this blog post](https://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/).

## First-Time Setup

 1. For every dotfile you with to sync, add them to the repository with the same name except for the leading `.`. Thus, `.bashrc` becomes `bashrc`, etc.
 2. Edit `setup.sh` so that the `files` variable contains the names of all the dotfiles.
 3. Run `./setup.sh`. The script will backup the dotfiles in your existing home directory into `~/dotfiles_old` and then create symbolic links to the files in this directory (where this repository is stored locally).

Anytime you wish to update a dotfile, update the file in the repository (and do a `git push`/`git pull`, etc to update the remote). Note that deleting or moving the repository location on your hard drive will destroy the destionation of the symbolic links stored in the home directory. To reload the symlinks, simply run `./setup.sh` again.

## Synchronization

Clone the repository anywhere, and then run `./setup.sh`. All the dotfiles in your home directory `~` will be symlinks to the "dotfiles" in this repository.