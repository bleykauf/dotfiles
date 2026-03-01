# dotfiles

## Homebrew packages (macOS)

Use this workflow to keep installed packages tracked in this repo.

1. Edit the package list in [run_onchange_before_install-packages-darwin.sh.tmpl](run_onchange_before_install-packages-darwin.sh.tmpl).
2. Add or remove lines like `brew "<package>"` in the `brew bundle` block.
3. Apply your chezmoi config so the script runs and installs changes:

```shell
chezmoi apply
```

4. Verify packages are installed or removed:

```shell
brew list
```

5. Commit the template change so the repo stays the source of truth.

## Oh-my-posh

Start with a new theme:

```shell
oh-my-posh config export --config powerlevel10k_rainbow --format toml --output ~/.config/ohmyposh/powerlevel10k_rainbow.toml
```
