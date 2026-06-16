# 🚀 Hypr Phone Cloud

Mount and unmount your Android phone storage over SSHFS with a single Hyprland keybind and a secure Rofi password prompt.

No terminal commands. No manual SSHFS mounting. Just press a key, enter your password, and your phone storage appears instantly.

---

# ✨ Features

### - 🔐 Password prompt using Rofi

### - 📂 Automatic SSHFS mounting

### - 📡 Automatic hotspot IP detection

### - 🔄 Toggle mount / unmount with one keybind

### - 📶 Detects when the phone is unreachable

### - ⚠️ Handles wrong passwords gracefully

### - 🚦 Verifies SSH availability before prompting for a password

### - 💤 Uses lazy unmount to avoid stale mount issues

### - 🔔 Desktop notifications for all actions

### - ☁️ Waybar cloud status indicator

---

## 📸 How It Works

Press your Hyprland keybind:
```
SUPER + P
```
If the phone is reachable:
```
┌─────────────────────┐
│ Cloud Password          │
│ ********                │
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
├── cloud-status.sh
├── CHANGELOG.md
└── README.md
```
---

## Installation

Clone the repository:

```bash
git clone https://github.com/Shaheemp76m/hypr-phone-cloud.git
cd hypr-phone-cloud
```

Create required directories:

```bash
mkdir -p ~/.config/hypr/scripts
mkdir -p ~/.config/rofi
```

Copy files:

```bash
cp phone-cloud.sh ~/.config/hypr/scripts/cloud
cp password.rasi ~/.config/rofi/password.rasi
```

Make the script executable:

```bash
chmod +x ~/.config/hypr/scripts/cloud
```
---

## ⚙️ Configuration

Open the script:

```bash
micro ~/.config/hypr/scripts/cloud
```

Edit these variables at the top:

```bash
PHONE_IP="" 
PHONE_PORT=2222
PHONE_USER=
MOUNT_DIR=
```
---

### Variables

| Variable | Description |
|-----------|------------|
| PHONE_IP | leave empty to automatically detect the phone hotspot IP,or specify a fixed IP adress  |
| PHONE_PORT | SSH server port on your phone |
| PHONE_USER | Username used to connect to the phone |
| MOUNT_DIR | Path of directry to be mounted to |

Example:

```bash
PHONE_IP="" #for hotspot mode
PHONE_PORT=2222 #default
PHONE_USER="myuser"
MOUNT_DIR=~/cloud
```

Save the file and make it executable:

```bash
chmod +x ~/.config/hypr/scripts/cloud
```
---
## Hotspot Mode

if you use your phone's hotspot,leave "PHONE_IP" empty

```bash 
PHONE_IP=""
```

The script will automatically detect the hotspot gateway adress.
No manual IP updates are required when the hotspot restarts 

---
## Hyprland Keybind

Add to your Hyprland configuration:

```ini
bind = SUPER, P, exec, ~/.config/hypr/scripts/cloud
```

Reload Hyprland:

```bash
hyprctl reload
```
---
## Waybar Integration

Add this module to your Waybar config:

```json
	"custom/cloud-status": {
		"exec": "~/.config/waybar/scripts/cloud-status",
		"interval": 1,
		"return-type": "json",
		"format": "{}",
		"on-click": "kitty --directory ~/cloud sh -c 'eza --icons --group-directories-first ; exec $SHELL'"
	},

```

Place `cloud-status.sh` in:

```text
~/.config/waybar/scripts/
```
---
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

```bash
PASSWORD=$(rofi -dmenu -password \
    -theme ~/.config/rofi/password.rasi \
    -p "Cloud Password")
```

If you prefer Kitty, replace the Rofi password prompt with your preferred terminal-based password input method.

The rest of the mounting logic remains unchanged.
---

## 📦 Requirements
```
sudo pacman -S \
    sshfs \
    rofi \
    openssh \
    libnotify \
    openbsd-netcat \
    eza
```
---

## 🛠️ Troubleshooting

### Phone Not Reachable

Verify:
```
ping PHONE_IP
```
and:
```
nc -z PHONE_IP 2222
```

### No Hotspot Detected 

if using hotspot mode 

```bash
PHONE_IP=""
```

verify that your phone hotspot is enabled and your computer is connected to it

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
