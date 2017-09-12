# Try to resume screen session - currently disabled
#if [ $TERM != 'screen' ]; then
#  if [[ ! `screen -r` ]]; then
#    #exit
#    echo "Screen resume not implemented"
#  fi
#fi

# https://github.com/rizumu/rizumu-dotfiles/blob/master/bash/env.sh
_has() { which "$1" &>/dev/null; }


# Commonly used programs
export BROWSER="firefox"
export TERM=xterm-color
export HISTCONTROL=ignoredups
export EDITOR='vim'
export LC_ALL=C
shopt -s checkwinsize


# Setup some colors to use later in interactive shell or scripts
# Source: http://github.com/twerth/dotfiles/blob/master/etc/bashrc
export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'


# Colorize the Terminal
export CLICOLOR=1;
export LSCOLORS=ExFxCxDxBxegedabagacad
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "


# Fine-tuning basic Unix commands
alias ...='cd ../..'
alias ..='cd ..'
alias KILL='sudo kill -9'
alias RM='rm -Rfv'
alias cp='cp -v'
alias df='df -h'
alias du='du -h'
alias grep='grep --color'
alias halt='sudo halt'
alias l='ls -lh'
alias ll='l --sort=time'
alias la='l -A'
alias ls='ls -G'
alias lsd='ls -l | egrep -e "^d"'
alias mv='mv -v'
alias reboot='sudo reboot'


# Git shortcuts
git-cosh() { git commit $1 -m "$2"; git push; }
git-submodule-rm() { git submodule deinit -f "$1"; git rm -f "$1"; rm -rf .git/modules/$1; }
git-ROLLBACK() { git fetch origin; git reset --hard origin/master; git clean -fdx; }


# Path additions
 [[ -d $(dirname "${BASH_SOURCE[0]}")/scripts/ ]] && export PATH=$PATH:$(dirname "${BASH_SOURCE[0]}")/scripts/
 [[ -d $(dirname "${BASH_SOURCE[0]}")/projects/scripts/ ]] && export PATH=$PATH:$(dirname "${BASH_SOURCE[0]}")/projects/scripts/


# Tiny tools
alias rmEmtpyFolders='find . -type d -empty -exec rmdir "{}" \;'
alias rmdsstore="find . -name '*.DS_Store' -type f -delete"
alias rmsvn="find . -name '*.svn' -type f -delete"
alias noftchcks="du -akx | sort -nr | less"
alias mvn-upgrade='mvn versions:use-next-releases'
alias java-list-imports='find . -iname "*.java" | xargs cat | grep -e "^import" | sort -r | uniq'


# Third party commands
_has rsync && alias gentlecp='rsync --update --progress --human-readable'
_has thefuck && eval "$(thefuck --alias)"
_has stow && alias stow='stow --dir="$HOME/dotfiles/" --ignore=README.md -v'


# Enable and configure bash completion
# Taken from https://gist.github.com/holywarez/578695
bind "set completion-ignore-case on"
bind "set bell-style none"
bind "set show-all-if-ambiguous On"


# Load OS specific bash settings
[[ -e "${BASH_SOURCE[0]}."`uname -s` ]] && source "${BASH_SOURCE[0]}.`uname -s`"


# Load Host specific bash settings
SHORTHOSTNAME=`hostname | cut -d"." -f 1`
[[ -e ${BASH_SOURCE[0]}.$SHORTHOSTNAME ]] && source "${BASH_SOURCE[0]}.$SHORTHOSTNAME"


# Console prints may be skipped
if [ "$1" != "silent" ]; then
	echo
	figlet -c $SHORTHOSTNAME 2>/dev/null || echo "$SHOTHOSTNAME"
	echo
	
	# Print status of important folders
	
	if [ -d .dotfiles ]; then
		echo -e ".dotfiles \t $(cd .dotfiles && git log --oneline | head -n 1)"
	fi
	if [ -d scripts ]; then
		echo -e "scripts \t $(cd scripts && git log --oneline | head -n 1)"
	fi
fi
