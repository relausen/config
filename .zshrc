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
zle_highlight=('paste:none')
# unset zle_bracketed_paste

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

bindkey '\e[3~' delete-char
bindkey '\e[A' up-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
bindkey '\e^[[C' forward-word
bindkey '^ ' autosuggest-accept
bindkey '^J' autosuggest-execute

alias cat='bat'
alias cfg="$CFG_COMMAND_OPTIONS env git"
alias cfglazy="lazygit --work-tree $HOME --git-dir $HOME/.cfg"
alias cfgtig="$CFG_COMMAND_OPTIONS tig"
alias h='history'
alias l='bat'
alias la='lla'
alias ll='eza -lh --icons=auto --git --group-directories-first --time-style=long-iso'
alias lla='ll -a'
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

function new_kitty_session {
    local session_name=$1
    local session_dir=$2
    if [ -z "$session_dir" ]; then
        dir=current
    else
        dir=$session_dir
    fi
    kitty @ launch --type os-window --window-title $session_name --cwd ${dir}
}

function new_wezterm_session {
    local session_name=$1
    local session_dir=$2
    if [ -z "$session_dir" ]; then
        dir=$(pwd)
    else
        dir=$session_dir
    fi
    pane_id=$(wezterm cli spawn --new-window --cwd ${dir})
    wezterm cli set-tab-title --pane-id ${pane_id} ${session_name}
}

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
fpath+=~/.awsume/zsh-autocomplete
fpath+=${HOME}/.zfunc
autoload -Uz compinit
compinit

if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
else
    source $HOME/.zsh-prompt.zsh
fi
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
fi
source ${HOME}/.zfunc/plugin_manager
source ${HOME}/.zfunc/wezterm-shell-integration

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

eval $(thefuck --alias)
eval "$(mise activate zsh)"
if command -v op &>/dev/null; then
    eval "$(op completion zsh)" && compdef _op op
fi

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

if [[ ${SHLVL} -eq 1 ]]; then
    if command -v fastfetch &>/dev/null; then
        fastfetch
        # local backend=ascii
        # if [[ ${TERM} == xterm-kitty ]]; then
        #     backend=kitty
        # fi
        # neofetch --backend ${backend} --size "590px"
    fi
fi
