# Dotfiles

Repo that contains my dotfiles. In addition to installing these, I also need to remember to [install Visual Studio Code](https://code.visualstudio.com/download), and the [Fira Code font](https://github.com/tonsky/FiraCode/wiki/Installing). VS Code's data is synced with its GitHub integration.

## Fedora Pre-Setup

Nothing special is needed; everything required (`sudo`, `dnf`, `curl`) is available out of the box.
The install scripts enable the `atim/starship` and `atim/lazygit` COPR repos for packages missing from the official repos.

## macOS Pre-Setup

1. Install macOS CLI Developer Tools, e.g. by typing `git` and then following the instructions.
2. Install [homebrew](https://brew.sh/) following their instructions.

## Install

1. Install `gh` (GitHub CLI) and run `gh auth login` to setup GitHub access with git.
2. Install `chezmoi` with your package manager.
   1. Fedora: `sudo dnf install chezmoi`.
   2. macOS: `brew install chezmoi`.
3. Run `chezmoi init --apply xremming`

## Other

Useful links:

- https://www.chezmoi.io/reference/
- http://masterminds.github.io/sprig/
- https://github.com/twpayne/dotfiles/tree/master/home
