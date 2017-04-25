# dotfiles
A repository for syncing all of my dotfiles using GitHub and a shell script. Original shell script taken from [this blog post](https://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/). To synchronize your own dotfiles on GitHub, just copy the original `setup.sh` script into your own repository (where *your* dotfiles will go, unless you really like mine), clone the repo somewhere locally, and then follow the instructions below.

## First-Time Setup

 1. For every dotfile you with to sync, add them to the repository with the same name except for the leading `.`. Thus, `.bashrc` becomes `bashrc`, etc.
 2. Edit `setup.sh` so that the `files` variable contains the names of all the dotfiles.
 3. Run `./setup.sh`. The script will backup the dotfiles in your existing home directory into `~/dotfiles_old` and then create symbolic links to the files in this directory (where this repository is stored locally). You may need to `chmod +x setup.sh` if you get a Permission Denied error.

Anytime you wish to update a dotfile, update the file in the repository (and do a `git push`/`git pull`, etc to update the remote). Note that deleting or moving the repository location on your hard drive will destroy the destination of the symbolic links stored in the home directory. To reload the symlinks, simply run `./setup.sh` again wherever the repository is stored.

## Synchronization

For all other machines you wish to sync your dotfiles to, clone the repository anywhere, and then run `./setup.sh`. All the dotfiles in your home directory `~` will be symlinks to the "dotfiles" in this repository. Then, of course, you can edit the files in the repository and `git push`/`git pull` to get the files synchronized everywhere else too.
