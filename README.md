# 🚀 Hypr Phone Cloud

Mount and unmount your Android phone over SSHFS with a single Hyprland keybind and a secure Rofi password prompt.

No terminal commands. No manual SSHFS mounting. Just press a key, enter your password, and your phone storage appears instantly.

---

## ✨ Features

### - 🔐 Password prompt using Rofi

### - 📂 Automatic SSHFS mounting

### - 🔄 Toggle mount / unmount with one keybind

### - 📶 Detects when the phone is unreachable

### - ⚠️ Handles wrong passwords gracefully

### - 💤 Uses lazy unmount to avoid stale mount issues

### - 🔔 Desktop notifications for all actions

---

## 📸 How It Works

Press your Hyprland keybind:
```
SUPER + P
```
If the phone is reachable:
```
┌─────────────────────┐
│ Cloud Password      │
│ ********            │
└─────────────────────┘
```
Enter your password and the phone is mounted to:
```
~/cloud
```
Press the keybind again to unmount.

---

## 📁 Project Files
```
hypr-phone-cloud/
├── phone-cloud.sh
├── password.rasi
└── README.md
```
---

## ⚙️ Configuration

Open the script:

```bash
micro ~/.config/hypr/scripts/cloud
```

Edit these variables at the top:

```bash
PHONE_IP=
PHONE_PORT=2222
PHONE_USER=
MOUNT_DIR=
```

### Variables

| Variable | Description |
|-----------|------------|
| PHONE_IP | IP address of your phone |
| PHONE_PORT | SSH server port on your phone |
| PHONE_USER | Username used to connect to the phone |
| MOUNT_DIR | Path of directry to be mounted to |

Example:

```bash
PHONE_IP="192.168.1.50"
PHONE_PORT=2222
PHONE_USER="myuser"
MOUNT_DIR=~/cloud
```

Save the file and make it executable:

```bash
chmod +x ~/.config/hypr/scripts/cloud
```
### > Note: Before using the script, verify connectivity:

```bash
nc -zv PHONE_IP PHONE_PORT
```

You should see:

```text
Connection succeeded
```
---

## 🖥️ Using Kitty Instead Of Rofi

The default version uses a Rofi password prompt:
```
PASSWORD=$(rofi -dmenu -password ...)
```
If you prefer Kitty:

Replace the password section with something like:
```
kitty sh -c 'read -s -p "Password: " PASSWORD'
```
or create a dedicated Kitty-based prompt script.

The rest of the mounting logic remains the same.

---

## ⌨️ Example Hyprland Keybind
```
bind = SUPER, P, exec, ~/.config/hypr/scripts/cloud.sh
```
---

## 📦 Requirements
```
sudo pacman -S \
    sshfs \
    rofi \
    openssh \
    libnotify \
    openbsd-netcat
```
---

## 🛠️ Troubleshooting

Phone Not Reachable

Verify:
```
ping PHONE_IP
```
and:
```
nc -z PHONE_IP 2222
```
---

#### Mount Failed

Possible causes:

- Wrong password
- SSH server not running
- Incorrect IP address
- Incorrect username
- Incorrect port

---

Stale Mount

If a mount gets stuck:
```
fusermount -uz ~/cloud
```
---

## 🎯 Why I Built This

I wanted a fast way to access my Android files from Hyprland without manually typing SSHFS commands every time.

This project turns the entire process into a single keybind while handling common failure cases automatically.

---

### License

MIT

Feel free to modify, improve, and adapt it to your setup.
