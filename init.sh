#!/bin/sh
rm -f ~/.zshenv ~/.zshrc ~/.zprofile
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

cargo install --git https://github.com/sugiura-hiromichi/tp
cargo install --git https://github.com/sugiura-hiromichi/cn
cargo install --git https://github.com/sugiura-hiromichi/gc
cargo install --git https://github.com/sugiura-hiromichi/dot
dot

cd ~/.config

brew bundle

pip3 install neovim
gem install neovim

echo '|> initalization finished'
