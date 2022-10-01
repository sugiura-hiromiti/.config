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
	$path
)

#path to llvm
export LDFLAGS="-L$(brew --prefix llvm)/lib"
export CPPFLAGS="$(brew --prefix llvm)/include"
export LDFLAGS="-L$(brew --prefix llvm)/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"

#environment variables
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER=nvim
export RUBY_HOST=$(which neovim-ruby-host)
