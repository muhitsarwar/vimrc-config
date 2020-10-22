set -o vi


VISULA=nvim
EDITOR=$VISUAL

#fuzzy history
fuzzy_history() {
	#reference: https://github.com/junegunn/fzf 
	#step1: fzf will help to grep history
	#step2: eval will run the command
	cmd=`history|fzf|awk '{$1 = ""; print $0 }'`
	echo $cmd

	#append at the end of history list
	history -s $cmd
	$cmd
}
alias fh=fuzzy_history

#git function and alias
git_exclude() {
	echo $1 >> .git/info/exclude
}

git_checkout_fzf() {
	#reference: https://github.com/junegunn/fzf 
	git checkout `git branch|fzf`
}
git_push(){
	git push "$@"
	if [[ $? != 0 ]]
	then 
		printf "setting up stream for %s\n", $branch
		branch=`git branch|grep '*'|awk '{print $2}'`
		git push --set-upstream origin "$branch" "$@"
	fi
}

alias gco='git_checkout_fzf'
alias g='git'
alias gcol='g checkout @{-1}'
alias gex='git_exclude'
alias grb='git rebase -i'
alias gp='f() { git_push "$@"; }; f'
#upload script in server
copy_script(){
	{
		#pipeline operator(|) is will provide output as input
		#but in this case we don't need output
		#that's why semicollon operator(;)
		echo "cat >> .bashrc;source .bashrc"
		cat .bashrc
	} | pbcopy # pbcopy is to copy the output inside of curly braces into cliboard
}

#tmux
attach_tmux(){
	tmux a -t "$1"
}
tmux_new(){
	tmux new -s "$1"
}
bash_load(){
	source .bashrc
}

alias l=bash_load
alias a='attach_tmux sys-config'
alias tn=tmux_new

#vim & nvim
alias vim=nvim
