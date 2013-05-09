# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Add git branch coloring
function _git_prompt() {
local git_status="`git status -unormal 2>&1`"
if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
if [[ "$git_status" =~ nothing\ to\ commit ]]; then
local ansi=42
elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
local ansi=43
else
local ansi=45
fi
if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
branch=${BASH_REMATCH[1]}
test "$branch" != master || branch='master'
else
# Detached HEAD. (branch=HEAD is a faster alternative.)
branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
echo HEAD`)"
fi
echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
fi
}
function _prompt_command() {
PS1="`_git_prompt`"'\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
}
PROMPT_COMMAND=_prompt_command

# Add an "alert" alias for long running commands.  Use like so:
alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
alias s='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "[$?] $(alert_helper)"; espeak -v en "Task complete: $(alert_helper)"'


# Some useful environment variables
export JAVA_HOME=/work/env/jdk1.7.0_10
export JDK_HOME=$JAVA_HOME
export M2_HOME=/work/env/apache-maven-3.0.4
export SCRIPTED_HOME=/work/env/scripted-editor
export IDEA_HOME=/work/env/idea-IC-129.161
export PATH=$PATH:~/bin/:~/gradlek-1.0/bin/:/work/apps/q:$JAVA_HOME/bin:/opt/vagrant/bin:$M2_HOME/bin:$SCRIPTED_HOME/bin:$IDEA_HOME/bin


export PATH=/work/env/SenchaSDKTools-1.2.3:$PATH
export PATH=/work/env/SenchaSDKTools-1.2.3/command:$PATH
export PATH=/work/env/SenchaSDKTools-1.2.3/jsbuilder:$PATH
export PATH=/work/env/SenchaSDKTools-1.2.3/appbuilder:$PATH

alias git=hub

source /home/tal/.rvm/scripts/rvm



PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
