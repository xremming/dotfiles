# ZSA Moonlander on Fedora: udev rules for Oryx and Keymapp

ZSA's official udev rules (from the Oryx/Keymapp Linux setup guide) grant device
access via `GROUP="plugdev"`. The `plugdev` group is a Debian/Ubuntu convention
and **does not exist on Fedora** — udev can't resolve the group, the hidraw
device nodes stay `root:root`, and Oryx live training / web flashing silently
fail with no device access.

The Fedora-idiomatic fix is `TAG+="uaccess"`: systemd-logind then grants an ACL
on the device to whoever is logged in at the physical seat. No group management,
no world-writable `0666` nodes.

## Setup

This is a system file, so it is not managed by chezmoi — apply it manually on a
new machine:

```bash
sudo tee /etc/udev/rules.d/50-zsa.rules >/dev/null <<'EOF'
# Oryx web flashing and live training (hidraw access for the active local user)
KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", TAG+="uaccess"
KERNEL=="hidraw*", ATTRS{idVendor}=="3297", TAG+="uaccess"

# Keymapp/Wally flashing: Moonlander & Planck EZ enter STM32 DFU mode
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", TAG+="uaccess", SYMLINK+="stm32_dfu"
# Keymapp flashing: Voyager
SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", TAG+="uaccess", SYMLINK+="ignition_dfu"
EOF
sudo udevadm control --reload-rules
sudo udevadm trigger
```

Unplug and replug the keyboard afterwards.

## Verification

- `lsusb | grep -i zsa` — keyboard is detected (`3297:1969 ZSA Technology Labs
  Moonlander Mark I`).
- `ls -l /dev/hidraw*` — the keyboard's nodes show a `+` (ACL) suffix.
- `getfacl /dev/hidrawN` — lists your user with `rw` access.

## Notes

- Oryx live training / web flashing needs a Chromium-based browser (WebUSB and
  WebHID; Firefox does not support them). Keymapp works regardless.
- The rules file must sort before `73-seat-late.rules` for `uaccess` to take
  effect — the `50-` prefix is fine.
- Alternative that keeps ZSA's stock rules byte-identical: create the group
  (`sudo groupadd plugdev && sudo usermod -aG plugdev $USER`) and re-login.
  The `uaccess` approach above is preferred on Fedora.
- Layout lives at <https://configure.zsa.io/moonlander/layouts/EYB6Q/latest/0>.
