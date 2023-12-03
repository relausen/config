autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -Uz vcs_info
autoload -U colors && colors
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -Uz compinit

setopt HIST_IGNORE_ALL_DUPS
setopt PROMPT_SUBST

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

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

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

CFG_COMMAND_OPTIONS='GIT_DIR=$HOME/.cfg GIT_WORK_TREE=$HOME'

# bindkey '\e[A' history-beginning-search-backward
# bindkey '\e[B' history-beginning-search-forward
bindkey '\e[A' up-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
bindkey '^[^[[C' forward-word
bindkey '^ ' autosuggest-accept
bindkey '^J' autosuggest-execute

# alias awsume="source \$(pyenv which awsume)"
alias cfg="$CFG_COMMAND_OPTIONS env git"
alias cfgtig="$CFG_COMMAND_OPTIONS tig"
alias h='history'
alias l='less'
alias la='lla'
alias ll='eza -lh'
alias lla='eza -alh'
alias tf='terraform'
alias penv='printenv | sort'
alias rustdoc='rustup doc --toolchain=stable-x86_64-apple-darwin'
alias tigcfg="$CFG_COMMAND_OPTIONS tig"

function aws-profile {
    export AWS_PROFILE=$1
}

function cdll {
    cd "$1"
    ll
}

function llal {
    lla $* | l
}

function lll {
    ll $* | l
}

function hgrep {
    history | grep $* | grep -v hgrep
}

function md2pdf {
    pandoc --variable papersize:a4 --variable geometry:margin=1in -o `basename $1 .md`.pdf $1
}

function x {
    chmod +x $*
}

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
fpath+=~/.awsume/zsh-autocomplete
fpath+=~/.zfunc
autoload -Uz compinit
compinit

# Autosuggestions plugin from https://github.com/zsh-users/zsh-autosuggestions
source $HOME/.zfunc/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh-prompt.zsh

eval $(thefuck --alias)
# eval "$(pyenv init -)"
eval "$(rtx activate zsh)"
if command -v op &>/dev/null; then
    eval "$(op completion zsh)" && compdef _op op
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v neofetch &>/dev/null; then
    local backend=ascii
    echo ${TERM}
    if [[ ${TERM} == xterm-kitty ]]; then
        backend=kitty
    fi
    neofetch --backend ${backend} --size "20%"
fi
