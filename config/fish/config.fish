# disable greeting
set fish_greeting

abbr z zellij
abbr e helix
abbr c cargo
abbr ca cargo add
abbr cr cargo run
abbr g git
abbr gs git status
abbr gc git commit -am
abbr gcl git clone
abbr gck git checkout
abbr gp git push
abbr gb git branch
abbr z zellij
abbr zl zellij --layout
abbr fwatch watchexec -w . -e dart "zellij action move-focus down && zellij action write-chars 'r' && zellij action move-focus up"

set -Ux EDITOR helix
set fish_term24bit 1

if command -v eza >/dev/null
    abbr l eza
    abbr ls eza
    abbr ll 'eza -l'
    abbr lll 'eza -la'
end

if command -v paru >/dev/null
    abbr p paru
else
    abbr p 'sudo pacman -Syu'
end

# https://zellij.dev/documentation/integration
# if set -q ZELLIJ
# else
# zellij
# end

if command -v fvm >/dev/null
    abbr f 'fvm flutter'
    abbr fr 'fvm flutter run'
    abbr frdev 'fvm flutter run --flavor dev --target lib/main_dev.dart'
    abbr fc 'fvm flutter clean'
    abbr fpg 'fvm flutter pub get'
else
    abbr f flutter
    abbr fr flutter run
    abbr frdev 'flutter run --flavor dev --target lib/main_dev.dart'
    abbr fc 'flutter clean'
    abbr fpg flutter pub get
end

set TTY1 (tty)

if [ "$TTY1" = /dev/tty1 ]
    exec Hyprland
end

function fish_prompt
    set_color green
    echo -n $USER
    set_color brwhite
    echo -n @
    set_color yellow
    if command -v hostnamectl >/dev/null
        echo -n (hostnamectl hostname)
        # hostnamectl does not exists on macos
    else if command -v hostname >/dev/null
        echo -n (hostname)
    end
    if [ $PWD != $HOME ]
        set_color brblack
        echo -n ':'
        set_color yellow
        echo -n (basename $PWD)
    end
    set_color green
    printf '%s ' (__fish_git_prompt)
    set_color brblack
    echo -n '| '
    set_color normal
end

function snap360_build_all --description "Rebuild all generated artifacts (pub get, codegen, l10n) for snap360"
    set -l root /home/ldanidev/dev/snap360/snap360

    if not test -d $root
        echo "✗ snap360 repo not found at $root"
        return 1
    end

    function __snap360_run
        echo "→ $argv"
        eval $argv
        or begin
            echo "✗ failed: $argv"
            return 1
        end
    end

    set -l prev_dir (pwd)

    for dir in packages/widgets packages/core modules/auth .
        echo "=== $dir ==="
        cd $root/$dir
        or begin
            echo "✗ failed to cd to $root/$dir"
            cd $prev_dir
            functions -e __snap360_run
            return 1
        end
        __snap360_run fvm flutter pub get
        or begin
            cd $prev_dir
            functions -e __snap360_run
            return 1
        end
    end

    for dir in packages/core modules/auth .
        echo "=== codegen: $dir ==="
        cd $root/$dir
        or begin
            echo "✗ failed to cd to $root/$dir"
            cd $prev_dir
            functions -e __snap360_run
            return 1
        end
        __snap360_run fvm dart run build_runner build --delete-conflicting-outputs
        or begin
            cd $prev_dir
            functions -e __snap360_run
            return 1
        end
    end

    for dir in modules/auth .
        echo "=== gen-l10n: $dir ==="
        cd $root/$dir
        or begin
            echo "✗ failed to cd to $root/$dir"
            cd $prev_dir
            functions -e __snap360_run
            return 1
        end
        __snap360_run fvm flutter gen-l10n
        or begin
            cd $prev_dir
            functions -e __snap360_run
            return 1
        end
    end

    cd $prev_dir
    functions -e __snap360_run
    echo "✓ build complete"
end




# Added by Antigravity CLI installer
set -gx PATH "/home/ldanidev/.local/bin" $PATH
