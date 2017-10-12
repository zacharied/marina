autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats "𝐆 %r  %b"
zstyle ':vcs_info:*' formats "𝐆 %r  %b"

if [[ "$TERM" == 'linux' ]]; then
    VI_INDICATOR_NORMAL='N'
    VI_INDICATOR_INSERT='I'
    STARTER_ICON='->'
else
    VI_INDICATOR_NORMAL='♭'
    VI_INDICATOR_INSERT='♯'
    STARTER_ICON='♩'
fi

# Commands {{{

function rc::prompt::userinfo() {
    print -nP "%n@%M"
}

function rc::prompt::dir() {
    # Print the stack indicator if there is one
    [[ -n $dirstack ]] && print -n "$(( ${#dirstack[@]} + 1 ))☰ "

    print -nP "%(5~|%-1~/┅/%3~|%~)" | sed -e 's,/,  ,g' -e 's,^  ,/,'
}

function rc::prompt::vcs() {
    print -n "${vcs_info_msg_0_}"
}

function rc::prompt::exit_status() {
    print -n $last_status
}

typeset -a SECTIONS=(userinfo dir vcs exit_status)

# END Commands }}}

setopt prompt_subst

typeset last_status

function precmd() {
    last_status=$?

    # Automatically source RC files if they are changed
    for s in $CKSRC_FILES; do
        if ! $(cksrc::compare "$s"); then
            echo "Checksum for '$DOTS/$s' different. Reloading..."
            source "$DOTS/$s"
        fi

        cksrc::sum "$DOTS" "$s"
    done

    vcs_info

    if [[ $TERM != 'linux' ]]; then
        print -P "$(prompt_top_line)"
    fi
}

function prompt_top_line() {
    local -i i=1
    for sec in $SECTIONS; do
        local -i next=$(($i+1))

        output=$(rc::prompt::$sec)
        if [[ -n "$output" ]]; then
            print -nP "[ $output ]"
        fi

        local next_block="${SECTIONS[$next]}"
        if [[ -n "${next_block}" ]]; then
            echo -n '--'
        fi

        i+=1
    done
}

function prompt_bottom_line() {
    local starter
    if [[ "${KEYMAP}" =~ '(main|viins)' ]]; then
        starter="$VI_INDICATOR_INSERT"
    else
        starter="$VI_INDICATOR_NORMAL"
    fi

    print -P " $starter $STARTER_ICON "
}

function zle-line-init zle-keymap-select {
    if [[ "$TERM" == 'linux' ]]; then
        PS1="%F{2}%K{$1}%d $VI_MODE $STARTER_ICON %F{$FG1}"
    else
        # Then we initialize the PS1. Note that this is the second line; the first is handled by precmd().
        PS1=" $(prompt_bottom_line)"
    fi

    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# vim: ft=zsh
