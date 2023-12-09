#!/bin/sh
cd ~
rm -f ~/.zshenv ~/.zshrc ~/.zprofile
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ $(uname) = "Linux" ]; then
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ $(uname) = "Darwin" ]; then
	(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

touch $HOME/.profile
. "$HOME/.cargo/env"
. "$HOME/.profile"
. "$HOME/.zprofile"

echo 'install my cargos'

cargo install tp_
cargo install gc_
cargo install dot_

echo 'install dotfiles'

rm -rf .config
dot_

brew tap Homebrew/bundle
brew bundle

echo '|> initalization finished'

if [ $(uname) = "Darwin" ]; then
	echo '|> customize macOS'
	defaults write com.apple.finder AppleShowAllFiles TRUE
	defaults write -g InitialKeyRepeat -int 10
	defaults write -g KeyRepeat -int 1
	defaults write -g com.apple.trackpadscaling 4
fi
