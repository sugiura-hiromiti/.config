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
export YABAI_CERT=yabai-cert

#aliases
# to remove alias in zsh, simply just remove it
alias s='eza -ahlF --icons --group-directories-first --sort=extension --time-style=iso --git --no-user --no-time'
alias n='nvim'
alias u='brew upgrade ; brew upgrade neovim --fetch-HEAD ; brew reinstall koekeishiya/formulae/yabai ; codesign -fs "${YABAI_CERT: -yabai-cert}" "$(brew --prefix yabai)/bin/yabai" ; export YABAI_PATH=$(which yabai) ; export YABAI_SHA_HASH=$(shasum -a 256 $YABAI_PATH) ; export MY_INIT_DOTFILES_HASH_OF_SHASUM="$USER ALL=(root) NOPASSWD: sha256:$YABAI_SHA_HASH --load-sa" ; sudo echo $MY_INIT_DOTFILES_HASH_OF_SHASUM >> /private/etc/sudoers.d/yabai ; rustup self update ; rustup update ; cargo install-update -a'
alias zo='z $OLDPWD'
alias gi='git init ; git add . ; git commit -m'
alias gl='git pull'
alias gm='git merge'
alias bu='brew uninstall'
alias bi='brew install'
alias bl='brew list'
alias bs='brew search'
alias ba='brew abv'
alias bb='brew bundle dump --all -f'
alias wh='which -a'
alias so='source'
alias dflt_a='defaults read > /tmp/dotfiles_init/a.log'
alias dflt_b='defaults read > /tmp/dotfiles_init/b.log ; diff /tmp/dotfiles_init/a.log /tmp/dotfiles_init/b.log'

#functions
# To remove function in zsh, `unset -f [function name]`
ga(){
	git add .
	git commit -m $1
	git push
}
