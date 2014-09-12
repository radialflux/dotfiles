# Path to your oh-my-zsh installation.
export TERM=xterm-256color
export ZSH=$HOME/.zsh


ZSH_THEME="solar-powered"

HIST_STAMPS="mm.dd.yyyy"


plugins=(atom themes vim-interaction vundle xcode git bower battery brew brew-cask bundler colorize git-extras git-flow git-prompt github rails rake rvm ruby tmux tmuxinator)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:."
#
# Compilation flags
export ARCHFLAGS="-arch x86_64"


export LANG=en_US.UTF-8


# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

alias vi="mvim"
alias e="mvim"
alias v="mvim"
alias vim="/usr/local/Cellar/macvim-split-browser/740022/MacVim.app/Contents/MacOS/Vim"
alias zshconfig="mvim ~/.zshrc"
alias dev="cd ~/Documents/Development"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
       else
   export EDITOR='mvim'
fi

[[ -n "$SSH_CLIENT" ]] || export DEFAULT_USER="Greg"

############################################################################
# Powerline Config goes here                                               #
############################################################################
#powerline-daemon -q
# . /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

export POWERLINE_DATE_FORMAT=""
export POWERLINE_FULL_CURRENT_PATH="relative"
export POWERLINE_RIGHT_A='rvm'
export POWERLINE_RIGHT_B="date"
