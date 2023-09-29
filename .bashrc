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

OSH_THEME="sexy"
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

# apt
alias add="sudo apt install"
alias remove="sudo apt remove"
alias update="sudo apt update && apt list --upgradeable"
alias upgrade="sudo apt upgrade"

# docker
alias dc="docker compose"
alias dps="watch -n 2 docker ps -a"
alias dnuke="docker stop \$(docker ps -a -q); docker rm -f \$(docker ps -a -q); docker rmi -f \$(docker images -a -q); docker volume rm -f \$(docker volume ls -q)"

# vpn on/off
alias connect="mullvad lockdown-mode set on && mullvad connect"
alias disconnect="mullvad lockdown-mode set off && mullvad disconnect"
alias reconnect="mullvad status && mullvad reconnect && sleep 2 && mullvad status"

# appgate on/off
alias appgate-on="sudo systemctl stop plexmediaserver && killall librewolf && killall brave-browser && mullvad lockdown-mode set off && mullvad disconnect && sudo systemctl start appgatedriver"
alias appgate-off="sudo systemctl stop appgatedriver && killall Appgate"

# set wallpaper
alias setwal="feh --bg-fill"

# apps
alias music="cmus"
alias calendar="calcurse"

#    __________ __
#   / __/ __/ // /
#  _\ \_\ \/ _  /
# /___/___/_//_/

# start ssh-agent
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" > /dev/null
