autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -Uz vcs_info
autoload -U colors && colors

setopt HIST_IGNORE_ALL_DUPS
setopt PROMPT_SUBST

bindkey -e # Not ready for Vi bindings yet

checkmark="✔"
# checkmark=$'\Uf00c'
# checkmark=$'\U2713'
cross="✘"
# cross=$'\Uf00d'
# cross=$'\Uea76'
top_prompt_connector=$'\U256d'
bottom_prompt_connector=$'\U2570'
dash=$'\U2500'
right_angle=$'\Ue0b0'
branch=$'\Uf418'
# branch=$'\Ue0a0'
battery_full=$'\Uf240'
battery_two_thirds=$'\Uf241'
battery_half=$'\Uf242'
battery_one_third=$'\Uf243'
battery_empty=$'\Uf244'

+vi-git-untracked() {
    # print $context
    # print
    # for key val in "${(@kv)hook_com}"; do
    #     echo "$key -> $val"
    # done
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]]; then
        no_of_untracked=$(git status --porcelain | grep '??' &> /dev/null | wc -l | sed 's/^ *//')
        if [[ ${no_of_untracked} -gt 0 ]] ; then
            # This will show the marker if there are any untracked files in repo.
            # If instead you want to show the marker only if there are untracked
            # files in $PWD, use:
            #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
            hook_com[staged]+="…${no_of_untracked}"
        fi
        if [[ -z $hook_com[staged] && -z $hook_com[unstaged] ]]; then
            hook_com[misc]+=${checkmark}
        fi
    fi
}

zstyle ':vcs_info:*+*:*' debug false
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ●
zstyle ':vcs_info:*' unstagedstr ✚
zstyle ':vcs_info:git*' formats "${branch} %b|%m%c%u"
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
precmd() {
    vcs_info
    common_start="${top_prompt_connector} %{$bold_color%}%(0?.%{$fg[green]%}${checkmark}.%{$fg[red]%}${cross}-%?) %{$bg[blue]%}%{$fg[yellow]%} %~ %{$reset_color%}%{$fg[blue]%}"
    common_end="${bottom_prompt_connector} %# "
    if [[ -n ${vcs_info_msg_0_} ]]; then
        PS1=$'${common_start}%{$bg[green]%}${right_angle}%{$fg[black]%} ${vcs_info_msg_0_} %{$bg[black]%}%{$fg[green]%}${right_angle}%{$reset_color%}\n${common_end}'
    else
        PS1=$'${common_start}%{$bg[black]%}\Ue0b0%{$fg[black]%} %{$reset_color%}\n${common_end}'
    fi

    battery_status=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
    if [[ battery_status -gt 90 ]]; then
        battery_symbol=${battery_full}
    elif [[ battery_status -gt 66 ]]; then
        battery_symbol=${battery_two_thirds}
    elif [[ battery_status -gt 50 ]]; then
        battery_symbol=${battery_half}
    elif [[ battery_status -gt 33 ]]; then
        battery_symbol=${battery_one_third}
    else
        battery_symbol=${battery_empty}
    fi

    RPROMPT="${battery}: ${battery_status}%%"
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
