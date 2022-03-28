#fzh related
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fd --type f" #brew install fd
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" #will exclude git ignore


#kubectl
source ~/_kubectl_completion_zsh
alias k='kubectl'
complete -F __start_kubectl k


# fzf include hidden
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

