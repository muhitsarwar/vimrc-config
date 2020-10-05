set -o vi


VISULA=vim
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

function git_checkout_fzf() {
	#reference: https://github.com/junegunn/fzf 
	git checkout `git branch|fzf`
}

alias gco='git_checkout_fzf'
alias g='git'
alias gcol='g checkout @{-1}'
alias gex='git_exclude'

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
