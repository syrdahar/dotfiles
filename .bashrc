#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Environment variables
export EDITOR=vim
export XDG_CONFIG_HOME=$HOME/.config


alias ls='ls --color=auto'
alias l='ls -la --color=auto'
alias grep='grep --color=auto'

alias nl='nmcli device wifi'

PS1='[\u@\h \W]\$ '
