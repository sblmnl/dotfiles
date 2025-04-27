# set PATH so it includes user's private bin if it exists
if [ -d "/home/$USER/bin" ] ; then
    export PATH="/home/$USER/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "/home/$USER/.local/bin" ] ; then
    export PATH="/home/$USER/.local/bin:$PATH"
fi

export PATH="/home/$USER/.python/bin:$PATH"
export PATH="$PATH:/home/$USER/.dotnet/tools"
export PATH="$PATH:/home/$USER/.local/share/JetBrains/Toolbox/scripts"
