export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="sorin"
DISABLE_AUTO_UPDATE="true"
plugins=(git)

# load oh my zsh
source $ZSH/oh-my-zsh.sh

# load shell customizations
source $HOME/.shellrc

# configure node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
