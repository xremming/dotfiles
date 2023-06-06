#!/bin/bash

set -euo pipefail

pacman-key --init
pacman-key --populate archlinux
