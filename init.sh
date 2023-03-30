#!/bin/sh
cd ~
rm -f ~/.zshenv ~/.zshrc ~/.zprofile
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ $(uname) = "Linux" ]; then
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

touch $HOME/.profile
. "$HOME/.cargo/env"
. "$HOME/.profile"

echo 'install my cargos'

cargo install tp_
cargo install gc_
cargo install dot_

echo 'install dotfiles'

rm -rf .config
dot_

brew install rcmdnk/file/brew-file
brew file install

pip3 install neovim
gem install neovim

echo '|> initalization finished'

echo '|> customize macOS'

if [ $(uname) = "Darwin" ]; then
	defaults write com.apple.finder AppleShowAllFiles TRUE
	defaults write -g InitialKeyRepeat -int 10
	defaults write -g KeyRepeat -int 1
fi
