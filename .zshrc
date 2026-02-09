export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="sorin"
DISABLE_AUTO_UPDATE="true"
plugins=(git gpg-agent ssh-agent nvm)

# configure ssh-agent plugin
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent quiet yes

# load oh my zsh
source $ZSH/oh-my-zsh.sh

# load shell customizations
source $HOME/.shellrc
