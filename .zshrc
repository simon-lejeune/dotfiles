disable r

# from official nvm installer
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# from brew's rbenv installer
eval "$(rbenv init -)"

# brew direnv
eval "$(direnv hook zsh)"

# need to clone in ~.zsh https://github.com/agkozak/agkozak-zsh-prompt
source ~/.zsh/agkozak-zsh-prompt/agkozak-zsh-prompt.plugin.zsh
export AGKOZAK_PROMPT_DIRTRIM=0
export AGKOZAK_LEFT_PROMPT_ONLY=1
export AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' 'S')

bindkey "^R" history-beginning-search-backward
alias ls='ls -G'
alias ll='ls -l'
alias cl='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias vim='nvim'

export PYTHONDONTWRITEBYTECODE=True
export EDITOR=nvim

bindkey "[D" backward-word       # alt - left
bindkey "[C" forward-word        # alt - right

defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)

# fix "perl: warning: Setting locale failed"
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
