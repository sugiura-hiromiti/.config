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

cargo install sugiura-hiromichi_tp
cargo install sugiura-hiromichi_gc
cargo install sugiura-hiromichi_dot

echo 'install dotfiles'

rm -rf .config
sugiura-hiromichi_dot

cd ~/.config
brew bundle

pip3 install neovim
gem install neovim

echo '|> initalization finished'

echo '|> customize macOS'

defaults write com.apple.finder AppleShowAllFiles TRUE

defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
