# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# just remind me to update when it's time
zstyle ':omz:update' mode reminder  

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ripgrep python )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# Load the oh-my-zsh's library.

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/zsusswein/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/zsusswein/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/zsusswein/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/zsusswein/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Deactivates conda before running brew. 
# Re-activates conda if it was active upon completion.
# Conda plays poorly with brew and brew doctor complains if in a conda
# environment.

brew() {
    local conda_env="$CONDA_DEFAULT_ENV"
    while [ "$CONDA_SHLVL" -gt 0  ]; do
        conda deactivate
    done
    command brew $@
    local brew_status=$?
    [ -n "${conda_env:+x}" ] && conda activate "$conda_env"
    return "$brew_status"
}

# Set up dotfiles to be tracked in a bare Github repo called dotfiles
# Follows from this tutorial: https://www.atlassian.com/git/tutorials/dotfiles
alias dotfiles='/usr/bin/git --git-dir=/Users/zsusswein/.mydotfiles/ --work-tree=/Users/zsusswein'
alias dot='/usr/bin/git --git-dir=/Users/zsusswein/.mydotfiles/ --work-tree=/Users/zsusswein'

# Alias a longform version of ls to use human readable units and be sorted by
# the date most recently accessed
alias lt='ls -lAtuhG'

# Grep among .py files
# This overwrites the default zsh python plugin pygrep alias to use ripgrep 
# instead.
alias pygrep='rg -n --type py'



