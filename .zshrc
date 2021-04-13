if (( ! ${fpath[(I)/usr/local/share/zsh/site-functions]} )); then
  FPATH=/usr/local/share/zsh/site-functions:$FPATH
fi
autoload -U compinit && compinit -i

disable r

# https://github.com/agkozak/agkozak-zsh-prompt
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

eval "$(direnv hook zsh)"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PYTHONDONTWRITEBYTECODE=True
export EDITOR=nvim

bindkey "^[[H" beginning-of-line  # ctrl - a
bindkey "^[[F" end-of-line        # ctrl - e
bindkey ";9D" backward-word       # alt - left
bindkey ";9C" forward-word        # alt - right
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)
