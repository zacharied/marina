readonly LOG_OUTPUT="$MY_RUN/rc_log"

readonly LOG_CHAR_DEBUG=''
readonly LOG_CHAR_INFO=''
readonly LOG_CHAR_WARN=''
readonly LOG_CHAR_ERROR=''

rc::log() {
    if [[ "$#" != 3 ]]; then
        rc::log -e 'Logger' 'Incorrect number of arguments provided to `rc::log`. Format: rc::log -[DIWE] $scope $message'
        return 1
    fi

    local arg_level="$1"
    local arg_scope="$2"
    local arg_message="$3"

    local level
    local color

    case "$arg_level" in
        '-D')
            level="$LOG_CHAR_DEBUG"
            color='7' # Gray
            ;;
        '-I')
            level="$LOG_CHAR_INFO"
            color='4' # Blue
            ;;
        '-W')
            level="$LOG_CHAR_WARN"
            color='3' # Yellow
            ;;
        '-E')
            level="$LOG_CHAR_ERROR"
            color='1' # Red
            ;;
    esac

    printf "[ $(tput setaf $color)%s$(tput sgr0) ]-[ %s ]\n" "$level" "$arg_scope" "$arg_message" >> "$LOG_OUTPUT"
}
