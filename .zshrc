# set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1
setopt histignorealldups sharehistory

# use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# use modern completion system
autoload -Uz compinit
compinit

# autosuggestion strategy
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HISTORY_IGNORE='(cd|ls|vim) *'

# fix dircolors
eval "$(dircolors -b)"

# setup plugins
plugins=(
 zsh-autosuggestions
)

# Hungry delete
bindkey '^I' autosuggest-accept
bindkey '^H' backward-kill-word
bindkey '5~' kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# NVM PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Android PATH
export JAVA_HOME=/snap/android-studio/current/jbr
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$JAVA_HOME/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Home PATH
export PATH=$PATH:$HOME/bin

# Bun PATH
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Composer PATH
export PATH=$PATH:$HOME/.config/composer/vendor/bin

# ionic completions
if type compdef &>/dev/null; then
  __ionic() {
    compadd -- $(ionic completion -- "${words[@]}" 2>/dev/null)
  }

  compdef __ionic ionic
fi

# zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# bun completions
[ -s "/home/jeric/.bun/_bun" ] && source "/home/jeric/.bun/_bun"

# Source aliases
source ~/.aliases

# Make zsh autocomplete with up arrow
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "$terminfo[kcuu1]" history-beginning-search-backward-end
bindkey "$terminfo[kcud1]" history-beginning-search-forward-end

# Load oh-my-posh with theme
eval "$(oh-my-posh init zsh --config ~/oh-my-posh/themes/tonybaloney.omp.json)"
eval "$(oh-my-posh completion zsh)"