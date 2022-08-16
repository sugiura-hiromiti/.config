set -o autocd
autoload -U compinit ; compinit
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
gc () {
  git clone https://github.com/$1
}

ga(){
   git add .
   git commit -m $1
   git push
}



if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
eval $(starship init zsh)
fi

#!!!!!!!!!! Make sure that PATHs are in .zshenv!!!!!!!!!
