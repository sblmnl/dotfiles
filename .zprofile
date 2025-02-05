# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="/home/$USER/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "/home/$USER/.local/bin" ] ; then
    export PATH="/home/$USER/.local/bin:$PATH"
fi

# set PATH so it includes user's python bin if it exists
if [ -d "/home/$USER/.python/bin" ] ; then
    export PATH="/home/$USER/.python/bin:$PATH"
fi

# add dotnet tools
export PATH="$PATH:$HOME/.dotnet/tools"

# Added by Toolbox App
export PATH="$PATH:/home/jared/.local/share/JetBrains/Toolbox/scripts"

