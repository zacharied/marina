#       _    _ _
#      / \  | (_) __ _ ___  ___  ___
#     / _ \ | | |/ _` / __|/ _ \/ __|
#    / ___ \| | | (_| \__ \  __/\__ \
#   /_/   \_\_|_|\__,_|___/\___||___/
#

# {{{1 Aliases
# Simple redirections of basic shell commands. Should be mostly self-explanatory.

# Create a directory and move into it.
function mkdirc() {
    if [[ $# > 1 ]]; then
        echo "$0: cannot cd into more than one directory"
        return 1
    fi

    mkdir "$1" && cd "$1"
}

alias v="$EDITOR"
alias sv="sudoedit"

# LC_COLLATE='C' makes dotfiles be listed first.
alias ls="LC_COLLATE='C' ls -hl --color=auto"
alias lsa="ls -A"

# Navigation shortcuts.
alias pud="pushd"
alias pod="popd"

alias ~="cd ~"

# {{{2 Git
if [[ -d /lib/git-core ]]; then
    for f in /usr/lib/git-core/*(.); do
        alias G${f##*git-}=$f
    done
fi

alias Ga='git add'

alias Gco='git commit'
alias Gcl='git clone'
alias Gck='git checkout'
alias Gc='Gco'

alias Gdi='git diff'
alias Gd='Gdi'

alias Gg='git grep'

alias Gi='git init'

alias Glo='git log'
alias Gl='Glo'

alias Gps='git push'
alias Gpl='git pull'

alias Gst='git status'
alias Gs='Gst'

alias Gr='gitroot'

# {{{2 Vagrant
alias Vu='vagrant up'
alias Vh='vagrant halt'
alias Vs='vagrant ssh'

alias cpup='cpupower'

function sudoedit() {
    if test -L "$1"; then
        read "?$0: '$1' is a link. Resolve link? [y/n] " yn
        [[ $yn =~ [Yy] ]] && command sudoedit "$(readlink "$1")"
    else
        command sudoedit "$1"
    fi
}

alias office2pdf='libreoffice --headless --convert-to pdf'

###############
# {{{1 Functions
# Custom shell commands that perform complex operations.

# Enable color for manpages.
function man() {
    LESS_TERMCAP_md=$'\e[01;31m'    \
    LESS_TERMCAP_me=$'\e[0m'        \
    LESS_TERMCAP_se=$'\e[0m'        \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m'        \
    LESS_TERMCAP_us=$'\e[01;32m'    \
    command man "$@"
}

# Ascend to the root of a git repository.
function gitroot() {
    git rev-parse --show-toplevel
}

# Perform actions with GitHub via git
function gith() {
    case "$1" in
        clone)
            if [[ "$2" =~ '.*/.*' ]]; then
                git clone "https://github.com/$2"
                return 0
            else
                echo "$0: invalid repository." >&2
                return 1
            fi
            ;; 
        *)
            echo "$0: command not found "$1"."
            ;;
    esac

    echo "Valid commands are:"
    echo "\tclone"
    return 1
}

# Quickly access dotfiles
function dots() {
    pushd "$DOTS/$1"
}

# Open a new file in a sandbox directory
function sandbox() {
    if [[ ! -z $SANDBOX ]]; then
        # If there is a trailing slash, then we edit in a directory. Otherwise, we edit a file.
        if [[ $1 =~ '^.*/$' ]]; then
            mkdir -p "$SANDBOX/$1"
        fi

        "$EDITOR" "$SANDBOX/$1"
    else
        echo "$0: \$SANDBOX not defined." >&2
    fi
}

function zath() {
    if [[ ! -f "${@[-1]}" ]]; then
        echo "$0: File not found: '${@[-1]}'"
        return 1
    fi

    local -i wid=$(xdotool getactivewindow)
    xdo hide $wid
    zathura "$@"
    xdo show $wid
}


# Edit a specific rc file.
function rc() {
    local -A RC_OPTIONS
    RC_OPTIONS[a]='shell/alias.sh'
    RC_OPTIONS[b]='bspwm/bspwmrc'
    RC_OPTIONS[e]='shell/environment.sh'
    RC_OPTIONS[z]='zsh/zshrc'
    RC_OPTIONS[v]='nvim/init.vim'
    RC_OPTIONS[vf]='nvim/ftplugin'
    RC_OPTIONS[vr]='nvim/rc'

    function options() {
        echo "Valid options are:" >&2
        for key in "${(@k)RC_OPTIONS}"; do
            echo "$key\t${RC_OPTIONS[$key]}" >&2
        done
    }

    if [[ $# == 0 ]]; then
        echo "$0: No rc file given." >&2
        options
        return 1
    fi

    local shortfile="${RC_OPTIONS[$1]}"
    if [[ -n "$shortfile" ]]; then
        if [[ -z "$shortfile" ]]; then
            echo "$0: not a file: '$1'" >&2
            echo "This is most likely a configuration error." >&2
            return 2
        fi
        local file="$DOTS/$shortfile"
        if [[ -f "$file" ]]; then
            $EDITOR "$file"
        elif [[ -d "$file" ]]; then
            pushd "$file"
        fi
    else
        echo "$0: Invalid rc file '$1'." >&2
        options
        return 1
    fi
}

function trs() {
    if [[ -z "$MY_TRASH" ]]; then
        read "?\$MY_TRASH is not set. Use rm instead? [y/n] " yn
        if [[ $yn =~ [Yy] ]]; then
            command rm "$@"
            return 0
        else
            return 1
        fi
    elif [[ ! -d "$MY_TRASH" ]]; then
        echo "Junk directory not found. Creating it..."
        echo "mkdir $MY_TRASH"
        mkdir "$MY_TRASH"
    fi

    for file in "$@"; do
        if [[ -f "$file" || -d "$file" ]]; then
            mv "$file" "$MY_TRASH"
        else
            echo "$0: not a file: $file" >&2
            return 1
        fi
    done
}

function find_editor_window() {
    # Check for presence of argument
    if [[ $# > 1 ]]; then
        echo "$0: can only handle 1 argument." >&2
        return 2
    elif [[ $# == 0 ]]; then
        echo "$0: no argument given." >&2
        return 1
    fi

    # Check absolute or relative path
    if [[ "${1:0:1} == / || "${1:0:2} =~ '~[/a-z]' ]]; then
        local file="$1"
    else
        local file="$PWD/$1"
    fi

    # Store swapfile name
    swapfile="${file//\//%}.swp"

    # TODO: Softcode swap directory.
    # Get owner process of swapfile and strip leading space.
    local swap_pid=${$(fuser ~/.local/share/nvim/swap/${swapfile} 2>/dev/null)# }

    # Temporary variable for finding the Alacritty process owning nvim
    local term_pid=$swap_pid
    while [[ "$(ps -p $term_pid -o comm\= 2>/dev/null)" != "$TERM_EMULATOR" && $term_pid != 1 ]]; do
        term_pid=$(ps -p $term_pid -o ppid\= 2>/dev/null)
    done

    echo $swap_pid
    echo $term_pid

    if [[ -n "$swap_pid" && $term_pid != 1 ]]; then
        read "?$0: swapfile found. Switch to window? [y/n] " yn
        if [[ $yn == [Yy] ]]; then
            xdo activate -p $term_pid
        else
            nvim $1
        fi
    fi
}

alias xv='find_editor_window'

thi() {
	$@ &
	bg_pid=$!
	ppid=$(ps -o ppid= -p $$)
	xdo hide -p $ppid
	wait $bg_pid
	xdo show -p $ppid
}

# END FUNCTIONS }}}


# vim: ft=zsh fdm=marker :
