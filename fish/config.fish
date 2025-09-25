if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER less
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/rg/config"
set -gx MY_CUSTOM_ENV_VARS_CURRENTLY_EXECUTING_PROMPT ""

fish_add_path $HOME/.nix-profile/bin
fish_add_path /nix/var/nix/profiles/default/bin

direnv hook fish | source
zoxide init fish | source
starship init fish | source
