# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
setopt auto_cd
autoload -Uz compinit && compinit

#basic commands
alias s='exa -la --icons --group-directories-first --sort=extension'
alias nv='nvim'
alias gi='git init'
alias ga='git add . ; git commit'
alias gp='git push'
alias gc='git clone'
alias gl='git pull'
alias bu='brew upgrade'
alias bi='brew install'
alias bl='brew list'
alias bs='brew search'
alias cr='cargo run'
alias cb='cargo build'
alias ct='cargo test'

#eval
eval $(starship init zsh)

#exports
export EDITOR=nvim
export VISUAL=nvim
export RUBY_HOST=$(which neovim-ruby-host)
#export XDG_CONFIG_HOME=$HOME/dotfiles

#!!!!!!!!!! Make sure that PATHs are in .zprofile!!!!!!!!!

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
