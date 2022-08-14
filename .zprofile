# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && . "$HOME/.fig/shell/zprofile.pre.zsh"
eval "$(brew shellenv)"
export PATH=$PATH:$HOME/.cargo/env
export PATH=$PATH:$HOME/.cargo/bin

typeset -gU cdpath fpath mailpath path

path=(
	$HOME/{,s}bin(N)
	/opt/{homebrew, local}/{,s}bin(N)
	/usr/local/{,s}bin(N)
	$path
)

#path to llvm
PATH="$(brew --prefix llvm)/bin:$PATH"
LDFLAGS="-L$(brew --prefix llvm)/lib"
CPPFLAGS="$(brew --prefix llvm)/include"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && . "$HOME/.fig/shell/zprofile.post.zsh"
