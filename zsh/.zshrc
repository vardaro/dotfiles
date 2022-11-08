autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

alias vim="nvim"
alias gc="git add . && git commit"
alias gs="git status"
alias shof="git diff --name-only main"
alias sou="cd ~/dd/dd-source"
alias gp="git push origin $(git symbolic-ref --short HEAD)"
alias history="history 1"
alias copyLastCmd="echo \"!!\" | pbcopy"

function h() {
    $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

function parse_git_branch() {
    git symbolic-ref --short HEAD 2> /dev/null
}

setopt PROMPT_SUBST
PROMPT='%{%F{red}%}%m%{%F{none}%} %{%F{yellow}%}%9c%{%F{none}%} %{%F{green}%}$(parse_git_branch)%{%F{none}%} %{%F{magenta}%}λ%{%F{none}%} '

