#!/usr/bin/env bash 

PHONE _IP="" #leave it blank if you use hotspot method
PHONE_PORT=2222 #default
PHONE_USER=
MOUNT_DIR=

if mountpoint -q ~/cloud; then 
    if fusermount -uz ~/cloud; then
        notify-send "Phone Cloud" "Unmounted"
    else
        notify-send "Phone Cloud" "Unmount Failed"
    fi
else 
     if [ -z "$PHONE_IP" ]; then
        PHONE_IP=$(ip route show default | awk '{print $3}')
        if  [ -z "$PHONE_IP" ]; then 
            notify-send "Phone Cloud" "No hotspot detected"
            exit 1
        fi
    fi
    if ! nc -z -w 1 "$PHONE_IP" "$PHONE_PORT" >/dev/null 2>&1; then
         notify-send "Phone Cloud" "phone not reachable"
         exit 1
    fi
    
    PASSWORD=$(rofi -dmenu -password \
     -theme ~/.config/rofi/password.rasi \
     -p "Cloud Password")

    [ -z "$PASSWORD" ] && exit 0
    if echo "$PASSWORD" | sshfs \
    -o password_stdin \
    -o reconnect \
    -o ServerAliveInterval=5 \
    -o ServerAliveCountMax=2 \
    -p "$PHONE_PORT" \
    "$PHONE_USER@$PHONE_IP":/ \
    "$MOUNT_DIR"; then
        notify-send "Phone Cloud" "mounted"
    else 
        notify-send "Phone Cloud" "mount failed"
    fi
fi
