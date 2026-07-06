# GDM login screen on the wrong monitor (GDM 50 / Fedora 44)

## Symptom

The login screen appears only on the TV (HDMI-1) instead of the primary
monitor (LG 27GL850 on DP-2) — and the TV isn't always on.

## Why the classic fix no longer works

GDM shows the greeter on whatever its *own* display configuration says is
primary; it never reads the user's `~/.config/monitors.xml`. Nearly every
guide says to copy that file to `/var/lib/gdm/.config/monitors.xml` — but
**since GNOME 49, GDM runs the greeter as a systemd dynamic user** (UID
~60578, not the `gdm` user; visible in the journal as `_UID=60578` and the
`/var/lib/gdm/.migrated-dyn-users` marker). The legacy path is silently
ignored.

## Fix (verified working on GDM 50.1)

Arrange displays and set the primary in GNOME Settings → Displays first
(this writes `~/.config/monitors.xml`), then:

```bash
sudo install -m 644 ~/.config/monitors.xml /var/lib/gdm/seat0/config/monitors.xml
sudo restorecon -v /var/lib/gdm/seat0/config/monitors.xml
```

The **`/var/lib/gdm/seat0/config/`** path alone was sufficient
(`/etc/xdg/monitors.xml` was not needed). Takes effect on the next GDM
start (reboot, or `sudo systemctl restart gdm` — which kills the session).

## Notes

- GDM owns that directory and reasserts ownership (`60578:nobody`,
  `drwx------`) itself — don't fight it; mode 644 on the file is enough.
- `restorecon` matters on Fedora: a wrong SELinux label silently blocks the
  greeter from reading the file.
- This is a snapshot, not a live link: after changing the display layout in
  GNOME Settings, re-run the copy.
- mutter matches the saved config by connected monitor set (connector +
  EDID), so layouts with and without the TV both work if both were saved.
