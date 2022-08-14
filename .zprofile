# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && . "$HOME/.fig/shell/zprofile.pre.zsh"

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
PATH="$(brew --prefix llvm)/bin:$PATH"
LDFLAGS="-L$(brew --prefix llvm)/lib"
CPPFLAGS="$(brew --prefix llvm)/include"

eval $(brew shellenv)
# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && . "$HOME/.fig/shell/zprofile.post.zsh"
