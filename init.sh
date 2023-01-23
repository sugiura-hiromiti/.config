#!/bin/sh
rm -rf ~/.*
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo 'adding cargo to $PATH'
source "$HOME/.cargo/env"

cargo install --git https://github.com/sugiura-hiromichi/tp
cargo install --git https://github.com/sugiura-hiromichi/cn
cargo install --git https://github.com/sugiura-hiromichi/gc
cargo install --git https://github.com/sugiura-hiromichi/dot
/bin/bash -c $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
dot

if $XDG_CONFIG_HOME then
	cd $XDG_CONFIG_HOME
else
	cd ~/.config
fi

brew bundle

pip3 install neovim
gem install neovim

echo '|> initalization finished'
