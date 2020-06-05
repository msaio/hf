#!/usr/bin/env bash

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# Path to the bash it configuration
export BASH_IT="$HOME/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='sexy'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
source "$BASH_IT"/bash_it.sh

# Neovim
alias e="nvim"
export NVIM_CFG="$HOME/.config/nvim/init.vim"
alias cfgnvim="e $NVIM_CFG"
alias re="e -S ./Session.vim"
alias eI="e +PlugInstall +qall"
alias eC="e +PlugClean! +qall"

# Bash
export BASH_CFG="$HOME/.bashrc"
alias cfgbash="e $BASH_CFG"

# Tmux
alias t="tmux"
alias ta="t a -t"
alias tls="t ls"
alias tn="t new -t"

alias q="exit"

# Open xserver
open_xserver () {
	curdir=$(pwd)
	if [ $# -eq 0 ]
	then
		cd /mnt/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Xming/ && cmd.exe /c "Xming.lnk" & echo "" && cd
		#cd
		#/mnt/c/Program\ Files\ \(x86\)/Xming/XLaunch.exe & echo "X-server is running as default..."
		cd $curdir
	else
		if [ -e $1 ]
		then
			cd
			/mnt/c/Program\ Files\ \(x86\)/Xming/XLaunch.exe -run $1 & echo "X-server is running with '$1' file..."
			cd $curdir
		else
			cd
			echo "There is no: '$1'"
			/mnt/c/Program\ Files\ \(x86\)/Xming/XLaunch.exe & echo "X-server is running as default..."
			cd $curdir
		fi
	fi
}
# Kill xserver
kill_xserver () {
	cmd.exe /c "taskkill /F /IM Xming.exe /IM XLaunch.exe"	
}
# Check xserver
check_xserver () {
	cmd.exe /c "tasklist" | grep "XLaunch.exe\|Xming.exe"
}

# Open pulseaudio
open_pulseaudio () {
	/mnt/c/wsl/bin/pulseaudio.exe &
}
# Kill pulseaudio
kill_pulseaudio () {
	cmd.exe /c "taskkill /F /IM pulseaudio.exe"
}
# Check pulseaudio
check_pulseaudio () {
	cmd.exe /c "tasklist" | grep "pulseaudio.exe"
}

# Add a line to head of file
add_line_to_head () {
	# get the original string + newline from echo "" + content from source file then add to new file and replace the old one
	{ echo -n $1; echo ""; cat $2;} > $2.new && mv -v $2{.new,};
}

# Remove all empty line in file
remove_empty_line () {
	awk 'NF > 0' $1 > $1.new && mv $1{.new,};
}

# Search in a file return line that contains keywords
search_in_file () {
	if [ $# -eq 0 ]
	then
		echo "Need a file for scanning !"
	else
		if [ -e $1 ]
		then
			echo "Give some keywords in ' $1 ' :"
			read -p "" word
			awk '/'$word'/ { print $0 }' $1
		else
			echo "The ' $1 ' does not exist !"
		fi
	fi
}

# Check size of file/dir
size_of () {
	ls -l $1 | awk '{ x += $5} END { print "Total bytes:  ", x; print "Total kbytes: ", x/1024; print "Total mbytes: ", x/1024/1024; print "Total gbytes: ", x/1024/1024/1024}'
}

# Number of lines
no_of_lines_in () {
	if [ $# -eq 0 ]
	then
		echo "Need a file !"
	else
		if [ -e $1 ]
		then
			awk 'END { print "Total lines: ", NR }' $1
		else
			echo "The ' $1 ' does not exist !"
		fi
	fi
}

# auto switch dir without using cd
shopt -s autocd

export VIRTUAL_IP=$(ifconfig | grep inet | awk '{print $2}' | head -1)
export GLOBAL_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
export VIRTUAL_SERVER=$(grep -oP "(?<=nameserver ).+" /etc/resolv.conf)
export REAL_IP=$(dig +noall +answer $(hostname -s) | tail -1 | cut -f 5)
export LOCAL_HOST=127.0.0.1

set_up_ip () {
	select opt in "virtual_ip" "global" "virtual_server" "real" "local"; do
		case $opt in
			virtual_ip )
				export IP=$VIRTUAL_IP
				break;;
			global )
				export IP=$GLOBAL_IP
				break;;
			virtual_server )
				export IP=$VIRTUAL_SERVER
				break;;
			real )
				export IP=$REAL_IP
				break;;
			local )
				export IP=$LOCAL_HOST	
				break;;
		esac
	done
	echo "The IP: $IP"
	export DISPLAY=$IP:0
	export PULSE_SERVER=tcp:$IP
	sed -i "42s/.*/load-module module-waveout sink_name=output source_name=input record=0/" /mnt/c/wsl/etc/pulse/default.pa
	sed -i "61s/.*/load-module module-native-protocol-tcp auth-ip-acl=$IP/" /mnt/c/wsl/etc/pulse/default.pa
	sed -i "39s/.*/exit-idle-time = -1/" /mnt/c/wsl/etc/pulse/daemon.conf
}


#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
