set -o vi


VISULA=vim
EDITOR=$VISUAL

#fuzzy history
fuzzy_history() {
	#reference: https://github.com/junegunn/fzf 
	#step1: fzf will help to grep history
	#step2: eval will run the command
	cmd="$(history|fzf|awk '{$1 = ""; print $0 }')"
	echo $cmd
	history -s $cmd
	eval $cmd
}
alias fh=fuzzy_history

#git function and alias
git_exclude() {
	echo "$1" >> .git/info/exclude
}

function git_checkout_fzf() {
	#reference: https://github.com/junegunn/fzf 
	eval "git checkout $(git branch|fzf)"
}

alias gco='git_checkout_fzf'
alias g='git'
alias gcol='g checkout @{-1}'
alias gex='git_exclude'

#change directory
alias cdh='cd ~'
alias cdl='cd -'

