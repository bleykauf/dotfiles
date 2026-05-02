# Repository Context

This is a [chezmoi](https://www.chezmoi.io/) dotfiles repository for managing personal configuration files across macOS and Windows machines.

## What chezmoi does

chezmoi manages dotfiles by tracking them in a source directory (`~/.local/share/chezmoi`) and applying them to their target locations in `$HOME`. Files are prefixed according to chezmoi conventions (e.g. `dot_` becomes `.`, `private_` sets restricted permissions, `run_onchange_before_` runs scripts when their content changes).

## Repository structure

- `dot_zshrc`, `dot_zshenv`, `dot_zprofile` — Zsh shell configuration (macOS)
- `dot_Brewfile` — Homebrew bundle file listing all managed macOS packages
- `dot_config/` — XDG config files:
  - `karabiner/` — Karabiner-Elements key remapping (macOS)
  - `kitty/` — Kitty terminal emulator config
  - `lla/` — `lla` (ls alternative) config
  - `ohmyposh/` — Oh My Posh prompt theme (shared between macOS and Windows)
- `Documents/PowerShell/` — PowerShell profile (Windows)
- `AppData/` — Windows application config (PowerToys)
- `run_onchange_before_install-packages-darwin.sh.tmpl` — Script that installs Homebrew packages on macOS via `brew bundle`
- `run_onchange_before_install-packages-windows.ps1.tmpl` — Script that installs packages on Windows via `winget`

## Key conventions

- **Cross-platform prompt**: Oh My Posh is used on both macOS (zsh) and Windows (PowerShell 7). The shared theme lives at `dot_config/ohmyposh/theme.toml`.
- **Package management**: macOS uses Homebrew (`dot_Brewfile`); Windows uses winget. Both are driven by chezmoi `run_onchange_before_` scripts.
- **Shell (macOS)**: zsh with [Zinit](https://github.com/zdharma-continuum/zinit) as plugin manager.
- **Private files**: Files prefixed `private_` in the source are excluded from the repo via `.gitignore` (e.g. `private_Library/` for macOS app support files).
- **Rust**: `dot_zshenv` sources `~/.cargo/env`; rustup is managed via Homebrew (keg-only).

## Workflow

To update tracked packages on macOS:
1. `brew bundle dump --file="$HOME/.Brewfile" --force` — regenerate Brewfile from installed state
2. `chezmoi add "$HOME/.Brewfile"` — sync to source
3. `chezmoi apply` — apply and run install scripts
