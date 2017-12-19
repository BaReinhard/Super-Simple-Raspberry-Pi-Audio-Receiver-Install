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

remove_dir(){
    if [ -d $1 ]; then 
        if [ -L $1 ]; then 
            rm $1
        else 
            rmdir $1
        fi
    fi
}
restore_originals(){
    log Restoring Original Files...
    while IFS='' read -r line || [[ -n "$line" ]]; do
        FILE=`echo $line | sed "s/=.*//"`
        DIR=`echo $line | sed "s/.*=//"`
        log Restoring $FILE to "$DIR/$FILE"
        cp $FILE $DIR$FILE
    done < "$SSPARI_BACKUP_PATH/files"
}
save_original(){
    if [ -d $1 ]; then 
        if [ -L $1 ]; then 
            FILE=`echo $1 | sed "s/.*\///"`
            if [ -d "$SSPARI_BACKUP_PATH/$FILE" ]
            then
                log "File '$FILE' has been previously backed up"
            else
                log Saving $1...
                DIR=`dirname "$1"`
                DIR="$DIR/"
                echo $FILE
                echo $DIR
                echo "$FILE=$DIR" >> "$SSPARI_BACKUP_PATH/files"
                cp $1 "$SSPARI_BACKUP_PATH/$FILE"
        else 
            log "$1 is not a file or doesn't exist"
        fi
    fi
    
}
UNINSTALL_COMMAND="sudo apt-get remove -y"
apt_uninstall(){
    log Uninstalling $1...
    $UNINSTALL_COMMAND $1 &> /dev/null
    verify "Installation of package '$1' failed"
}
rem_files(){
    log "Removing File $1..."
    sudo rm $1
    verify "Removal of file '$1' failed"
}
rem_dir(){
    log "Removing Directory $1..."
    sudo rm -R $1
    verify "Removal of directory '$1' failed"
}
uninstall_bluetooth(){
    source $SSPARI_PATH/dependencies.sh
    for _dep in ${BT_DEPS[@]}; do
        apt_uninstall $_dep;
    done     
    sudo update-rc.d pulseaudio remove
    sudo update-rc.d bluetooth-agent remove
    sudo rm -R ~/pulseaudio
    sudo rm -R ~/libsndfile
    sudo rm -R ~/json-c
    cd $SSPARI_PATH
}
uninstall_airplay(){
    source $SSPARI_PATH/dependencies.sh
    for _dep in ${AIRPLAY_DEPS[@]}; do
        apt_uninstall $_dep;
    done
    sudo rm -R //root/pulseaudio     
}
uninstall_ap(){
    source $SSPARI_PATH/dependencies.sh
    for _dep in ${AP_DEPS[@]}; do
        apt_uninstall $_dep;
    done  
}
uninstall_gmedia(){
    source $SSPARI_PATH/dependencies.sh
    for _dep in ${GMEDIA_DEPS[@]}; do
        apt_uninstall $_dep;
    done  
}
uninstall_kodi(){
    source $SSPARI_PATH/dependencies.sh
    for _dep in ${KODI_DEPS[@]}; do
        apt_uninstall $_dep;
    done
    rm ~/.hushlogin  
}
uninstall_lirc(){
    source $SSPARI_PATH/dependencies.sh
    for _dep in ${LIRC_DEPS[@]}; do
        apt_uninstall $_dep;
    done  
}

remove_sspari_files(){
    source $SSPARI_PATH/dependencies.sh
    for _file in ${SSPARI_FILES[@]}; do
        if [ -d $_file ]; then 
            if [ -L $_file ]; then 
                rem_files $_file
            else 
                rem_dir $_file
            fi
        fi
    done 
    
}
full_uninstall(){
    # Restore Original Files
    restore_originals
    # Update Bluetooth to normal system daemon
    sudo update-rc.d bluetooth remove
    sudo update-rc.d bluetooth defaults
    sudo update-rc.d bluetooth enable
    remove_sspari_files

    # Uninstall Features
    uninstall_lirc
    uninstall_kodi
    uninstall_gmedia
    uninstall_ap
    uninstall_airplay
    uninstall_bluetooth
}