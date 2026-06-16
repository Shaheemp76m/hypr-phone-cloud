#!/usr/bin/env bash 

PHONE _IP=
PHONE_PORT=2222
USER=

if mountpoint -q ~/cloud; then 
    if fusermount -uz ~/cloud; then
        notify-send "Phone Cloud" "Unmounted"
    else
        notify-send "Phone Cloud" "Unmount Failed"
    fi
else 
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
    "$USER"@"$PHONE_IP":/ \
    ~/cloud; then
        notify-send "Phone Cloud" "mounted"
    else 
        notify-send "Phone Cloud" "mount failed"
    fi
fi
