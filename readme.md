## .files
My dotfiles. This structure is taken from [the excellent
walkthrough](https://www.atlassian.com/git/tutorials/dotfiles) written 
up by Nicola Paolucci on the Atlassian blog. Unlike the walkthrough's
suggestion to use `.cfg` as the folder for the repository, I use 
`.mydotfiles` and, consequently, the alias `dotfiles` rather than `config`.

### Files

What this repository contains (for now):

- *.zshrc*: The theme and settings for my zsh configuration.
- *.gitignore*: My top level ignores.
- *.vimrc*: The vim plugins and mappings I use
- *.gitconfig*: My git signing configuration and aliases
- *.vim-spell-en.utf-8.add*: My vim dictionary add ons to include in
  spellchecking
- *.Brewfile*: My system dependencies installed through Homebrew
- *Brewfile.lock.json*: The lockfile associated with the Brewfile

I'm not yet totally happy with my settings in the above files. I'm currently 
running both Homebrew and Anaconda, but they don't play nicely together. I'd 
like to mature out of using Anaconda because it's frequently several versions 
behind or infrequently updated (for Conda Forge), but I'm tied to using 
a Conda implementation for work. As a result, the _.zshrc_ has a slightly 
hacky alias to handle `brew install` in locations with conda environments 
active.

That said, I'm mostly happy with my vim and git setups. The next step will be 
maturing my ability to do quick work in Python and R without firing up a whole 
IDE. At the moment, it's still a little painful.

## Setting up a new system

The Atlassian tutorial explains how to perform this setup, but I think it's 
also worth preserving here. 

Set the dotfiles alias and clone the repository as a bare repository:
```
dotfiles='/usr/bin/git --git-dir=$HOME/.mydotfiles/ --work-tree=$HOME'
git clone --bare https://github.com/zsusswein/dotfiles.git $HOME/.mydotfiles
```

As a side note, I'm still not quite sure why it needs to be a bare repository.  
Figuring that out is on my to do list!

Then, check out the contents of the bare repository and set it not to show 
untracked files:
```
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```
Done!
