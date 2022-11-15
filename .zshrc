disable r
bindkey "[D" backward-word       # alt - left
bindkey "[C" forward-word        # alt - right
bindkey "^R" history-beginning-search-backward

defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)

# aliases
alias ls='ls -G'
alias ll='ls -l'
alias cl='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias vim='nvim'

# nvim
export EDITOR=nvim

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="`yarn global bin`:$PATH"
export NODE_VERSIONS="${NVM_DIR}/versions/node"
export NODE_VERSION_PREFIX="v"

# rbenv
eval "$(rbenv init - zsh)"

# direnv
eval "$(direnv hook zsh)"
setopt PROMPT_SUBST
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env)'$PS1

# need to clone in ~.zsh https://github.com/agkozak/agkozak-zsh-prompt
source ~/.zsh/agkozak-zsh-prompt/agkozak-zsh-prompt.plugin.zsh
export AGKOZAK_PROMPT_DIRTRIM=0
export AGKOZAK_LEFT_PROMPT_ONLY=1
export AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' 'S')

# python
export PYTHONDONTWRITEBYTECODE=True

# kubernetes
[[ /opt/homebrew/bin/kubectl ]] && source <(kubectl completion zsh)
alias util='kubectl get nodes --no-headers | awk '\''{print $1}'\'' | xargs -I {} sh -c '\''echo {} ; kubectl describe node {} -n bosa-prod | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo '\'''
alias cpualloc='util | grep % | awk '\''{print $1}'\'' | awk '\''{ sum += $1 } END { if (NR > 0) { print sum/(NR*20), "%\n" } }'\'''
alias memalloc='util | grep % | awk '\''{print $5}'\'' | awk '\''{ sum += $1 } END { if (NR > 0) { print sum/(NR*75), "%\n" } }'\'''
source <(velero completion zsh)

# flutter
export PATH="$PATH:/Users/simon/workspace/flutter/bin"
