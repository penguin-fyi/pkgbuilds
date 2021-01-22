#!/usr/bin/zsh

autoload -U compaudit compinit
compinit

autoload -U +X bashcompinit
bashcompinit

autoload -U colors
colors

export LSCOLORS="Gxfxcxdxbxegedabagacad"
eval "$(dircolors -b $HOME/.dircolors)"

# shell options
export REPORTTIME=3                 # Report time statistics
setopt notify                       # Report status of bg jobs immediately
setopt no_hup                       # Don't kill background jobs when exiting
setopt no_clobber                   # Don't clobber existing files with >
setopt no_beep                      # Don't beep
setopt no_bg_nice                   # Don't frob with nicelevels
setopt interactive_comments         # Allow comments in interactive shells
setopt autoremoveslash              # Don't guess when slashes should be removed (too magic)
setopt no_match                     # Show error if globbing fails
setopt extended_glob                # More globbing characters
setopt correct                      # Offer to correct command if not found
setopt auto_cd                      # Change directory without `cd`
setopt multios                      # Perform implicit tees or cats for multiple redirections

# history options
export HISTSIZE=10000
export SAVEHIST=10000

setopt extended_history             # record timestamp of command in HISTFILE
setopt hist_expire_dups_first       # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups             # ignore duplicated commands history list
setopt hist_ignore_all_dups         # ignore duplicated commands history list
setopt hist_ignore_space            # ignore commands that start with space
setopt hist_reduce_blanks           # remove superfluous blanks from commands added to history
setopt hist_verify                  # show command with history expansion to user before running it
setopt inc_append_history           # add commands to HISTFILE in order of execution
setopt append_history               # append to history
setopt hist_find_no_dups            # don't show dups in history search

# load plugins
plugdir=/usr/share/zsh/plugins
source $plugdir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $plugdir/zsh-autosuggestions/zsh-autosuggestions.zsh

# load prompt
source $HOME/.zshrc.prompt

# have a great day
