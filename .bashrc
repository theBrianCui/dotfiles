# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[38;5;9m\]\w\[\033[00m\]\$ '
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# finally, a place for all my stuff
dropbox=""
onedrive=""
workspace=""
hostname=$(hostname)
case "$hostname" in
    "MONOLITH-RYZEN")
        dropbox="/mnt/c/Users/Brian/Dropbox/"
        onedrive="/mnt/c/Users/Brian/OneDrive/"
        workspace="/mnt/c/Users/Brian/workspace/" ;;
    "X1")
        dropbox="/mnt/c/Users/brian/Dropbox/"
        onedrive="/mnt/c/Users/brian/OneDrive/"
        workspace="/mnt/c/Users/brian/workspace/" ;;
    "ubuntu-x1-vmw" | "ubuntu-monolith-vmw")
        dropbox="/mnt/hgfs/Dropbox/"
        onedrive="/mnt/hgfs/OneDrive/"
        workspace="/home/brian/workspace/" ;;
esac

export dropbox
export onedrive
export workspace

function workspace {
    if [[ "$workspace" != "" ]]
    then
        cd "$workspace"
        return 0
    fi
    cd "$HOME/workspace"
}

# always ls after cd
function cd {
    builtin cd "$@" && ls -aF
}

# make a directory and cd
function mkcd {
    mkdir "$@" -p && builtin cd "$@"
}

# trim whitespace in a file
function tws {
    sed -i 's/[[:space:]]*$//' "$@"
}

# grep through history
function hgrep {
    history | grep "$@" | head -n -1
}

# what's my ip?
function whatsmyip {
    ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'
}

# mount a VirtualBox shared folder
function vbmount {
    if [[ $# -eq 0 ]] ; then
        echo "usage: vbmount <SHARED-DIR-NAME> <LOCAL-DIR>"
        return
    fi
    mkdir -p "$2" && sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) "$1" "$2"
}

# print on the CS lab machine
# usage: `csprint <FILE> <printer-number> [d]`
function csprint {
    # $0 will be /bin/bash
    # $1 will be filename
    # $2 will be printer number
    # $3 if set to "d", prints double sided
    if [[ $# -eq 0 ]] ; then
        echo "usage: csprint <FILE> <printer-number> [d]"
        return
    fi

    if [[ "$(hostname -f)" == *'cs.utexas.edu'* ]]; then
        echo "On a lab machine."
        return
    fi

    lfilepath="$1"
    host="briancui@linux.cs.utexas.edu"
    printtmp="~/printout"

    # Copy local file into remote directory
    ssh "$host" "mkdir -p $printtmp"
    scp "$1" "$host:$printtmp"

    # Create print command
    rfilepath="${printtmp}/$(basename $lfilepath)"
    print="lpr -Plw${2} ${rfilepath} -o sides="
    if [[ "$3" == "d" ]]; then
        print+="two-sided-long-edge"
    else
        print+="one-sided"
    fi

    # Invoke command remotely
    ssh "$host" "$print; rm $rfilepath"
    echo "$host:$print"
}

# git related aliases
function ga {
    git add "$@" && git status
}

function gcm {
    git commit -m "$@" && git status
}

function gs {
    git status "$@"
}

function gra {
    git remote add "$@"
}

function gp {
    git push "$@"
}

function gpush {
    git push "$@"
}

function gpull {
    git pull "$@"
}

function gd {
    git diff "$@"
}

function gb {
    git branch "$@"
}

function gba {
    git branch -a "$@"
}

function gsync {
    git pull && git push
}

function gcloneme {
    if [[ $# -eq 0 ]] ; then
        echo "usage: gcloneme <repo-name>"
        return
    fi

    git clone "git@github.com:theBrianCui/${1}.git"
}

function herokupush {
    if [[ $# -eq 0 ]] ; then
        echo "usage: herokupush <app-name>"
        return
    fi

    heroku git:remote -a "${1}"
    git push heroku master
}

# clipboard aliases
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"

# always start emacs in terminal mode
alias emacs="emacs -nw"

# get that ssh-agent going
ssh_agent_pid=$(pgrep -u $(whoami) ssh-agent)
if [ ! -S ~/.ssh/ssh_auth_sock ] || [ -z "$ssh_agent_pid" ] ; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

#eval $(ssh-agent)
#ssh-add
dottest='Success!'
