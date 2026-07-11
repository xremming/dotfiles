#!/bin/bash

set -euo pipefail

# Full ffmpeg from RPM Fusion; Fedora's ffmpeg-free lacks the H.264/H.265 decoders
if ! rpm -q ffmpeg &>/dev/null; then
  if rpm -q ffmpeg-free &>/dev/null; then
    sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
  else
    sudo dnf install -y ffmpeg
  fi
fi

# VA-API driver with H.264/HEVC hardware decoding; Fedora's mesa build strips them
if ! rpm -q mesa-va-drivers-freeworld &>/dev/null; then
  sudo dnf install -y --allowerasing mesa-va-drivers-freeworld
fi
