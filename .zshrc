#aliases
alias s='exa -lahF --group-directories-first --sort=extension --time-style=iso --git --no-permissions --no-user --no-time --no-filesize'
alias n='nvim'
alias u='brew upgrade ; rustup self update ; rustup update'
alias gi='git init ; git add . ; git commit -m'
alias gl='git pull'
alias bu='brew uninstall'
alias bi='brew install'
alias bl='brew list'
alias bs='brew search'
alias cr='cargo run'
alias cb='cargo build'
alias ct='cargo test'
alias wh='which -a'
alias so='source'

#functions
# To remove function in zsh, `unset -f [function name]`
ga(){
   git add .
   git commit -m $1
   git push
}

a(){
   cd $1
   s
}

eval $(brew shellenv)
eval $(starship init zsh)

export XDG_CONFIG_HOME=$HOME/dotfile
