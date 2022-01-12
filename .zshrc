autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -Uz vcs_info
autoload -U colors && colors

setopt HIST_IGNORE_ALL_DUPS
setopt PROMPT_SUBST

right_angle=$'\Ue0b0'

zstyle ':vcs_info:*+*:*' debug false
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr S
zstyle ':vcs_info:*' unstagedstr U
zstyle ':vcs_info:git*' formats $'\Ue0a0 %b|%m%c%u'
precmd() {
    vcs_info
    common_part="%{$bold_color%}%{$bg[blue]%}%{$fg[yellow]%} %~ %{$reset_color%}%{$fg[blue]%}"
    if [[ -n ${vcs_info_msg_0_} ]]; then
        PS1=$'${common_part}%{$bg[green]%}${right_angle}%{$fg[black]%} ${vcs_info_msg_0_} %{$bg[black]%}%{$fg[green]%}${right_angle}%{$reset_color%}\n%# '
    else
        PS1=$'${common_part}%{$bg[black]%}\Ue0b0%{$fg[black]%} %{$reset_color%}\n%# '
    fi
}
# PROMPT=$'%B%F{yellow}%~%f%b [${vcs_info_msg_0_}]\n%f%# '

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

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line

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
