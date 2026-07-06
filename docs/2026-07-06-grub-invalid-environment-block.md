# GRUB boot error: "invalid environment block"

## Symptom

A brief `error: invalid environment block` flashes on screen at every boot,
just before the GRUB menu. Boot then proceeds normally.

## Diagnosis

GRUB stores variables (`saved_entry`, `boot_success`, …) in
`/boot/grub2/grubenv` — a file that must be exactly 1024 bytes. That file
was **valid** here (correct size, `sudo grub2-editenv - list` parsed fine).

The actual culprit was a stray variable *inside* it: `env_block=512+1`.
This is part of a Fedora mechanism for installs where `/boot` is on a
filesystem GRUB can't write (Btrfs): grub.cfg then reads/writes the
environment from a raw *blocklist* instead of the file:

```
if [ "${env_block}" ] ; then
  set env_block="(${dev})${env_block}"
  load_env -f "${env_block}"     # reads raw sector 512 of the /boot partition
```

On this machine `/boot` is **ext4** (only the root fs is Btrfs), so the
variable should never have been set — it's an installer artifact. GRUB read
sector 512 of the ext4 partition, found garbage, and printed the error every
boot. Worse, all `save_env` calls also targeted that bogus blocklist (GRUB
refused the writes because validation failed, so boot-success/fallback
tracking silently did nothing).

## Fix

```bash
sudo grub2-editenv - unset env_block
```

That's all. Every `load_env`/`save_env` in grub.cfg falls back to the normal
file path, which works natively on ext4. Verified: error gone on next boot.

## Safety notes (if this ever needs to be revisited)

- grubenv problems are never boot-blocking: even a deleted/corrupt grubenv
  just makes GRUB boot the first (newest) BLS entry with a cosmetic error.
- Exact rollback: `sudo grub2-editenv - set env_block=512+1`.
- Do **not** unset `env_block` on a machine where `/boot` itself is Btrfs —
  there the blocklist mechanism is the intended design.
- The two-line header in grubenv (including the `# WARNING: Do not edit...`
  line) is standard output of `grub2-editenv create`, not corruption.
