# dotfiles
A repository for syncing all of my dotfiles using GitHub and a super simple shell script. To synchronize your own dotfiles on GitHub, first clone this repository (or directly steal `setup.sh` into a new fresh repo) and follow the instructions below.

## First-Time Setup

 0. Clone the repository locally.
 1. For every new dotfile (and folder) you with to sync, add them to the root of the repository with the same name (include the `.`).
 2. Run `./setup.sh`. The script will backup the dotfiles in your existing home directory into `~/dotfiles_old` and then create symbolic links from your home directory to the dotfiles in the respository.

That's it! Now whenever you update a dotfile in the repository (or `git pull` new changes), your "dotfiles" (actually symbolic links) in `~` will get updated too. You may need to `chmod +x setup.sh` if you get a Permission Denied error when running the shell script.

For all other machines you wish to sync your dotfiles to, just clone the repository and run `./setup.sh` to set up the symlinks. Making changes will *not* require you to run the script again, however, adding new dotfiles will require you to do so.

## Notes

The script works by iterating through all files (and folders) in the repository which start with `.`, and then creating a symbolic link of the same name inside your home directory `~` to the location of the file in the repository, e.g. `~/.bashrc -> dotfiles/.bashrc`. The symbolic link simply points to the file's true location, and programs will traverse the symbolic link as if it were the actual file. Thus, changes to `dotfiles/.bashrc` also "update" `~/.bashrc`. Note that supplementary files `.git`, `.DS_STORE`, and `.osx` are ignored automatically by the script.

In `bash`, to re-load `.bashrc` configuration without logging out, run `source ~/.bashrc`.
