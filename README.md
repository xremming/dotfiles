# Dotfiles

Repo that contains my dotfiles. In addition to installing these, I also need to remember to [install Visual Studio Code](https://code.visualstudio.com/download), and the [Fira Code font](https://github.com/tonsky/FiraCode/wiki/Installing). VS Code's data is synced with its GitHub integration.

## Install

1. Install `gh` (GitHub CLI) and run `gh auth login` to setup GitHub access with git.
2. Install `chezmoi` with your package manager.
   1. Arch: `pacman -S chezmoi`.
   2. maxOS: `brew install chezmoi`.
3. Run `chezmoi init --apply xremming`

### macOS

On macOS [install homebrew](https://brew.sh/) first, on first apply the correct shell will be installed and made default (as will be other needed changes).

Remember to also install [`code` to PATH](https://code.visualstudio.com/docs/setup/mac).

## Other

Useful links:

- https://www.chezmoi.io/reference/
- http://masterminds.github.io/sprig/
- https://github.com/twpayne/dotfiles/tree/master/home
