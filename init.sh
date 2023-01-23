#!/bin/sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install --git https://github.com/sugiura-hiromichi/tp
cargo install --git https://github.com/sugiura-hiromichi/cn
cargo install --git https://github.com/sugiura-hiromichi/gc
cargo install --git https://github.com/sugiura-hiromichi/dot
rm, -rf ~/.*
/bin/bash -c\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)

if $XDG_CONFIG_HOME then
	cd $XDG_CONFIG_HOME
else
	cd ~/.config
fi

echo "|>`dot` and `brew bundle` is optional."
