# Set vim as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"
export TERM="xterm-ghostty"

# alias
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gcb='git checkout -b'
alias gpl="git pull"
alias gco='git checkout'
alias gcm='git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed "s@^refs/remotes/origin/@@")'
alias gcd="git checkout develop"
alias gf='git fetch'
alias gfo='git fetch origin'
alias glo='git log --oneline --decorate'
alias gp='git push'
alias gpf='git push --force-with-lease --force-if-includes'
alias grs='git restore'
alias gst='git status'
alias gw='git worktree'
alias gwl='git worktree list'
alias gwa='git worktree add'
alias gwp='git worktree prune'
alias lg="lazygit"

alias ld="lazydocker"
alias lzn="lazynpm"

alias bpl="bit pr list"
alias bpc="bit pr checkout"

alias ghpc="gh pr checkout"
alias ghpl="gh pr list"
alias gvw="gh repo view -w"

alias dps="docker ps"
alias dcu="docker compose up"
alias dcd="docker compose down"

alias vim="nvim"
alias v="nvim"
alias vs="nvim -c \"lua require('persistence').load()\""
alias db="nvim +DBUI"

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

alias cdt='cd ../..'

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias pn=pnpm

function take() {
  mkdir -p $1
  cd $1
}

function len() {
  str=$1
  echo ${#str}
}

function pbfile() {
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

  # node_pkg_manger="pnpm"
  #
  # if [ -f yarn.lock ]; then node_pkg_manger="yarn"
  # elif [ -f package-lock.json ]; then node_pkg_manger="npm"
  # fi
  #
  # print -s  "$node_pkg_manger run $chosen_script"
  print -s  "nr $chosen_script"
  eval nr $chosen_script
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

# Enable tab with case insensitive
autoload -Uz +X compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/dev/bin:$PATH
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

# Android studio
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# zsh-vi-mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  # Disable fzf Ctrl-R binding
  bindkey '^r' atuin-search

  # Bindings for 
  bindkey '^ ' autosuggest-accept
  bindkey '^w' vi-forward-word # accept the word
}

# Not sure what this was doing
# export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"

# Neovim switcher
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-old="NVIM_APPNAME=old-nvim-lazyvim nvim"

function nvims() {
  items=("default" "kickstart", "old-nvim-lazyvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s ^a "nvims\n"

# SDK
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"


. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh --disable-up-arrow)"
