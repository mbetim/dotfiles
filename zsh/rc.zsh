# Set vim as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"
export TERM="xterm-256color"

# alias
alias="g git"
alias ga="git add"
alias gb="git branch"
alias gcb='git checkout -b'
alias gpl="git pull"
alias gco='git checkout'
alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout $(git_develop_branch)'
alias gcod="git checkout develop"
alias gf='git fetch'
alias gfo='git fetch origin'
alias glo='git log --oneline --decorate'
alias gp='git push'
alias gpf='git push --force-with-lease --force-if-includes'
alias grs='git restore'
alias="gst git status"
alias lg="lazygit"

alias bpl="bit pr list"
alias bpc="bit pr checkout"

alias dps="docker ps"
alias dcu="docker compose up"
alias dcd="docker compose down"

alias vim="nvim"
alias v="nvim"
alias vs="nvim -c \"lua require('persistence').load()\""
alias db="nvim +DBUIToggle"

alias c="clear"
alias md='mkdir -p'

alias l="eza -lah --icons --git --no-user"
alias ls=eza

alias rm="trash"

alias tn="tmux new -s"
alias ta="tmux a -t"

alias nvmu="nvm use"
alias nvml="nvm use --lts"

alias nd='terminal-notifier -title "Task finished" -message "Done with task! Exit status: $?"'

alias oo='cd ~/dev/obsidian/flat && nvim'

alias yy='yazi'

alias pn=pnpm

function take() {
  mkdir -p $1
  cd $1
}

function len() {
  str=$1
  echo ${#str}
}

function cpfile() {
  cat $1 | pbcopy
}

function copyfile() {
  osascript \
    -e 'on run args' \
    -e 'set the clipboard to POSIX file (first item of args)' \
    -e end \
    "$(realpath $@)"
}

# Alias to switch user on git
function gu() {
  if [[ $1 == "personal" ]]; then
    git config user.email "mbetim47@gmail.com" "${@:2}"
  fi

  if [[ $1 == "synvia" ]]; then
    git config user.email "matheus.betim@synvia.com" "${@:2}"
  fi
}

function d() {
  if [ ! -f package.json ]; then
    echo "No package.json found"
    return
  fi

  chosen_script=$(cat package.json | jq -r '.scripts | keys | .[]' | fzf  --height 20% --layout=reverse --preview "cat package.json | jq -r '.scripts | .[\"{}\"]'")

  if [[ ${#chosen_script} == 0 ]]; then
    return
  fi

  node_pkg_manger="npm"

  if [ -f yarn.lock ]; then node_pkg_manger="yarn"
  elif [ -f pnpm-lock.yaml ]; then node_pkg_manger="pnpm"
  fi

  print -s  "$node_pkg_manger run $chosen_script"
  eval $node_pkg_manger run $chosen_script
}

# Auto suggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept
bindkey '^w' vi-forward-word # accept the word

# Syntax highlight
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Loads nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

export PATH=$HOME/.local/bin:$PATH
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/libexec/bin:$PATH"

# Settings for fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git --exclude Library --exclude node_modules'
export FZF_CTRL_T_OPTS='--preview="bat -n --color=always {}"'
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# TODO: try to move gcp cli to a different place
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/matheus.betim/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/matheus.betim/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/matheus.betim/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/matheus.betim/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# bit completions
source ~/.config/bit/bit-completion.zsh

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
[ -s "/Users/matheus.betim/.bun/_bun" ] && source "/Users/matheus.betim/.bun/_bun"

# zsh-vi-mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  # Bindings for 
  bindkey '^ ' autosuggest-accept
  bindkey '^w' vi-forward-word # accept the word
}

# Not sure what this was doing
# export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"

# SDK
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

