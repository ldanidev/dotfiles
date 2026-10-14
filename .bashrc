#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias hx='helix'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

export EDITOR=helix

if [ "$(tty)" = "/dev/tty1" ]; then
    exec sway
fi

export PATH="$PATH":"$HOME/.pub-cache/bin"

# Rebuild all generated artifacts (pub get, codegen, l10n) for snap360
snapbuild() {
    local root="/home/daniel/dev/snap360"
    if [[ -d "$root/snap360" && ! -d "$root/packages" ]]; then
        root="$root/snap360"
    fi

    if [[ ! -d "$root" ]]; then
        echo "✗ snap360 repo not found at $root"
        return 1
    fi

    __snap360_run() {
        echo "→ $*"
        "$@" || {
            echo "✗ failed: $*"
            return 1
        }
    }

    local prev_dir="$PWD"

    for dir in packages/widgets packages/core modules/auth .; do
        echo "=== $dir ==="
        cd "$root/$dir" || { cd "$prev_dir"; unset -f __snap360_run; return 1; }
        __snap360_run fvm flutter pub get || {
            cd "$prev_dir"
            unset -f __snap360_run
            return 1
        }
    done

    for dir in packages/core modules/auth .; do
        echo "=== codegen: $dir ==="
        cd "$root/$dir" || { cd "$prev_dir"; unset -f __snap360_run; return 1; }
        __snap360_run fvm dart run build_runner build --delete-conflicting-outputs || {
            cd "$prev_dir"
            unset -f __snap360_run
            return 1
        }
    done

    for dir in modules/auth .; do
        echo "=== gen-l10n: $dir ==="
        cd "$root/$dir" || { cd "$prev_dir"; unset -f __snap360_run; return 1; }
        __snap360_run fvm flutter gen-l10n || {
            cd "$prev_dir"
            unset -f __snap360_run
            return 1
        }
    done

    cd "$prev_dir"
    unset -f __snap360_run
    echo "✓ build complete"
}


