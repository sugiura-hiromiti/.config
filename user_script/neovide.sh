#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title neovide
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName open_neovide

# Documentation:
# @raycast.description open neovide
# @raycast.author sugiura-hiromichi
# @raycast.authorURL https://raycast.com/sugiura-hiromichi

export PATH=$HOME/.nix-profile/bin/:$PATH
neovide
