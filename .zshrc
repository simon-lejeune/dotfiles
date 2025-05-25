# zmodload zsh/zprof

disable r
bindkey "\e[1;3D" backward-word       # alt - left
bindkey "\e[1;3C" forward-word        # alt - right
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
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This lazy loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#export PATH="`yarn global bin`:$PATH"
export NODE_VERSIONS="${NVM_DIR}/versions/node"
export NODE_VERSION_PREFIX="v"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

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

# google cloud sdk
source /Users/simon/workspace/google-cloud-sdk/path.zsh.inc
source /Users/simon/workspace/google-cloud-sdk/completion.zsh.inc

# zprof
# time  zsh -i -c exit
