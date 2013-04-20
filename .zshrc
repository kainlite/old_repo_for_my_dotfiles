# Set custom prompt
ZSH_THEME=gentoo
ZSH=$HOME/.oh-my-zsh

#setopt PROMPT_SUBST
#autoload -U promptinit
#promptinit
#prompt grb

# Initialize completion
autoload -U compinit
compinit
# unsetopt correct

# Added slash when changing dirs 
zstyle ':completion:*' special-dirs true

# Add paths
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="$HOME/bin:$PATH"

# Colorize terminal
export TERM='xterm-color'
alias ls='ls -G'
alias ll='ls -lG'
alias gadd='git add --all .'
alias git='LC_ALL=en_US git'
alias dotfiles_update="cd ~/.dotfiles; rake update; cd -"
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Use vim as the editor
export EDITOR=vi
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
alias r=rails
alias t="script/test $*"
alias f="script/features $*"
function mcd() { mkdir -p $1 && cd $1 }
function cdf() { cd *$1*/ } # stolen from @topfunky

# Ruby exports
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

# Activate the closest virtualenv by looking in parent directories.
activate_virtualenv() {
    if [ -f env/bin/activate ]; then . env/bin/activate;
    elif [ -f ../env/bin/activate ]; then . ../env/bin/activate;
    elif [ -f ../../env/bin/activate ]; then . ../../env/bin/activate;
    elif [ -f ../../../env/bin/activate ]; then . ../../../env/bin/activate;
    fi
}

# Find the directory of the named Python module.
python_module_dir () {
    echo "$(python -c "import os.path as _, ${1}; \
        print _.dirname(_.realpath(${1}.__file__[:-1]))"
        )"
}

# By @ieure; copied from https://gist.github.com/1474072
#
# It finds a file, looking up through parent directories until it finds one.
# Use it like this:
#
#   $ ls .tmux.conf
#   ls: .tmux.conf: No such file or directory
#
#   $ ls `up .tmux.conf`
#   /Users/grb/.tmux.conf
#
#   $ cat `up .tmux.conf`
#   set -g default-terminal "screen-256color"

# Autostart tmux
[[ `tput colors` == "256" ]] || TERM=screen-256color 
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

alias vim="stty stop '' -ixoff ; vim"
alias vims="stty stop '' -ixoff ; vim -S ~/.dotfiles/Session.vim"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"
# `Frozing' tty, so after any command terminal settings will be restored
ttyctl -f

# Initialize VM
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

plugins=(git ruby rails3 bundler coffe gem git-extras debian github screen fcatena tmux)

source $ZSH/oh-my-zsh.sh
export PATH="$HOME/.rbenv/bin:$PATH"

[ ! -f "$HOME/.rbenv/bin/rbenv" ] || eval "$(rbenv init -)" 

# copy aliases
alias ccopy="xclip -sel clip"
alias cpaste="xclip -sel clip -o"
alias s="screen"
alias sr="screen -r"

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
