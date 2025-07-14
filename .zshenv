# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

set -o emacs
setopt incappendhistory
# setopt AUTO_CD
# cdpath=(.. ~ ~/Downloads)

. $HOME/.profile
# source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
[ -f "/Users/a/.ghcup/env" ] && . "/Users/a/.ghcup/env" # ghcup-env

#environment variables
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER=less
export RIPGREP_CONFIG_PATH=$HOME/.config/rg/config
export YABAI_CERT=yabai-cert
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/
export MY_CUSTOM_ENV_VARS_CURRENTLY_EXECUTING_PROMPT=''

#aliases
# to remove alias in zsh, simply just remove it
alias s='eza -ahlF --icons --group-directories-first --sort=extension --time-style=iso --git'
alias n='nvim'
alias u='yabai --stop-service ; yabai --uninstall-service ; brew upgrade ;
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai ;
yabai --start-service ;
rustup self update ; rustup update ; cargo install-update -a'
alias zo='z $OLDPWD'
# alias gi='git init ; git add . ; git commit -m'
alias gl='git pull'
alias gp='git push'
alias gm='git merge'
alias bu='brew uninstall'
alias bi='brew install'
alias bl='brew list'
alias bs='brew search'
alias ba='brew abv'
alias bb='brew bundle dump --all -f'
alias wh='which -a'
alias so='source'
alias dflt_a='defaults read > /tmp/dotfiles_init/a.log'
alias dflt_b='defaults read > /tmp/dotfiles_init/b.log ; diff /tmp/dotfiles_init/a.log /tmp/dotfiles_init/b.log'
# alias zenn='cd ~/Downloads/zenn/articles/ ; my_target_file=$(sk -ic '"'rg "'"{}"'"'"'| sed s"/:published: false//") ; n $my_target_file'
alias gac='~/.config/user_script/auto_commit.sh'

#functions
# To remove function in zsh, `unset -f [function name]`
function ga() {
	git add .
	git commit -m $1
	git push
}

function ntfy() {
	echo -e "\033]777;notify;${1};${2}\007"
}

function chpwd_print_dir() {
	if [[ $(pwd) != $HOME ]]; then
		# alias `s` will be expanded
		s
	fi
}

function set_current_program_var() {
	MY_CUSTOM_ENV_VARS_CURRENTLY_EXECUTING_PROMPT=$history[$((${(%):-%h}))]
	echo -ne "\033]0;${MY_CUSTOM_ENV_VARS_CURRENTLY_EXECUTING_PROMPT}\007"
}

function clear_current_program_var() {
	MY_CUSTOM_ENV_VARS_CURRENTLY_EXECUTING_PROMPT=$PWD
	echo -ne "\033]0;${MY_CUSTOM_ENV_VARS_CURRENTLY_EXECUTING_PROMPT}\007"
}

# register hook function
autoload -Uz add-zsh-hook
add-zsh-hook chpwd chpwd_print_dir
add-zsh-hook preexec set_current_program_var
add-zsh-hook precmd clear_current_program_var

export PATH=/opt/homebrew/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
# export PATH=/opt/homebrew/opt/llvm@17/bin:$PATH
# export PATH=/opt/homebrew/sbin:$PATH
export PATH=$PATH:/Users/a/Library/Python/3.9/bin
# eval "$(zoxide init zsh)"
# eval "$(starship init zsh)"
# export ZELLIJ_AUTO_ATTACH=true
# eval "$(zellij setup --generate-auto-start zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
