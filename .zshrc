# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

eval "$(dircolors -b)"

alias c="clear"
alias code="code-insiders"
alias zshconfig="nano ~/.zshrc"
alias ohmyzsh="nano ~/.oh-my-zsh"

# Repository aliases
alias cs="cd ~/Projects/lhoopa/cornerstone"
alias crm="cd ~/Projects/lhoopa/crm"
alias ts="cd ~/Projects/lhoopa/ticketing-system"
alias kp="cd ~/Projects/lhoopa/kheops"
alias sc="cd ~/Projects/lhoopa/sourcing"
alias lp="cd ~/Projects/lhoopa/lhoopa-app"

# Lando aliases
alias start="~/Scripts/lhoopa-start.sh"
alias stop="lando poweroff"
alias restart="lando poweroff && ~/Scripts/lhoopa-start.sh"
alias lgbuild="lando build && git add . && git commit -m 'build' && git push"

# Shortcut aliases
alias lezgow="start; kp; lando start; code ."
alias upgrade="sudo apt update; sudo apt upgrade -y; sudo snap refresh"

# Git aliases
alias gs="git status"
alias gac="git add .; git commit -m"
alias gch="git checkout"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"

# Artisan aliases
alias la="lando artisan"
alias lat="lando artisan tinker"

# tmux aliases
alias tm="tmux"
alias tms="tmux split-window -h"

# Android alises
alias emu="emulator -avd Android > /dev/null 2>&1 &"

# Dotfiles alias
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

bindkey '\t' end-of-line
bindkey '^H' backward-kill-word
bindkey '5~' kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

gspr() {
  if [ $# -lt 1 ]
  then
    echo "Usage: $funcstack[1] <branch-name>"
    return
  fi

  git switch -c $1 origin/production
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
export ANDROID_HOME=$HOME/Android/Sdk

export PATH=$PATH:$JAVA_HOME/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# bun completions
[ -s "/home/jeric/.bun/_bun" ] && source "/home/jeric/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Make zsh autocomplete with up arrow
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "$terminfo[kcuu1]" history-beginning-search-backward-end
bindkey "$terminfo[kcud1]" history-beginning-search-forward-end

eval "$(oh-my-posh init zsh --config ~/Applications/oh-my-posh/themes/tonybaloney.omp.json)"
eval "$(oh-my-posh completion zsh)"