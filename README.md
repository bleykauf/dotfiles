# dotfiles

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

## Oh-my-posh

Start with a new theme:

```shell
oh-my-posh config export --config powerlevel10k_rainbow --format toml --output ~/.config/ohmyposh/powerlevel10k_rainbow.toml
```
