# Set custom prompt
ZSH_THEME=theme
ZSH=$HOME/.oh-my-zsh
DISABLE_CORRECTION="true"
# DISABLE_UPDATE_PROMPT="true"

# Configuring history
unsetopt share_history
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_no_store

# gnome-terminal wide chars
# export VTE_CJK_WIDTH=wide

# Initialize completion
autoload -U compinit
compinit
unsetopt correct

# Added slash when changing dirs 
zstyle ':completion:*' special-dirs true

# Colorize terminal
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

# Some aliases
alias ls='ls -G'
alias ll='ls -lG'
alias gadd='git add --all .'
alias gc='git commit -S '
alias git='LANGUAGE=en_US.UTF-8 git'
alias dotfiles_update="cd ~/.dotfiles; rake update; cd -"
alias meteors='meteor --settings settings.json'
alias mt='DEBUG=1 JASMINE_DEBUG=1 VELOCITY_DEBUG=1 mrt --settings settings.json'
alias node='node --harmony'
alias pacupgrade='pacaur -Syua'

# Nicer history
export HISTSIZE=10000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Use nvim as the editor
export EDITOR=nvim
# GNU Screen sets -o vi if EDITOR=vi, so we have to force it back.
set -o vi

# Use C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'

# Highlight search results in ack.
export ACK_COLOR_MATCH='red'

# Aliases
function mcd() { mkdir -p $1 && cd $1 }
function cdf() { cd *$1*/ } # stolen from @topfunky

# Autostart tmux
export TERM=screen-256color
ZSH_TMUX_AUTOSTART="true"

function up()
{
    local DIR=$PWD
    local TARGET=$1
    while [ ! -e $DIR/$TARGET -a $DIR != "/" ]; do
        DIR=$(dirname $DIR)
    done
    test $DIR != "/" && echo $DIR/$TARGET
}

alias vim="stty stop '' -ixoff ; nvim"
alias vims="stty stop '' -ixoff ; nvim -S ~/.dotfiles/Session.vim"
alias vimrc="nvim ~/.vimrc"
alias zshrc="nvim ~/.zshrc"

# `Frozing' tty, so after any command terminal settings will be restored
ttyctl -f

# Initialize VM
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# Java exports
export J2REDIR=/opt/java/jre
export PATH=$PATH:/opt/java/jre/bin
export JAVA_HOME=${JAVA_HOME:-/opt/java/jre}

plugins=(git ruby rails bundler gem git-extras github fcatena tmux rehash archlinux systemd vagrant rbenv elixir)

source $ZSH/oh-my-zsh.sh
export PATH="$HOME/.rbenv/bin:$PATH"

# Nvm
source ~/.nvm/nvm.sh

# Add paths
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="$HOME/bin:$PATH:$HOME/Android/sdk/platform-tools"

# Go path
export GOPATH=$HOME/Webs/go
export PATH=$PATH:$GOPATH/bin

# Gpg
export GNUPGHOME="$HOME/.gnupg"

# copy aliases
alias ccopy="xclip -sel clip"
alias cpaste="xclip -sel clip -o"
alias s="screen"
alias sr="screen -r"
alias hugs="hugs -98 -E'nvim'"

# Restore the last backgrounded task with Ctrl-V
function foreground_task() { 
  fg 
}

# Define a widget called "run_info", mapped to our function above.
zle -N foreground_task

# Bind it to ESC-i.
bindkey "\Cv" foreground_task

# Back and forth history search for current command (fix for tmux)
bindkey "${terminfo[kcuu1]}" up-line-or-search
bindkey "${terminfo[kcud1]}" down-line-or-search

# Move in the shell with arrows
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Custom functions
c() { cd ~/Webs/$1; }
_c() { _files -W ~/Webs -/; }
compdef _c c
