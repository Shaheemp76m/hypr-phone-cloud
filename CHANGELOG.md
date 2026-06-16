# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2025-06-16

### Added
- SSHFS phone storage mounting through a Hyprland keybind
- Rofi password prompt
- Waybar cloud status integration
- Desktop notifications
- SSH server reachability checks
- Automatic hotspot IP detection when PHONE_IP is empty
- Lazy SSHFS unmounting support

### Improved
- Faster mount/unmount logic by checking mount status first
- Better handling of disconnected phones and stale mounts

### Fixed
- Eliminated manual IP updates for hotspot users
