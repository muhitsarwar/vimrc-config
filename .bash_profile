if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

if [ -f $HOME/.fzf/shell/completion.bash ]; then
        source $HOME/.fzf/shell/completion.bash
fi

PROMPT_COMMAND='PS1="\[$COLOR_GREEN_BOLD\] [$(date +"%T")]\[$COLOR_YELLOW_BOLD\] \$(PWD)\[$COLOR_WHITE\] \[$(parse_git_color)\](\$(gb)) \[$COLOR_RED_BOLD\]\n>> \[$COLOR_WHITE\]"'

# colors
# normal
COLOR_WHITE='\033[0m'
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_MAGENTA='\033[0;35m'
COLOR_CYAN='\033[0;36m'
COLOR_LIGHT_GRAY='\033[0;37m]'

# bold
COLOR_WHITE_BOLD='\033[1m'
COLOR_RED_BOLD='\033[1;31m'
COLOR_GREEN_BOLD='\033[1;32m'
COLOR_YELLOW_BOLD='\033[1;33m'
COLOR_BLUE_BOLD='\033[1;34m'
COLOR_MAGENTA_BOLD='\033[1;35m'
COLOR_CYAN_BOLD='\033[1;36m'
COLOR_LIGHT_GRAY_BOLD='\033[1;37m]'

# git
function parse_git_dirty {
    [[ $(gb) != '' ]] && [[ "$(git status 2> /dev/null | tail -n1)" = "nothing to commit, working tree clean" ]] || echo '*'
}
function parse_git_color {
  if [ "$(parse_git_dirty)" == '*' ]; then
    echo $COLOR_RED_BOLD
  else
    echo $COLOR_GREEN_BOLD 
  fi
}
function gb {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

