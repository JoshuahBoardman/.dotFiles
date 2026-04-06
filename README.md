# My dotFiles
*dotFiles that I will be maintaining indefinitely.*

Ideally works on all OS' (mainly care about Arch and Arch WSL.) Everything is glued together with TOML and bash.

## Bootstrap

Install the prerequisites, then run the bootstrap script:

```bash
sudo pacman -S git go-yq
git clone git@github.com:JoshuahBoardman/dotFiles.git ~/.dotFiles
~/.dotFiles/system/bin/bootstrap.sh
```

Pass `--dry-run` to preview all actions without making changes:

```bash
~/.dotFiles/system/bin/bootstrap.sh --dry-run
```

Pass `--priority` to install only packages up to a given tier (`high` installs only high, `medium` installs high + medium, `low` installs everything):

```bash
~/.dotFiles/system/bin/bootstrap.sh --priority high
```

Pass `--platform` to override platform detection (`arch`, `wsl`, `mac`, `windows`):

```bash
~/.dotFiles/system/bin/bootstrap.sh --platform wsl
```

Flags can be combined:

```bash
~/.dotFiles/system/bin/bootstrap.sh --dry-run --priority high --platform wsl
```

## Repository Structure

```
dotfiles/
├── configs/          # Config files, symlinked to their destinations
├── system/
│   ├── spec/         # TOML specs — packages, managers, symlinks, settings
│   └── bin/          # Bootstrap scripts
├── scripts/
│   ├── lib/          # Shared bash utilities (logging, error handling)
│   ├── startup/      # Session startup scripts
│   ├── wayland/      # Wayland-native app wrappers
│   └── misc/         # Personal workflow scripts
└── agents/           # AI agent instruction files
```

### Spec files (`system/spec/`)

Everything is declarative. `bootstrap.sh` parses the TOML files using `go-yq` and drives installation and linking from them — no manual symlinking or package commands needed.

| File | Purpose |
|------|---------|
| `settings.toml` | Global defaults: shell, AUR helper, dotfiles root |
| `packages.toml` | Packages grouped by priority (high/medium/low) and platform |
| `package_managers.toml` | Manager definitions: pacman, yay, winget |
| `symlinks.toml` | Symlink mappings from `configs/` to their destinations |

## Local Overrides

Machine-specific shell config (e.g. work `PATH`, env vars, private aliases) can be placed in `~/.bashrc.local.d/`. Any `*.sh` files in that directory are automatically sourced at the end of `.bashrc` on startup. This directory is unversioned and not part of the repo.

