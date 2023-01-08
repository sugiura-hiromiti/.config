set -o emacs

export PATH=$PATH:$HOME/.cargo/env
export PATH=$PATH:$HOME/.cargo/bin

path=(
	/opt/homebrew/bin(N)
	/opt/homebrew/sbin(N)
	/usr/local/bin(N)
	/usr/local/sbin(N)
	~/.local/bin
	~/.local/sbin
	~/.fig/bin
	$path
)

#environment variables
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER=nvim

#aliases
alias s='exa -lahF --group-directories-first --sort=extension --time-style=iso --git --no-permissions --no-user --no-time'
alias n='nvim'
alias u='brew upgrade ; rustup self update ; rustup update ; cargo install --git https://github.com/sugiura-hiromichi/tp ;cargo install --git https://github.com/sugiura-hiromichi/cn ; cargo install --git https://github.com/sugiura-hiromichi/dot'
alias gi='git init ; git add . ; git commit -m'
alias gl='git pull'
alias bu='brew uninstall'
alias bi='brew install'
alias bl='brew list'
alias bs='brew search'
alias wh='which -a'
alias so='source'

#functions
# To remove function in zsh, `unset -f [function name]`
ga(){
	git add .
	git commit -m $1
	git push
}
