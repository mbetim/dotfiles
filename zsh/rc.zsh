# Set vim as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

if [ "$TERM_PROGRAM" = "ghostty" ] || [ -n "$GHOSTTY_RESOURCES_DIR" ]; then
  export TERM="xterm-ghostty"
fi

if [ "$TERM_PROGRAM" = "rex" ]; then
  export TERM="xterm-rex"
fi

# alias
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gcb='git checkout -b'
alias gpl="git pull"
alias gplo="git pull origin"
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

alias wts="wt switch --no-cd"

alias oc="opencode"

alias ghpc="gh pr checkout"
alias ghpl="gh pr list"
alias gvw="gh repo view -w"

alias dps="docker ps"
alias dcu="docker compose up"
alias dcd="docker compose down"

alias vim="nvim"
alias v="$HOME/.local/opt/nvim-nightly/bin/nvim"
alias vstable="nvim"
alias vs="nvim -c \"lua require('persistence').load()\""
alias db="nvim +DBUI"

alias c="clear"
alias md='mkdir -p'

alias l="eza -lah --icons --git --no-user"
alias ls=eza

alias rm="trash"

alias tn="tmux new -s"
alias ta="tmux a -t"

alias nvmu="fnm use --install-if-missing"
alias nvml="fnm use --install-if-missing lts-latest"

alias nd='terminal-notifier -title "Task finished" -message "Done with task! Exit status: $?"'

alias oo='cd ~/dev/obsidian/flat && nvim'

alias cdt='cd ../..'
alias pn=pnpm

alias wm=workmux

function ..() {
  cd ../..
}

function ...() {
  cd ../../..
}

function ....() {
  cd ../../../..
}

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

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

function d() {
  if [ ! -f package.json ]; then
    echo "No package.json found"
    return
  fi

  chosen_script=$(cat package.json | jq -r '.scripts | keys | .[]' | fzf  --height 20% --layout=reverse --preview "cat package.json | jq -r '.scripts | .[\"{}\"]'")

  if [[ ${#chosen_script} == 0 ]]; then
    return
  fi

  print -s  "nr $chosen_script"
  eval nr $chosen_script
}

function p() {
  local root=$(git rev-parse --show-toplevel 2>/dev/null) || return 1
  
  local dest=$( \
    (cd "$root" && fd -t f "^package\.json$" --exclude node_modules -x echo {//}) \
    | fzf --height 20% --layout=reverse --preview "bat --color=always --style=numbers $root/{}/package.json" \
  )
  
  if [[ -n "$dest" ]]; then
    cd "$root/$dest"
  fi
}

# Auto suggestions
: ${HOMEBREW_PREFIX:=/opt/homebrew}
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept
bindkey '^y' autosuggest-accept
bindkey '^w' vi-forward-word # accept the word

# Syntax highlight
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(fnm env --version-file-strategy=recursive --corepack-enabled --resolve-engines=false --shell zsh)"
autoload -U add-zsh-hook
_fnm_use() {
  fnm use --silent-if-unchanged 2>/dev/null ||
    { fnm install && fnm use --silent-if-unchanged; }
}
add-zsh-hook chpwd _fnm_use
_fnm_use

fpath=("$HOME/Library/Caches/eas-cli/autocomplete/functions/zsh"(N/) $fpath)

# Enable tab with case insensitive
autoload -Uz +X compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/dev/bin:$PATH
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"

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

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
[ -s "/Users/matheus.betim/.bun/_bun" ] && source "/Users/matheus.betim/.bun/_bun"

# NI
export NI_DEFAULT_AGENT="pnpm" # default "prompt"
export NI_GLOBAL_AGENT="pnpm"

# Android studio
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# zsh-vi-mode
if [[ -z "$NVIM" ]]; then
  source $HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi

# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  # Disable fzf Ctrl-R binding
  bindkey '^r' atuin-search

  # Bindings for 
  bindkey '^ ' autosuggest-accept
  bindkey '^y' autosuggest-accept
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
export PATH="$HOME/.local/bin:$PATH"
