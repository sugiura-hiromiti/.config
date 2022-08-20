#zshenv is mainly for exporting paths, environment variables

autoload -U compinit ; compinit
set -o autocd
set -o emacs

export PATH=$PATH:$HOME/.cargo/env
export PATH=$PATH:$HOME/.cargo/bin

typeset -gU cdpath fpath mailpath path

path=(
   /opt/homebrew/bin(N)
   /opt/homebrew/sbin(N)
	$HOME/bin(N)
	$HOME/sbin(N)
	$path
)

#path to llvm
export LDFLAGS="-L$(brew --prefix llvm)/lib"
export CPPFLAGS="$(brew --prefix llvm)/include"

export EDITOR=nvim
export VISUAL=nvim
export RUBY_HOST=$(which neovim-ruby-host)
#export XDG_CONFIG_HOME=$HOME/dotfiles
