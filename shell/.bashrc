#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export NEWT_COLORS="root=white,black;window=white,black;border=cyan,black;title=cyan,black;label=white,black;listbox=white,black;actlistbox=black,cyan;button=white,black;actbutton=black,cyan;checkbox=white,black;actcheckbox=black,cyan;entry=white,black"
