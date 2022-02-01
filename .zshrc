autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -Uz vcs_info
autoload -U colors && colors
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U predict-on

setopt HIST_IGNORE_ALL_DUPS
setopt PROMPT_SUBST

predict-on

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N predict-on
zle -N predict-off

bindkey -e # Not ready for Vi bindings yet

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='mac'
elif [[ "$unamestr" == *'_NT'* ]]; then
    platform='windows'
fi

CFG_COMMAND_OPTIONS='GIT_DIR=$HOME/.cfg GIT_WORK_TREE=$HOME'

bindkey '^X^Z' predict-on
bindkey '^Z' predict-off
# bindkey '\e[A' history-beginning-search-backward
# bindkey '\e[B' history-beginning-search-forward
bindkey '\e[A' up-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line

alias awsume="source \$(pyenv which awsume)"
alias cfg="$CFG_COMMAND_OPTIONS env git"
alias cfgtig="$CFG_COMMAND_OPTIONS tig"
alias h='history'
alias l='less'
alias la='lla'
alias ll='ls -lh'
alias lla='ls -al'
alias tf='terraform'
alias penv='printenv | sort'
alias rustdoc='rustup doc --toolchain=stable-x86_64-apple-darwin'
alias tigcfg="$CFG_COMMAND_OPTIONS tig"

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

function md2pdf {
	pandoc --variable papersize:a4 --variable geometry:margin=1in -o `basename $1 .md`.pdf $1
}

function lll {
    ll $* | l
}

function x {
    chmod +x $*
}

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi
fpath=(~/.awsume/zsh-autocomplete/ $fpath)

source $HOME/.zsh-prompt.zsh

eval $(thefuck --alias)
eval "$(pyenv init -)"
