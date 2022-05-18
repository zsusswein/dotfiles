####################
# ZSH options
####################

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
# just remind me to update when it's time
zstyle ':omz:update' mode reminder  
ENABLE_CORRECTION="true"
HIST_STAMPS="mm/dd/yyyy"
source $ZSH/oh-my-zsh.sh
export EDITOR='vim'

####################
# Plugins
####################

plugins=(git ripgrep python )

####################
# Conda
####################

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

####################
# Aliases
####################

# Set up dotfiles to be tracked in a bare Github repo called dotfiles
# Follows from this tutorial: https://www.atlassian.com/git/tutorials/dotfiles
alias dotfiles='/usr/bin/git --git-dir=/Users/zsusswein/.mydotfiles/ --work-tree=/Users/zsusswein'
alias dot='/usr/bin/git --git-dir=/Users/zsusswein/.mydotfiles/ --work-tree=/Users/zsusswein'

# Alias a long form version of ls to use human readable units and be sorted by
# the date most recently accessed
alias lt='ls -lAtuhG'

# Alias to commit spellfile with newly added words
alias dotspell='dot add .vim-spell-en.utf-8.add; dot commit -m "Update spellfile with new words"'

# Grep among .py files
# This overwrites the default zsh python plugin pygrep alias to use ripgrep 
# instead.
alias pygrep='rg -n --type py'



