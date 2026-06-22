#!/usr/bin/env bash 

# vars
PHONE_IP="" #leave it blank if you use hotspot method
PHONE_PORT=2222 #default
PHONE_USER=
MOUNT_DIR=~/cloud

# funtions
cloud_status() {
    mountpoint -q "$MOUNT_DIR"
}

cloud_unmount() {
	fusermount -uz "$MOUNT_DIR" && { 
	    notify-send "Phone Cloud" "Unmounted"
        return 0 
	} || 
	{ 
        notify-send "Phone Cloud" "Unmount failed"
	    return 1
	}
}

cloud_mount() {
    # gathering phone ip
    PHONE_IP=$(ip route show default | awk '{print $3}')
	[ -z "$PHONE_IP" ] && { notify-send "Phone Cloud" "No hotspot detected"; return 1; }
    ! nc -z -w 1 "$PHONE_IP" "$PHONE_PORT" >/dev/null 2>&1 && { notify-send "Phone Cloud" "phone not reachable"; return 1; }

    # asking password
	PASSWORD=$(rofi -dmenu -password \
	 -theme ~/.config/rofi/password.rasi \
	 -p "Cloud Password")

    # connecting sshfs
	[ -z "$PASSWORD" ] && return 0
	printf '%s\n' "$PASSWORD" | sshfs \
	-o password_stdin \
	-o reconnect \
	-o StrictHostKeyChecking=no \
	-o UserKnownHostsFile=/dev/null \
	-o ServerAliveInterval=5 \
	-o ServerAliveCountMax=2 \
	-p "$PHONE_PORT" \
	"$PHONE_USER@$PHONE_IP":/ \
	"$MOUNT_DIR" && notify-send "Phone Cloud" "mounted" || notify-send "Phone Cloud" "mount failed"
	return 0
}

# for using from outside
case "$1" in
    -status)cloud_status && { echo  "phone cloud: mounted"; echo "mounted to $MOUNT_DIR";exit 0; }
            ! cloud_status && { echo "phone cloud: not mounted"; exit 1; };;
    -mount) cloud_mount;;
    -unmount) cloud_unmount;;
    -toggle) cloud_status && cloud_unmount || cloud_mount;;
     *) echo "cloud is an sftp server connecting script
uses:
   -status - check if the cloud is mounted
   -mount - mount the cloud
   -unmount - unmount the cloud
   -toggle - to toggle mount and unmount" 
esac
