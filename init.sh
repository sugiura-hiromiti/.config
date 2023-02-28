#!/bin/sh
cd ~
rm -f ~/.zshenv ~/.zshrc ~/.zprofile
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ $(uname) = "Linux" ]; then
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

. "$HOME/.cargo/env"
. "$HOME/.profile"

cargo install sugiura-hiromichi_tp
cargo install sugiura-hiromichi_gc
cargo install sugiura-hiromichi_dot
dot

cd ~/.config

brew bundle

pip3 install neovim
gem install neovim

echo '|> initalization finished'
