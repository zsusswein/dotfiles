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

I'm not yet totally happy with my settings in the above files. Once I get 
happy with my versioning and package handling, I'll probably start to add in
some of the files related to that too.
