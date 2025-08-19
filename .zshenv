# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"


set -o emacs
setopt incappendhistory

#environment variables
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER=less
export RIPGREP_CONFIG_PATH=$HOME/.config/rg/config
export MY_CUSTOM_ENV_VARS_CURRENTLY_EXECUTING_PROMPT=''

#aliases
alias s='eza -ahlF --icons --group-directories-first --sort=extension --time-style=iso --git'
alias n='nvim'
alias zo='z $OLDPWD'
alias wh='which -a'
alias gac='~/.config/user_script/auto_commit.sh'
alias u='(cd $HOME/.config/nix && \
echo "{}:
{
  user = \"$(whoami)\";
  arch = \"$(uname -m | sd arm aarch)\";
  os =\"$(uname -s | sd L l | sd D d)\";
  home = ${HOME};
}" > secret.nix && \
nix run .#update)'
alias sn="sk -m --ansi -ic 'rg {}' | sd ':.*' '' | xargs nvim"
alias g='~/.npm-packages/bin/gemini'
alias l='~/.config/user_script/lc.rs'

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

function title() {
	echo -ne "\033]0;${1}\007"
	if [ $(uname) = "Darwin" ]; then
		external_1 --trigger zsh_title TITLE="${1}"
	fi
}

function chpwd_print_dir() {
	# alias `s` will be expanded
	s
}

function set_current_program_var() {
	MY_CUSTOM_ENV_VARS_CURRENTLY_EXECUTING_PROMPT=$history[$((${(%):-%h}))]
	title ${MY_CUSTOM_ENV_VARS_CURRENTLY_EXECUTING_PROMPT}
}

function clear_current_program_var() {
	local last_exit_code=$?
	if [[ last_exit_code -ne 0 ]]; then
		ntfy "\`${MY_CUSTOM_ENV_VARS_CURRENTLY_EXECUTING_PROMPT}\` has failed" "with exit code: ${last_exit_code}"
	fi

	MY_CUSTOM_ENV_VARS_CURRENTLY_EXECUTING_PROMPT=$PWD
	title ${MY_CUSTOM_ENV_VARS_CURRENTLY_EXECUTING_PROMPT}
}

# register hook function
autoload -Uz add-zsh-hook
add-zsh-hook chpwd chpwd_print_dir
add-zsh-hook preexec set_current_program_var
add-zsh-hook precmd clear_current_program_var

export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:/Users/a/Library/Python/3.9/bin
eval "$(direnv hook zsh)"

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
