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
left_arty_paren=$'\Ue0b7'
right_arty_paren=$'\Ue0b5'
# branch=$'\Uf418'
branch=$'\Ue0a0'
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
        local git_status=$(git status --branch --porcelain=1)
        if [[ -z $(echo "$git_status" | grep -v '^#') ]]; then
            hook_com[misc]+=${checkmark}
        else
            no_of_untracked=$(echo "$git_status" | grep '??' &> /dev/null | wc -l | sed 's/^ *//')
            no_of_staged=$(echo "$git_status" | grep '^M.' &> /dev/null | wc -l | sed 's/^ *//')
            no_of_unstaged=$(echo "$git_status" | grep '^.M' &> /dev/null | wc -l | sed 's/^ *//')
            if [[ ${no_of_staged} -gt 0 ]]; then
                hook_com[staged]+=${no_of_staged}
            fi
            if [[ ${no_of_untracked} -gt 0 ]] ; then
                hook_com[staged]+="…${no_of_untracked}"
            fi
            if [[ ${no_of_unstaged} -gt 0 ]]; then
                hook_com[unstaged]+=${no_of_unstaged}
            fi
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
    venv_name=${VIRTUAL_ENV:+$(basename ${VIRTUAL_ENV})}
    venv_part=${venv_name:+${left_arty_paren}%{$fg[magenta]%}$venv_name%{$reset_color%}${right_arty_paren}}
    common_start="${top_prompt_connector} %{$bold_color%}%(0?.%{$fg[green]%}${checkmark}.%{$fg[red]%}${cross}-%?)%{$reset_color%} ${venv_part}%{$fg[blue]%}%S${right_angle}%s%{$bg[blue]%}%{$fg[black]%} %~ %{$reset_color%}%{$fg[blue]%}"
    common_end="${bottom_prompt_connector} %# %{$reset_color%}"
    if [[ -n ${vcs_info_msg_0_} ]]; then
        PS1=$'${common_start}%{$bg[green]%}${right_angle}%{$fg[black]%} ${vcs_info_msg_0_} %{$reset_color%}%{$fg[green]%}${right_angle}%{$reset_color%}\n${common_end}'
    else
        PS1=$'${common_start}${right_angle}%{$reset_color%}\n${common_end}'
    fi

    battery_status=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
    if [[ battery_status -gt 90 ]]; then
        battery_symbol=${battery_full}
    elif [[ battery_status -gt 60 ]]; then
        battery_symbol=${battery_two_thirds}
    elif [[ battery_status -gt 40 ]]; then
        battery_symbol=${battery_half}
    elif [[ battery_status -gt 15 ]]; then
        battery_symbol=${battery_one_third}
    else
        battery_symbol=${battery_empty}
    fi

    RPROMPT="${battery_status}%% ${battery_symbol}"
}
