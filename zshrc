# Path to your oh-my-zsh installation
export TERM=xterm-256color
export ZSH=$HOME/.zsh
export ZLE_RPROMPT_INDENT=0 

#ZSH_THEME="bullet-train"

HIST_STAMPS="dd.mm.yyyy"

plugins=(battery bundle bundler brew brew-cask brew install bower rails rake rbenv ruby gem cocoapods terminalapp urltools web-search themes wp-cli xcode node npm)

source $ZSH/oh-my-zsh.sh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:."
export PATH="$PATH:$HOME/.bin"
export ARCHFLAGS="-arch x86_64"
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export SSH_KEY_PATH="~/.ssh/rsa_id"
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
alias mvim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias zshconfig="mvim ~/.zshrc"
alias dev="cd ~/Documents/Development"
alias dots='cd ~/.dotfiles'
alias sysconfigs="vi -O ~/Documents/Projects/sysconfigs.session"
alias mdfind='mdfind -interpret $1'
alias clear="osascript -e 'if application \"Terminal\" is frontmost then tell application \"System Events\" to keystroke \"k\" using command down'"
alias tma='tmux attach -d -t'
alias git-tmux='tmux new -s $(basename $(pwd))'

export RBENV_ROOT=/usr/local/var/rbenv
eval "$(rbenv init -)"
eval "$(fasd --init auto)"

# Powerline-shell trial

function powerline_precmd() {
      export PROMPT="$(/Users/Greg/.dotfiles/config/powerline-shell/powerline-shell.py $? --shell zsh --mode "patched" 2> /dev/null)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

install_powerline_precmd

RPROMPT=""
