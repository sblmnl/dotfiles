# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's python bin if it exists
if [ -d "$HOME/.python/bin" ] ; then
    PATH="$HOME/.python/bin:$PATH"
fi

# add jetbrains toolbox
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# add dotnet tools
export PATH="$PATH:$HOME/.dotnet/tools"

