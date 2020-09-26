set -o vi


VISULA=vim
EDITOR=$VISUAL


function his() {
	#reference: https://github.com/junegunn/fzf 
	#step1: fzf will help to grep history
	#step2: eval will run the command
	eval "$(history|fzf|awk '{$1 = ""; print $0 }')"
}

#git function and alias
function git_checkout_fzf() {
	#reference: https://github.com/junegunn/fzf 
	eval "git checkout $(git branch|fzf)"
}

alias gco='git_checkout_fzf'
alias g='git'
alias gcol='g checkout @{-1}'

