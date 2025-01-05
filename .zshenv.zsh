# make sure that securityInfo is in .zprofile(which is in .gitignore)
set -o emacs
setopt AUTO_CD
# cdpath=(.. ~ ~/Downloads)

. $HOME/.profile
source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

#export PATH=$PATH:$HOME/.cargo/env
export PATH=$PATH:$HOME/.cargo/bin

#environment variables
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER=less
export RIPGREP_CONFIG_PATH=$HOME/.config/rg/config
export YABAI_CERT=yabai-cert
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/

#aliases
# to remove alias in zsh, simply just remove it
alias s='eza -ahlF --icons --group-directories-first --sort=extension --time-style=iso --git --no-user --no-time'
alias n='nvim'
alias u='yabai --stop-service ; yabai --uninstall-service ; brew upgrade ;
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai ;
yabai --start-service ;
rustup self update ; rustup update ; cargo install-update -a'
alias zo='z $OLDPWD'
alias gi='git init ; git add . ; git commit -m'
alias gl='git pull'
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
alias zenn='cd ~/Downloads/zenn/articles/ ; my_target_file=$(sk -ic '"'rg "'"{}"'"'"'| sed s"/:published: false//") ; n $my_target_file'

#functions
# To remove function in zsh, `unset -f [function name]`
function ga() {
	git add .
	git commit -m $1
	git push
}


function chpwd_print_dir() {
	if [[ $(pwd) != $HOME ]]; then;
		# alias `s` will be expanded
		s
	fi
}

# register hook function
autoload -Uz add-zsh-hook
add-zsh-hook chpwd chpwd_print_dir
