# NVIDIA display freezes (RTX 3070): BAR1 exhaustion bug, fixed with Resizable BAR

## Symptom

Display freezes completely mid-session while the rest of the system keeps
running (audio continues, no SSH loss). Only recovery is a hard power-off.
Happened 2026-07-05 twice, after ~50 min and ~7 h of uptime.

## Root cause

Known regression in the NVIDIA **open kernel modules 590/595** series
(this machine: nvidia-open 595.71.05 via RPM Fusion `akmod-nvidia`).
With Resizable BAR disabled in BIOS, the GPU's BAR1 aperture is only
**256 MiB**, and the driver's mapping-reuse code fragments/exhausts it over
time. Kernel log signature (from the frozen boot, via
`journalctl -b -1 -k | grep -iE 'NVRM|nvidia-drm'`):

```
NVRM: dmaAllocMapping_GM107: can't alloc VA space for mapping.
NVRM: ... Out of memory [NV_ERR_NO_MEMORY] ... mapping_reuse.c:273
nvidia-drm: Failed to map NvKmsKapiMemory / Failed to apply atomic modeset
NVRM: krcWatchdog_IMPL: RC watchdog: GPU is probably locked!
```

Compositor side shows `Page flip failed: drmModeAtomicCommit: Device or
resource busy`. Drivers ≤575 are unaffected; RPM Fusion only ships the
current branch. Tracked upstream: NVIDIA/open-gpu-kernel-modules issues
[#1132](https://github.com/NVIDIA/open-gpu-kernel-modules/issues/1132),
[#1134](https://github.com/NVIDIA/open-gpu-kernel-modules/issues/1134),
[#1140](https://github.com/NVIDIA/open-gpu-kernel-modules/issues/1140).

## Fix

Enable Resizable BAR so BAR1 covers the full 8 GiB of VRAM, removing the
exhaustion path entirely:

1. Updated the ASRock B450 Gaming-ITX/ac BIOS from P3.50 → P10.60
   (P3.50 predates ReBAR support on this board).
2. In BIOS: **Boot → CSM → Disabled** (system boots UEFI, so this is safe),
   then **Advanced → AMD PBS → Re-Size BAR Support → Enabled**.

Verification: `nvidia-smi -q -d MEMORY | grep -A3 BAR1` shows
`Total: 8192 MiB` (was 256 MiB). No freezes since.

Note: ReBAR with a Ryzen 3600 (Zen 2) on B450 is board-vendor territory —
officially AMD markets it for Ryzen 5000, but ASRock's firmware allows it
and it works here.

## Related notes

- **Which kernel module flavor is running:** `cat /proc/driver/nvidia/version`
  ("Open Kernel Module" vs closed). As of driver 595, RPM Fusion's
  `akmod-nvidia` builds the *open* module for Turing+ GPUs anyway, so the
  `akmod-nvidia` vs `akmod-nvidia-open` choice is moot — and `akmod-nvidia`
  must stay installed because `xorg-x11-drv-nvidia` requires its
  `nvidia-kmod` provide (`akmod-nvidia-open` does not satisfy it).
- **dnf removal cascades:** `dnf remove akmod-nvidia ...` once cascaded into
  removing all 77 NVIDIA packages. Use `dnf remove --noautoremove` and read
  the transaction preview before confirming.
- `nvidia-smi` lives in `xorg-x11-drv-nvidia-cuda` (despite the name, it's
  not CUDA-only).

## If freezes return

1. `journalctl -b -1 -k | grep -iE 'NVRM|nvidia-drm'` — same signature?
2. Check whether a fixed 595.x+ driver landed (upstream issues above).
3. Recovery without the power button: SSH in, or Ctrl+Alt+F3 →
   `sudo systemctl restart gdm`, or Magic SysRq REISUB
   (requires `kernel.sysrq=244` in `/etc/sysctl.d/`).
