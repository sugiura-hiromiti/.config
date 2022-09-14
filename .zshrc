# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
#zshrc is mainly for personal customizations like options, aliases, functions, eval ..

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
#alias cf='cargo fix'
alias wh='which -a'
alias so='source'

#functions
gc(){
  git clone https://github.com/qkvx/$1
  cd $1
  s
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
eval $(starship init zsh)

#make sure that /opt/homebrew/opt/llvm/bin/ is head of path
export PATH=$(brew --prefix llvm)/bin:$PATH

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
