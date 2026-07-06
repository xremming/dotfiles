# GNOME extensions all disabled after a session crash

## Symptom

A freshly installed extension (Tiling Shell) worked for one session, then
appeared permanently disabled on every following boot. `gnome-extensions
list --details` showed every extension `Enabled: No, State: INITIALIZED`
even though the extension UUID was present in
`org.gnome.shell enabled-extensions`.

## Root cause

```bash
gsettings get org.gnome.shell disable-user-extensions   # was: true
```

`disable-user-extensions` is GNOME's master kill-switch and overrides the
enabled list entirely. GNOME Shell sets it **deliberately as a crash
fail-safe**: if the shell dies uncleanly while extensions are active, it
assumes an extension might be responsible and switches them all off so the
next login is guaranteed to work.

Here the trigger wasn't the extension at all — it was the NVIDIA BAR1 GPU
freeze (see `2026-07-06-nvidia-freeze-rebar.md`) killing the session, followed by a
hard power-off. GNOME can't distinguish a GPU-driver death from an
extension-induced one.

## Fix

```bash
gsettings set org.gnome.shell disable-user-extensions false
```

Takes effect immediately (no logout), persists across reboots. Same as the
master toggle at the top of the Extensions app.

## How extension state fits together (reference)

- Files: user installs in `~/.local/share/gnome-shell/extensions/<uuid>/`,
  distro packages in `/usr/share/gnome-shell/extensions/`.
- State: just dconf — `org.gnome.shell enabled-extensions` (UUID list) plus
  the `disable-user-extensions` master switch.
- Tools: `gnome-extensions list/info/enable/disable`, the Extensions app,
  extensions.gnome.org browser integration.
- If extensions "don't stick" again: check the master switch first, then
  version validation (after GNOME upgrades), then
  `journalctl --user -b | grep -i <uuid>` for load errors — and check what
  actually crashed the shell before blaming the extension.
