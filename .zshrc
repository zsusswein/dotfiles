####################
# Plugins
####################

plugins=(git ripgrep python colored-man-pages vi-mode)

####################
# Plugin-specific settings
####################

VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

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
export HOMEBREW_BUNDLE_FILE="$HOME/.Brewfile"

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
# Do not default to conda environments
export CONDA_AUTO_ACTIVATE_BASE=false

####################
# pyenv
####################

# Installed using Homebrew
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# Sets up shims in $PATH, install autocompletion, rehashes shims, and allows 
# pyenv to change variables in the current shell
eval "$(pyenv init -)"
# Don't allow pip install without being in a venv
PIP_REQUIRE_VIRTUALENV=true
# Auto-acivate virtual environments
eval "$(pyenv virtualenv-init -)"

####################
# Aliases
####################

# Set up dotfiles to be tracked in a bare Github repository called dotfiles
# Follows from this tutorial: https://www.atlassian.com/git/tutorials/dotfiles
alias dotfiles='/usr/bin/git --git-dir=/Users/zsusswein/.mydotfiles/ --work-tree=/Users/zsusswein'
alias dot='/usr/bin/git --git-dir=/Users/zsusswein/.mydotfiles/ --work-tree=/Users/zsusswein'

# Alias a long form version of ls to use human readable units and be sorted by
# the date most recently accessed
alias lt='ls -lAtuhG'

# Alias to commit spellfile with newly added words
alias dotspell='dot add ~/.vim-spell-en.utf-8.add; dot commit -m "Update spellfile with new words"'

# Deactivates conda before running brew. 
# Re-activates conda if it was active upon completion.
# Conda plays poorly with brew and brew doctor complains if in a conda
# environment. Also sets brew to automatically update the Brewfile 
# and commit the changes upon installing or uninstalling.

brew() {
    # Save the local conda environment
    local conda_env="$CONDA_DEFAULT_ENV"
    # Include all commands that should do a brew dump
  local dump_commands=('install' 'uninstall') 
  local main_command="${1}"

  # Turn off the conda environment
    while [ "$CONDA_SHLVL" -gt 0  ]; do
        conda deactivate
    done

    command brew $@

    local brew_status=$?

    # If necessary, brew bundle dump and commit the changes
  for command in "${dump_commands[@]}"; do
    [[ "${command}" == "${main_command}" ]] && \
     brew bundle dump --force --describe && \
     brew bundle --force && \
    dot add "$HOMEBREW_BUNDLE_FILE" && \
    dot add "$HOMEBREW_BUNDLE_FILE.lock.json" && \
    dot commit 
  done

  # Turn the conda environment back on
    [ -n "${conda_env:+x}" ] && conda activate "$conda_env"

    return "$brew_status"
}

# Grep among .py files
# This overwrites the default zsh python plugin pygrep alias to use ripgrep 
# instead.
alias pygrep='rg -n --type py'


