autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

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

setopt HIST_IGNORE_ALL_DUPS

bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

alias awsume="source \$(pyenv which awsume)"
alias cfg="$CFG_COMMAND_OPTIONS /usr/bin/git"
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

eval $(thefuck --alias)
eval "$(pyenv init -)"
