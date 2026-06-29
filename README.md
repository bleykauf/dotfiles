# dotfiles

## Setup

### Linux

Install chezmoi and apply this repo in one step:

```shell
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply bleykauf/dotfiles
```

### Windows

Install chezmoi via winget, then apply this repo:

```powershell
winget install twpayne.chezmoi
chezmoi init --apply bleykauf/dotfiles
```

Or use the one-liner with PowerShell:

```powershell
(irm -UseBasicParsing https://get.chezmoi.io/ps1) | powershell -c -
chezmoi init --apply bleykauf/dotfiles
```

### Source directory

The chezmoi source directory (this repo) is located at:

| Platform | Path |
|----------|------|
| macOS / Linux | `~/.local/share/chezmoi` |
| Windows | `%USERPROFILE%\.local\share\chezmoi` |

---

## Post-install steps

### Nerd Font (all platforms)

The oh-my-posh theme uses Powerline glyphs that require a [Nerd Font](https://www.nerdfonts.com). Install one and configure your terminal to use it.

**Linux:** Download and install the font on the machine running your terminal emulator (i.e. the machine whose display you're using), then refresh the font cache and set it in your terminal emulator's preferences:

```shell
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip FiraCode.zip -d FiraCode
rm FiraCode.zip
fc-cache -fv
```

**Linux (WSL):** The terminal emulator is Windows Terminal, so install the font on Windows instead. Download a Nerd Font from [nerdfonts.com](https://www.nerdfonts.com/font-downloads), install it on Windows, then set it in Windows Terminal: Settings → your profile → Appearance → Font face.

**macOS:** Install via Homebrew and set it in your terminal's font preferences:

```shell
brew install --cask font-fira-code-nerd-font
```

**Windows:** Install via winget and set it in Windows Terminal: Settings → your profile → Appearance → Font face:

```powershell
winget install DEVCOM.JetBrainsMonoNerdFont
```

### New shell session (Linux only)

`chezmoi apply` runs `chsh` to set zsh as the default shell. The change takes effect on the next login — open a new terminal window after the apply finishes.

---

## Homebrew packages (macOS)

Use this workflow to keep installed packages tracked in this repo.

1. Update your system `~/.Brewfile` (source of truth):

```shell
brew bundle dump --file="${HOMEBREW_BUNDLE_FILE:-$HOME/.Brewfile}" --force
```

2. Add the system `~/.Brewfile` to chezmoi, so the repo tracks it:

```shell
chezmoi add "${HOMEBREW_BUNDLE_FILE:-$HOME/.Brewfile}"
```

3. Apply the chezmoi config so the bundle script runs:

```shell
chezmoi apply
```

4. Verify packages are installed or removed:

```shell
brew list
```

5. Commit the updated [`dot_Brewfile`](dot_Brewfile), so the repo tracks the system source of truth.

## Rustup (macOS)

If Homebrew warns that `rustup` is keg-only, this repo already prepends `/opt/homebrew/opt/rustup/bin` in `dot_zprofile`.

After installing `rustup`, run this once to initialize the default toolchain:

```shell
rustup default stable
```

## Docker (WSL)

Docker Desktop on Windows can expose the Docker daemon to WSL distros. To enable it:

1. Open Docker Desktop → **Settings** → **Resources** → **WSL integration**
2. Enable **"Enable integration with my default WSL distro"** and/or toggle on your specific distro (e.g. Ubuntu)
3. Click **Apply & Restart**

After this, `docker` commands work inside WSL without installing a separate Docker daemon.

## Oh-my-posh

Start with a new theme:

```shell
oh-my-posh config export --config powerlevel10k_rainbow --format toml --output ~/.config/ohmyposh/powerlevel10k_rainbow.toml
```

The shared theme in this repo is [`dot_config/ohmyposh/theme.toml`](dot_config/ohmyposh/theme.toml).

- macOS uses it from `dot_zshrc` with zsh init.
- Windows uses it from `Documents/PowerShell/Microsoft.PowerShell_profile.ps1` with pwsh init.

### Oh-my-posh (Windows)

Uses **PowerShell 7 (pwsh)** only. Canonical installation is managed via chezmoi using winget.

1. Apply your chezmoi config:

```powershell
chezmoi apply
```

This runs [`run_onchange_before_install-packages-windows.ps1.tmpl`](run_onchange_before_install-packages-windows.ps1.tmpl), which installs `JanDeDobbeleer.OhMyPosh` via winget if missing.

2. **Important:** Configure Windows Terminal to launch PowerShell 7 by default:
   - Open Windows Terminal settings (Ctrl+,)
   - In the JSON settings, ensure your default profile points to PowerShell 7:
   ```json
   "defaultProfile": "{574e775e-4f2a-5b96-ac1e-a2962a402336}"
   ```
   - Or select "PowerShell" (not "Windows PowerShell") from the dropdown and set as default.

3. Open a new PowerShell 7 session (or reload profile):

```powershell
. $PROFILE
```

4. Verify:

```powershell
oh-my-posh --version
$PSVersionTable.PSVersion
winget list --id JanDeDobbeleer.OhMyPosh --exact --source winget
```
