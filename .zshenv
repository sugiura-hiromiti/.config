#zshenv is mainly for exporting paths, environment variables

autoload -U compinit ; compinit
set -o emacs

export PATH=$PATH:$HOME/.cargo/env
export PATH=$PATH:$HOME/.cargo/bin

typeset -gU cdpath fpath mailpath path

path=(
   /opt/homebrew/bin(N)
   /opt/homebrew/sbin(N)
   /usr/local/bin(N)
   /usr/local/sbin(N)
   ~/.local/bin
   ~/.local/sbin
	$path
)

#environment variables
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER=nvim
export RUBY_HOST=$(which neovim-ruby-host)
