#!/bin/sh
rm -f ~/.zshenv ~/.zshrc ~/.zprofile
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ $(uname) = "Linux" ]; then
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

. "$HOME/.cargo/env"
. "$HOME/.profile"

cargo install --git https://github.com/sugiura-hiromichi/tp
cargo install --git https://github.com/sugiura-hiromichi/gc
cargo install --git https://github.com/sugiura-hiromichi/dot
dot

cd ~/.config

brew bundle

pip3 install neovim
gem install neovim

echo '|> initalization finished'
