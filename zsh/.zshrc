# Location + size
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# History behavior
setopt append_history          # don’t overwrite history file
setopt inc_append_history      # write each command immediately
setopt share_history           # share between all running shells
setopt hist_ignore_dups        # don’t record duplicates
setopt hist_ignore_all_dups    # delete old duplicate commands
setopt hist_ignore_space       # ignore commands starting with space
setopt hist_reduce_blanks      # remove superfluous blanks
setopt hist_verify             # show before executing history expansion
setopt extended_history        # record timestamp of each command

bindkey '^R' history-incremental-search-backward
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Changes to the given directory after running yazi with the given arguments.
#
# This is a wrapper around yazi that allows it to change directories. It
# does this by running yazi with the --cwd-file option and then changing
# directories to the given file. The temporary file is then removed.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# env
export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/.local/bin:$PATH"

# aliases
alias vim="nvim"
alias viz="vim ~/.zshrc"
alias vin="vim ~/.config/nvim/init.lua"
alias clr="clear; fastfetch;"

# antidote setup
source '/usr/share/zsh-antidote/antidote.zsh'
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
# zsh-autosuggestions
bindkey '^ ' autosuggest-accept      
bindkey '^E' autosuggest-execute

# starship prompt init
eval "$(starship init zsh)"
clr
[[ -f ~/.ssh/agent.env ]] && source ~/.ssh/agent.env

export PATH=$PATH:/home/conart/.spicetify
