VISULA=nvim
EDITOR=$VISUAL

#sources
source ~/.env
source ~/.cds

#fuzzy history
#fuzzy_history() {
#	#reference: https://github.com/junegunn/fzf 
#	#step1: fzf will help to grep history
#	#step2: eval will run the command
#	cmd=`history|fzf|awk '{$1 = ""; print $0 }'`
#	echo $cmd
#
#	#append at the end of history list
#	history -s $cmd
#	$cmd
#}
#alias fh=fuzzy_history

#git function and alias
function parse_git_dirty {
    [[ $(gb) != '' ]] && [[ "$(git status 2> /dev/null | tail -n1)" = "nothing to commit, working tree clean" ]] || echo '*'
}
#
#function parse_git_color {
#  if [ "$(parse_git_dirty)" == '*' ]; then
#    echo $COLOR_RED_BOLD
#  else
#    echo $COLOR_GREEN_BOLD 
#  fi
#}

function gb {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_exclude() {
	echo $1 >> .git/info/exclude
}

git_reset_head_hard() {
	git reset --hard origin/`gb`
}

#git_checkout_fzf() {
#	git fetch
#	#reference: https://github.com/junegunn/fzf 
#	cmd="git checkout `git branch $1 --sort=-committerdate|fzf --no-sort`"
#	history -s $cmd
#	$cmd
#}

#git_push(){
#	git push "$@"
#	if [[ $? != 0 ]]
#	then 
#		printf "setting up stream for %s\n", $branch
#		branch=`git branch|grep '*'|awk '{print $2}'`
#		git push --set-upstream origin "$branch" "$@"
#	fi
#}

git_rebase(){
	if [ -z "$1" ]
	then 
		idx=2
	else
		idx="$1"
	fi
	if [ "$(parse_git_dirty)" == '*' ]
	then
		git stash
		git rebase -i head~$idx
		git stash pop
	else
		git rebase -i head~$idx
	fi
}

#git_open(){
#	open `git config --get remote.origin.url`
#}

#git_create_branch(){
#	git checkout master
#	git pull
#	if [ -z "$2"]
#	then
#		git checkout -b muhit/$1/sppay-$2
#	fi
#	git checkout -b muhit/task/sppay-$1
#}

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

alias a='attach_tmux sys-config'
alias tn=tmux_new

#vim & nvim
alias vim=nvim

#don't duplicate bash history
HISTCONTROL=ignoreboth

#Tmux history
if [[ $TMUX_PANE ]]; then
	#will store lot's of story, so need to keep for a size
	HISTFILE=$HOME/tmux_his/.bash_history_tmux_${TMUX_PANE:1}
	touch "$HISTFILE"
fi

tmux_checkout_fzf() {
	#reference: https://github.com/junegunn/fzf 
	tmux attach -t `tmux ls -F '#S'|fzf`
}

alias tco='tmux_checkout_fzf'


#vpn shopee
vpn() {
    printf "1\n$vpn_user\n$vpn_pwd" | /opt/cisco/anyconnect/bin/vpn -s connect "sg.oneconnect.shopeemobile.com"
}
 
vpn-disconnect() {
    /opt/cisco/anyconnect/bin/vpn -s disconnect
}
 
vpn-stats() {
    /opt/cisco/anyconnect/bin/vpn stats
}


#.bashrc autoload in a local directory
if [ -f ".bashrc" ] && [ "$PWD" != "$HOME" ]; then
	source .bashrc
fi

# ls related
#alias ls='ls -lA'


#kubernetes related
#source ~/_kubectl_completion_bash
#alias k='minikube kubectl --'
#complete -F __start_kubectl k


