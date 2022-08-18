#zshenv is mainly for exporting paths, environment variables

export PATH=$PATH:$HOME/.cargo/env
export PATH=$PATH:$HOME/.cargo/bin

typeset -gU cdpath fpath mailpath path

path=(
	$HOME/bin(N)
	$HOME/sbin(N)
	/opt/homebrew/bin(N)
	/opt/homebrew/sbin(N)
	/usr/local/bin(N)
	/usr/local/sbin(N)
	$path
)

#path to llvm
export PATH="$(brew --prefix llvm)/bin:$PATH"
export LDFLAGS="-L$(brew --prefix llvm)/lib"
export CPPFLAGS="$(brew --prefix llvm)/include"

export EDITOR=nvim
export VISUAL=nvim
export RUBY_HOST=$(which neovim-ruby-host)
#export XDG_CONFIG_HOME=$HOME/dotfiles


#eval $(starship init zsh) is in zshrc
