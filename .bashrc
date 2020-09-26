set -o vi


VISULA=vim
EDITOR=$VISUAL


function his() {
	#reference: https://github.com/junegunn/fzf 
	#step1: fzf will help to grep history
	#step2: eval will run the command
	eval "$(history|fzf|awk '{$1 = ""; print $0 }')"
}

