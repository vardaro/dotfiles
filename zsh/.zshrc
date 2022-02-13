autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

alias vim="nvim"
alias gc="git add . && git commit -m wip"

parse_git_branch() {
    git symbolic-ref --short HEAD 2> /dev/null
}

setopt PROMPT_SUBST
PROMPT='%{%F{yellow}%}%9c%{%F{none}%} %{%F{green}%}$(parse_git_branch)%{%F{none}%} %{%F{magenta}%}λ%{%F{none}%} '
