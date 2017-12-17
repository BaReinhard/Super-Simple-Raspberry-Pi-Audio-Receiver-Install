#!/bin/bash
log() {
    echo -ne "\e[1;34mSSRPARI \e[m" >&2
    echo -e "[`date`] $@"
}
installlog() {
    echo -ne "\e[1;34mSSRPARI \e[m" >&2
    echo -e "$@"
}
YesNo() {
        # Usage: YesNo "prompt"
        # Returns: 0 (true) if answer is Yes
        #          1 (false) if answer is No
        while true
        do
                read -p "$1" answer
                case "$answer" in
                [nN]*)
                        answer="1"; break;
                ;;
                [yY]*)
                        answer="0"; break;
                ;;
                *)
                        echo "Please answer y or n"
                ;;
                esac
        done
        return $answer
}
verify() {
    if [ $? -ne 0 ]; then
        echo "Fatal error encountered: $@"
        exit 1
    fi
}
tst() {
        echo "===> Executing: $*"
        if ! $*; then
                echo "Exiting script due to error from: $*"
                exit 1
        fi
}

apt_install() {
    log Installing $1...
    $INSTALL_COMMAND $1 &> /dev/null
    verify "Installation of package '$1' failed"
}
run(){
   log Running $*...
   $*
   verify "'$1' failed"
}
exc(){
    log Executing $*
    $* &> /dev/null
    verify "'$*' failed"
}
apt_update() {
    log Updating via $*...
    $*
    verify "'$*' failed"
}
apt_upgrade() {
    log Upgrading via $*...
    $*
    verify "'$*' failed"
}
