#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias hx='helix'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

export EDITOR=helix

if [ "$(tty)" = "/dev/tty1" ]; then
    exec sway
fi

fwatch() {
    local fpath='/tmp/tf1.pid'
    tmux \
        send-keys "flutter run $* --pid-file=$fpath" Enter \; \
        split-window -v \; \
        send-keys "watchexec -p -w . -e dart 'cat $fpath | xargs kill -s USR1'" Enter \; \
        resize-pane -y 1 -t 1 \; \
        select-pane -t 0
}

export PATH="$PATH":"$HOME/.pub-cache/bin"

gh() {
  if [[ "$PWD" == *"/work/"* ]]; then
    command gh --user work-username "$@"
  else
    command gh --user personal-username "$@"
  fi
}

