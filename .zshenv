# make sure that securityInfo is in .zprofile(which is in .gitignore)
set -o emacs
. $HOME/.profile

#export PATH=$PATH:$HOME/.cargo/env
export PATH=$PATH:$HOME/.cargo/bin

#environment variables
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER=less
export RIPGREP_CONFIG_PATH=$HOME/.config/rg/config

#aliases
# to remove alias in zsh, simply just remove it
alias s='exa -ahlF --icons --group-directories-first --sort=extension --time-style=iso --git --no-user --no-time'
alias n='nvim'
alias u='brew upgrade ; brew upgrade neovim --fetch-HEAD ; rustup self update ; rustup update ; cargo install-update -a ; npm install -g @githubnext/github-copilot-cli'
alias zo='z $OLDPWD'
alias gi='git init ; git add . ; git commit -m'
alias gl='git pull'
alias gm='git merge'
alias bu='brew uninstall'
alias bi='brew install'
alias bl='brew list'
alias bs='brew search'
alias ba='brew abv'
alias wh='which -a'
alias so='source'
alias ccc='cargo clean; cargo update'

#functions
# To remove function in zsh, `unset -f [function name]`
ga(){
	git add .
	git commit -m $1
	git push
}

eval "$(github-copilot-cli alias -- '$0')"
