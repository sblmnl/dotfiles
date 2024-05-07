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
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# gpg tty
export GPG_TTY=$(tty)

#    ___   ___
#   / _ | / (_)__ ____ ___ ___
#  / __ |/ / / _ `(_-</ -_|_-<
# /_/ |_/_/_/\_,_/___/\__/___/

alias ls="exa -lGx --color=always --group-directories-first --icons --git"
alias lsdl="exa -lGx --color=always --group-directories-first --icons --git --sort=cr /home/$USER/Downloads"
alias cddl="cd /home/$USER/Downloads"
alias svc="sudo systemctl"
alias rb="sudo reboot"
alias sd="sudo poweroff"

# apt
alias in="sudo apt install"
alias un="sudo apt purge --autoremove"
alias up="sudo apt update && apt list --upgradeable"
alias ug="sudo apt upgrade"

# github
alias gh="[ -z \"\$SSH_AUTH_SOCK\" ] && eval \"\$(ssh-agent -s)\" > /dev/null && ssh-add ~/.ssh/github"

# git
alias g="git"

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
alias drmf="docker rm -f"
alias drma="docker rm \$(docker ps -a -q)"
alias drmaf="docker rm -f \$(docker ps -a -q)"

## images
alias dlsi="docker image ls"
alias drmi="docker rmi"
alias drmif="docker rmi -f"
alias drmia="docker rmi \$(docker images -a -q)"
alias drmiaf="docker rmi -f \$(docker images -a -q)"

## volumes
alias dlsv="docker volume ls"
alias drmv="docker volume rm"
alias drmvf="docker volume rm -f"
alias drmva="docker volume rm \$(docker volume ls -q)"
alias drmvaf="docker volume rm -f \$(docker volume ls -q)"

# python
alias py="/home/$USER/.python/bin/python3"
alias pip="/home/$USER/.python/pip"

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
alias motd="clear && cat ~/.motd/$MOTD_THEME/\$(\ls ~/.motd/$MOTD_THEME  | shuf -n 1)"

# apps
alias mus="cmus"
alias cal="calcurse"
