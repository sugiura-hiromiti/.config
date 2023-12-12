#!/bin/sh

ssh-keygen -t ed25519 -C "sugiura130418@icloud.com"
eval "$(ssh-agent -s)"
echo "Host github.com\n\tAddKeysToAgent yes\n\tIdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
read -p "upload pub key to github then hit enter"

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
cargo install cargo-update

echo 'install dotfiles'

rm -rf .config
dot_

brew tap Homebrew/bundle
brew bundle

echo '|> initalization finished'

if [ $(uname) = "Darwin" ]; then
	echo '|> customize macOS'

	sudo nvram SystemAudioVolume=" "
	sudo pmset -b powermode 1
	sudo pmset -b displaysleep 2
	defaults write -g AppleShowAllExtensions -bool true
	defaults write -g InitialKeyRepeat -int 10
	defaults write -g KeyRepeat -int 1
	defaults write -g com.apple.trackpad.scaling 5
	defaults write -g com.apple.mouse.tapBehavior -int 1
	defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
	defaults write -g NSWindowResizeTime 0.1
	defaults write -g AppleSpacesSwitchOnActivate -bool false
	defaults write -g NSWindowResizeTime -float 0.001
	defaults write -g nSTableViewDefaultSizeMode -int 1
	#defaults write -g ApplePressAndHoldEnabled -bool true
	defaults write -g _HIHideMenuBar -bool true
	defaults write -g AppleShowScrollBars -string "WhenScrolling"
	defaults write -g AppleScrollerPagingBehavior -int 1

	defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
	#defaults write com.apple.AppleMultitouchTrackpad DragLock -bool true
	#defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
	defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

	# force bluetooth bitrate upgrade
	defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

	# does not create .DS_Store on network
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
	defaults write com.apple.desktopservices DSDontWriteUSBStores -bool TRUE

	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock autohide-delay -float 0
	defaults write com.apple.dock autohide-time-modifier -float 0
	defaults write com.apple.dock show-recents -bool false
	defaults write com.apple.dock static-only -bool true
	defaults write com.apple.dock scroll-to-open -bool true
	# NOTE: disable mission control
	#defaults write com.apple.dock mcx-expose-disabled -bool true
	defaults write com.apple.dock launchanim -bool false
	defaults write com.apple.dock mineffect scale
	defaults write com.apple.dock mru-spaces -bool false
	defaults write com.apple.dock orientation right
	defaults write com.apple.dock expose-group-apps -bool true
	defaults write com.apple.dock tilesize -int 16
	defaults write com.apple.dock wvous-bl-corner -int 4
	defaults write com.apple.dock wvous-bl-modifier -int 0
	defaults write com.apple.dock wvous-br-corner  -int 14

	defaults write com.apple.finder AppleShowAllFiles TRUE
	defaults write com.apple.finder WarnOnEmptyTrash -bool false
	defaults write com.apple.finder ShowPathbar -bool true
	defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
	defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
	defautls write com.apple.finder WarnOnEmptyTrash -bool false
	defaults write com.apple.finder QLEnableTextSelection -bool true

	defaults write com.apple.LaunchServices LSQuarantine -bool false

	#defaults write com.apple.Music userWantsPlaybackNotifications -bool true

	# FIX: defaults write com.apple.universalaccess showWindowTitlebarIcons -bool true


	defaults write com.apple.spaces spans-displays -bool false

	defaults write com.apple.widgets widgetAppearance -int 2
	defaults write com.apple.WindowManager StandardhideDesktopIcons -int 0
	defaults write com.apple.WindowManager EnableStandarClickToShowDesktop -int 0
	defaults write com.apple.WindowManager StageManagerHideWidgets -bool false
	defaults write com.apple.WindowManager StandardHideWidgets -bool false
fi

sudo echo 'auth sufficient pam_tid.so' >> /etc/pam.d/sudo_local

read -p 'create certification for yabai, then hit enter:'
codesign -fs 'yabai-cert' $(brew --prefix yabai)/bin/yabai

export MY_INIT_DOTFILES_HASH_OF_SHASUM=
sudo echo $USER ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai)) --load-sa >> /private/etc/sudoers.d/yabai
yabai --start-service
read -p 'hit enter:'
skhd --start-service
read -p 'hit enter:'

sudo reboot
