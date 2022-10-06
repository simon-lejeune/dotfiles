disable r

# from official nvm installer
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="`yarn global bin`:$PATH"

# from brew's rbenv installer
eval "$(rbenv init -)"

# brew direnv
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
#autoload -Uz vcs_info
#precmd() { vcs_info }
#zstyle ':vcs_info:git:*' formats '%b '
#setopt PROMPT_SUBST
#PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

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
[[ /opt/homebrew/bin/kubectl ]] && source <(kubectl completion zsh)

export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"









alias util='kubectl get nodes --no-headers | awk '\''{print $1}'\'' | xargs -I {} sh -c '\''echo {} ; kubectl describe node {} -n bosa-prod | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo '\'''

# Get CPU request total (we x20 because because each m3.large has 2 vcpus (2000m) )
alias cpualloc='util | grep % | awk '\''{print $1}'\'' | awk '\''{ sum += $1 } END { if (NR > 0) { print sum/(NR*20), "%\n" } }'\'''

# Get mem request total (we x75 because because each m3.large has 7.5G ram )
alias memalloc='util | grep % | awk '\''{print $5}'\'' | awk '\''{ sum += $1 } END { if (NR > 0) { print sum/(NR*75), "%\n" } }'\'''


# PATH="/Users/simon/perl5/bin${PATH:+:${PATH}}"; export PATH;
# PERL5LIB="/Users/simon/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
# PERL_LOCAL_LIB_ROOT="/Users/simon/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
# PERL_MB_OPT="--install_base \"/Users/simon/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/Users/simon/perl5"; export PERL_MM_OPT;

source /Users/simon/.config/broot/launcher/bash/br

source <(velero completion zsh)
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
