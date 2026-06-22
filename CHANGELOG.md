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

## [1.2.0] - 2025-06-22

### Added
- Automatic hotspot gateway IP discovery 
- SSh hotkey verification bypass for dynamic hotspot IPs
- automatic cloud mount status detection
- improved SSHFS reconnector behavior

### Improved
- refactored mount/unmount logic into dedicated funtions 
- redused manual configurations required
- cleaner notification handling
- better support for changing phone IP adresses
- more reliable cloud toggle funtionality 

### Fixed
- fixed cloud mounting failures after hotspot changes
- fixed stable SSH known_hosts issue with dynamic Ips 
- fixed broken mountstate detection 
- fixed JSON output issue affecting waybar cloud status
- fixed unjmount behavior for disconected SSHFS mounts
