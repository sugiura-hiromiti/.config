#zshrc is mainly for personal customizations like options, aliases, functions, eval ..

# Fig pre block. Keep at the top of this file.
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
fi

autoload -U compinit ; compinit
set -o autocd

#aliases
alias s='exa -lahF --icons --group-directories-first --sort=extension --time-style=iso --git --no-permissions --no-user'
alias nv='nvim'
alias gi='git init ; git add . ; git commit -m'
alias gl='git pull'
alias bu='brew upgrade'
alias bi='brew install'
alias bl='brew list'
alias bs='brew search'
alias cr='cargo run'
alias cb='cargo build'
alias ct='cargo test'
alias wh='which -a'
alias so='source'

#functions
gc(){
  git clone https://github.com/$1
}

ga(){
   git add .
   git commit -m $1
   git push
}

z(){
   cd $1
   s
}

eval $(brew shellenv)

if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
eval $(starship init zsh)
# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
fi
