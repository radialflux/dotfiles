# Path to your oh-my-zsh installation.
export ZSH=$HOME/.zsh

ZSH_THEME="agnoster"

# OMZ Default Options
# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm.dd.yyyy"


plugins=(atom themes vim-interaction vundle xcode git bower battery brew brew-cask bundler colorize git-extras git-flow git-prompt github rails rake rvm ruby)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
       else
   export EDITOR='mvim'
fi

export LANG=en_US.UTF-8


# Compilation flags
export ARCHFLAGS="-arch x86_64"
#
# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"


alias zshconfig="mate ~/.zshrc"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

. /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

