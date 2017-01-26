# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux'  ]]; then
	platform='linux'
elif [[ "$unamestr" == 'Darwin'  ]]; then
	platform='mac'
elif [[ "$unamestr" == *'_NT'*  ]]; then
	platform='windows'
fi

export GMOCKDIR=$HOME/Development/ordbogen/googletest
export GOPATH=$HOME/Development/go

export PATH=$HOME/bin:/opt/bin:$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin:$HOME/Development/kenlm/bin

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# use fancy git prompt
export GIT_PROMPT_ONLY_IN_REPO=0
if [[ "$platform" == 'mac' ]]; then
	. "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
elif [[ -f "$HOME/bash-git-prompt/gitprompt.sh" ]]; then
	. "$HOME/bash-git-prompt/gitprompt.sh"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -lh'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [[ "$platform" == 'mac' ]]; then
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		. $(brew --prefix)/etc/bash_completion
	fi
fi

if [ -f "$HOME/.workenv" ]; then
	. "$HOME/.workenv"
fi

######## REL ########
export EDITOR=vi
export GZIP="-9"
export FIGNORE='~:.o' 
export LESS="-MiQcRx4"
if [ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
elif  [ -f /usr/local/bin/src-hilite-lesspipe.sh ]; then
    export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
fi
if [[ "$platform" == 'mac' ]]; then
	export BYOBU_PREFIX=$(brew --prefix)
fi
IGNOREEOF=1
AA=1
#export SCRIPTS_ROOTDIR=/home/rel/devel/modern_translation/bin/scripts-20110304-0927
export SCRIPTS_ROOTDIR=/home/rel/modern_translation/bin/scripts-20110308-1252

#### ALIASES
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias duhome='pd ~; du -s -h; popd'
alias f='finger -m'
alias h='history'
alias l='less'
alias la='lla'
alias ll='ls -lh'
alias lla='ls -al'
alias med='gnuclient'
alias medw='gnuclientw'
# alias mvfop='fop.sh -c c:/usr/packages/fop-0.20.5/conf/userconfig.xml -xsl d:/mikrov/development/transformations/devel_fo.xsl -xml \!:1 -pdf `basename \!:1 .xml`.pdf'
# alias mvxep='xep.sh -xml \!:1 -xsl d:/mikrov/development/transformations/devel_fo.xsl -pdf `basename \!:1 .xml`.pdf'
alias penv='printenv | sort'
alias po='popd"'
alias pd='pushd'

#### FUNCTIONS
function cdll {
    cd "$1"
    ll
}

function llal {
    lla $* | l
}

function hgrep {
    history | grep $* | grep -v hgrep
}

function phpgrep {
    rgrep -nie "$1" --exclude-dir=".svn" --include="*.php" . --color
}    

function tplgrep {
    rgrep -nie "$1" --exclude-dir=".svn" --include="*.tpl" . --color
}    

function lll {
    ll $* | l
}

function x {
    chmod +x $*
}

#### UMASK
#umask 022

#### KEY BINDINGS
bind '"\C-u": kill-whole-line'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
case $TERM in
    cygwin*)
        bind '"\e[C": forward-word'
        bind '"\e\e[C": forward-word'
        bind '"\e[D": backward-word'
        bind '"\e\e[D": backward-word'
        ;;
    xterm*|rxvt*)
        bind '"\e[1;5C": forward-word'
        bind '"\e[1;3C": forward-word'
        bind '"\e[1;5D": backward-word'
        bind '"\e[1;3D": backward-word'
        ;;
esac

#### READLINE SETTINGS
bind 'set show-all-if-ambiguous on'

#### FURTHER SHELL OPTIONS
shopt -s cdable_vars
shopt -s cdspell
shopt -s no_empty_cmd_completion
