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

OSH_THEME="rr"
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

alias ls="exa --color=always --group-directories-first -a"
alias svc="sudo systemctl"

# docker
alias dc="docker compose"
alias dps="docker ps -a"
alias dnuke="docker stop \$(docker ps -a -q); docker rm -f \$(docker ps -a -q); docker rmi -f \$(docker images -a -q); docker volume rm -f \$(docker volume ls -q)"

# sanitize
alias sanitize="sudo svc stop plexmediaserver; killall librewolf; killall firefox-esr; killall brave-browser"

# vpn on/off
alias vpn-on="mullvad lockdown-mode set on && mullvad connect"
alias vpn-off="mullvad lockdown-mode set off && mullvad disconnect"

# appgate on/off
alias appgate-on="sudo systemctl start appgatedriver"
alias appgate-off="sudo systemctl stop appgatedriver && killall Appgate"

# install/uninstall apt packages
alias aptin="sudo apt install"
alias aptun="sudo apt remove --autoremove --purge"

# set wallpaper
alias setwal="feh --bg-fill"

# get new motd
alias motd="clear && cat ~/.motd/\$(ls ~/.motd  | shuf -n 1)"

# apps
alias music="cmus"
alias calendar="calcurse"

#   _____         __             _          __  _
#  / ___/_ _____ / /____  __ _  (_)__ ___ _/ /_(_)__  ___
# / /__/ // (_-</ __/ _ \/  ' \/ /_ // _ `/ __/ / _ \/ _ \
# \___/\_,_/___/\__/\___/_/_/_/_//__/\_,_/\__/_/\___/_//_/

# print message of the day
cat ~/.motd/$(ls ~/.motd  | shuf -n 1)

#    __________ __
#   / __/ __/ // /
#  _\ \_\ \/ _  /
# /___/___/_//_/

[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" > /dev/null
