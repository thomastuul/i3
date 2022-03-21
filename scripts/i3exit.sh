#!/usr/bin/env sh

## with openrc use loginctl
if [ "$(cat /proc/1/comm)" = "systemd" ]; then
    logind=systemctl
else
    logind=loginctl
fi

lock() {
    # use script for nice lock-screen
    i3lock-fancy -gpf Hack -- scrot -z
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        i3-msg exit
        ;;
    switch_user)
        dm-tool switch-to-greeter
        ;;
    suspend)
        $logind suspend
        ;;
    hibernate)
        $logind hibernate
        ;;
    reboot)
        $logind reboot
        ;;
    shutdown)
        $logind poweroff
        ;;
    *)
        echo "== ! $(basename $0): missing or invalid argument ! =="
        echo "Try again with: lock | logout | switch_user | suspend | hibernate | reboot | shutdown"
        exit 2
esac

exit 0
