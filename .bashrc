# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

#   ____  __     __  ___       ___           __
#  / __ \/ /    /  |/  /_ __  / _ )___ ____ / /
# / /_/ / _ \  / /|_/ / // / / _  / _ `(_-</ _ \
# \____/_//_/ /_/  /_/\_, / /____/\_,_/___/_//_/
#                    /___/

export OSH=/home/$USER/.oh-my-bash

OSH_THEME="agnoster"
OMB_USE_SUDO=true

completions=(
  git
  composer
  ssh
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)

source "$OSH"/oh-my-bash.sh

#    ___       __  __
#   / _ \___ _/ /_/ /
#  / ___/ _ `/ __/ _ \
# /_/   \_,_/\__/_//_/

export PATH=$PATH:/home/$USER/.local/bin

#  _   __         _      __   __
# | | / /__ _____(_)__ _/ /  / /__ ___
# | |/ / _ `/ __/ / _ `/ _ \/ / -_|_-<
# |___/\_,_/_/ /_/\_,_/_.__/_/\__/___/

# disable dotnet cli telemetry
DOTNET_CLI_TELEMETRY_OPTOUT=1

# gpg tty
export GPG_TTY=$(tty)

#    ___   ___
#   / _ | / (_)__ ____ ___ ___
#  / __ |/ / / _ `(_-</ -_|_-<
# /_/ |_/_/_/\_,_/___/\__/___/

alias ls="exa -alGx --color=always --group-directories-first --icons --git"
alias lsdl="exa -alGx --color=always --group-directories-first --icons --git --sort=cr ~/Downloads"
alias svc="sudo systemctl"
alias rb="sudo reboot"
alias sd="sudo poweroff"

# apt
alias in="sudo apt install"
alias un="sudo apt remove"
alias up="sudo apt update && apt list --upgradeable"
alias ug="sudo apt upgrade"

# github
alias gh="ssh-add ~/.ssh/github"

# git
alias g="git"
alias gs="git status"
alias gcl="git clone"
alias gc="git commit"
alias ga="git add"
alias gph="git push"
alias gpl="git pull"
alias gch="git checkout"
alias gb="git branch"
alias gf="git fetch"
alias gra="git remote add"
alias grd="git remote remove"

# docker
alias d="docker"
alias docker-compose="docker compose"
alias dc="docker compose"
alias dcp="docker compose --profile"
alias dps="docker ps -a"
alias dpsw="watch -n 2 docker ps -a"
alias dnuke="docker stop \$(docker ps -a -q); docker rm -f \$(docker ps -a -q); docker rmi -f \$(docker images -a -q); docker volume rm -f \$(docker volume ls -q)"

## containers
alias dstop="docker stop"
alias drm="docker rm"
alias dr!="docker rm -f"
alias drm*="docker rm \$(docker ps -a -q)"
alias drm*!="docker rm -f \$(docker ps -a -q)"

## images
alias dlsi="docker image ls"
alias drmi="docker rmi"
alias drmi!="docker rmi -f"
alias drmi*="docker rmi \$(docker images -a -q)"
alias drmi*!="docker rmi -f \$(docker images -a -q)"

## volumes
alias dlsv="docker volume ls"
alias drmv="docker volume rm"
alias drmv!="docker volume rm -f"
alias drmv*="docker volume rm \$(docker volume ls -q)"
alias drmv*!="docker volume rm -f \$(docker volume ls -q)"

# python
alias py="python3"

# vpn on/off
alias vpnc="mullvad lockdown-mode set on && mullvad connect"
alias vpnd="mullvad lockdown-mode set off && mullvad disconnect"
alias vpnr="mullvad reconnect"

# appgate on/off
alias agon="sudo systemctl stop plexmediaserver && killall librewolf && killall brave-browser && mullvad lockdown-mode set off && mullvad disconnect && sudo systemctl start appgatedriver"
alias agoff="sudo systemctl stop appgatedriver && killall Appgate"

# set wallpaper
alias setwal="feh --bg-fill"

# get new motd
alias motd="clear && cat ~/.motd/\$(ls ~/.motd  | shuf -n 1)"

# apps
alias mus="cmus"
alias cal="calcurse"

#    __________ __
#   / __/ __/ // /
#  _\ \_\ \/ _  /
# /___/___/_//_/

# start ssh-agent
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" > /dev/null
