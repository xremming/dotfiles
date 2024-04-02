# Dotfiles

Repo that contains my dotfiles. In addition to installing these, I also need to remember to [install Visual Studio Code](https://code.visualstudio.com/download), and the [Fira Code font](https://github.com/tonsky/FiraCode/wiki/Installing). VS Code's data is synced with its GitHub integration.

## WSL Arch Pre-Setup

1. Download [WSL Arch](https://github.com/yuk7/ArchWSL) to `%USERPROFILE%\AppData\Local\Arch` and add the directory to the Windows path.
   - Install Arch by running `arch.exe` in PowerShell.
2. Update packages and install sudo.
   - `pacman-key --init`
   - `pacman-key --populate`
   - `pacman -Syu sudo`
3. Create a new user, add it to wheel group, and set a password for the user.
   - `useradd -m -G wheel maximilian`
   - `passwd maximilian`
4. Change default user to the created user.
   - In PowerShell `arch.exe config --default-user maximilian`.

## Install

1. Install `gh` (GitHub CLI) and run `gh auth login` to setup GitHub access with git.
2. Install `chezmoi` with your package manager.
   1. Arch: `pacman -S chezmoi`.
3. Run `chezmoi init --apply xremming`

## Other

Useful links:

- https://www.chezmoi.io/reference/
- http://masterminds.github.io/sprig/
- https://github.com/twpayne/dotfiles/tree/master/home
