export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
#export LSCOLORS=exfxcxdxbxegedabagacad

## Colorize the ls output ##
alias ls='ls -G'
 
## Use a long listing format ##
alias ll='ls -alG'
 
## Show hidden files ##
alias l.='ls -dG .*'

alias ..='cd ..'
alias ...='cd ../../../'

alias grep='grep --color=auto'

alias mkdir='mkdir -pv'

alias h='history'
alias j='jobs -l'

alias vi=vim
alias edit='vim'

alias ports='netstat -tulanp'

alias sshazm='ssh -i ~/.ssh/FunkyGamer  lining@52.230.80.67'
alias sshazn1='ssh -i ~/.ssh/FunkyGamer lining@52.163.52.70'
