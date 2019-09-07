# dotfiles
A repository for syncing all of my dotfiles using GitHub and a super simple shell script. 

To synchronize your own dotfiles on GitHub, first clone this repository (or copy `setup.sh` into a new fresh repo) and follow the instructions below.

## First-Time Setup

 0. Clone the repository.
 1. For every dotfile (and folder) you with to sync, add them to the repository (include the `.`).
 2. Run `./setup.sh`. The script will backup the dotfiles in your existing home directory into `~/dotfiles_old` and then create symbolic links from your home directory to the dotfiles in the respository.

That's it! Now whenever you update a dotfile in the repository, just commit and push your changes. Then `git pull` on every other computer to keep them in sync.

For all other machines you wish to sync your dotfiles to, just clone the repository and run `./setup.sh` once to set up the symlinks. In the future, `git push` and `git pull` to receive updates.

Making changes to dotfiles will *not* require you to run the script again, however, adding new dotfiles will require you to do so (in order to set up the new symbolic links).

## Notes

The script works by iterating through all files (and folders) in the repository which start with `.`, and then creating a symbolic link of the same name inside your home directory `~` to the location of the file in the repository, e.g. `~/.bashrc -> dotfiles/.bashrc`. The symbolic link simply points to the file's true location, and programs will traverse the symbolic link as if it were the actual file. Thus, changes to `dotfiles/.bashrc` also "update" `~/.bashrc`. Note that supplementary files `.git`, `.DS_STORE`, and `.osx` are ignored automatically by the script.

You may need to `chmod +x setup.sh` if you get a Permission Denied error when running the shell script.

In `bash`, to re-load `.bashrc` configuration without logging out, run `source ~/.bashrc`.

## Quickstart Script

The `quickstart.sh` script also included in this repository is a run-once script for setting up my complete devleoper environment on a new installation of Ubuntu. The script is responsible for installing software such as `git`, `python`, and `emacs`, generating an SSH key for GitHub, and synchronizing the dotfiles in this repository.

```
sudo wget https://raw.githubusercontent.com/theBrianCui/dotfiles/master/quickstart.sh && sudo chmod +x quickstart.sh && ./quickstart.sh
```

### WSL chmod

[https://github.com/Microsoft/WSL/issues/81#issuecomment-400597679](https://github.com/Microsoft/WSL/issues/81#issuecomment-400597679)
