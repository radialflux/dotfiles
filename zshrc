# Path to your oh-my-zsh installation.
export TERM=xterm-256color
export ZSH=$HOME/.zsh


ZSH_THEME="solar-powerline"
export POWERLINE_HIDE_HOST_NAME=1
export POWERLINE_HIDE_USER_NAME=1
export POWERLINE_RIGHT_B=""
export POWERLINE_RIGHT_A="exit-status"
export POWERLINE_SHOW_GIT_ON_RIGHT=1
export POWERLINE_FULL_CURRENT_PATH="%~"

# Characters
SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"


HIST_STAMPS="mm.dd.yyyy"


plugins=(atom themes vim-interaction vundle xcode git bower battery brew brew-cask bundler colorize git-extras git-flow git-prompt github rails rake rvm ruby tmux tmuxinator)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:."
#
# Compilation flags
export ARCHFLAGS="-arch x86_64"

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
       else
   export EDITOR='mvim'
fi

export LANG=en_US.UTF-8


# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

alias vi="mvim"
alias e="mvim"
alias v="mvim"
alias zshconfig="mvim ~/.zshrc"
alias dev="cd ~/Documents/Development"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -n "$SSH_CLIENT" ]] || export DEFAULT_USER="Greg"

############################################################################
# Powerline Config goes here                                               #
############################################################################
#powerline-daemon -q
# . /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help
