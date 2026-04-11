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

## Notes CLI

A terminal-first note-taking workflow for the `~/life_management/` vault. Scripts live in `scripts/notes/` and run directly from the dotFiles directory via PATH.

```
scripts/notes/
  notes              # top-level CLI entrypoint
  notes-new          # create a note from a template
  notes-update       # bulk frontmatter update
  notes-schedule     # scheduled note generation
  notes-search       # full-text search via rg + fzf
  notes-priority     # open all notes matching a priority level
  tokens.sh          # shared token substitution library (sourced only)
```

### Usage

```bash
notes new [--dry-run] <type> [title]          # create a note (prompts for title if omitted)
notes search <query>                          # full-text search, opens result in $EDITOR
notes priority <p1|p2|p3|p4>                 # open all non-archived notes at a priority level
notes update --where '<yq expr>' --set '<yq expr>'   # bulk frontmatter mutation (always previews diff)
notes schedule run [--dry-run]               # generate any scheduled notes due today
```

`--dry-run` is supported on `notes new` and `notes schedule run` — prints what would be created without touching the filesystem. `notes update` is safe by default as it always shows a diff and prompts before applying.

### Scheduled Notes

Reads `~/life_management/schedule.toml` and generates notes that don't already exist. Runs automatically via a systemd user timer at 6am daily (`configs/systemd-user/notes-schedule.timer`).

### Neovim Integration

| Keymap | Action |
|--------|--------|
| `<leader>nn` | Create a new note (prompts for type and title) |
| `<leader>ns` | Search the vault |

### Dependencies

`rg`, `fzf`, `bat`, `yq` (v4 mikefarah/yq), `uuidgen`

## Local Overrides

Machine-specific shell config (e.g. work `PATH`, env vars, private aliases) can be placed in `~/.bashrc.local.d/`. Any `*.sh` files in that directory are automatically sourced at the end of `.bashrc` on startup. This directory is unversioned and not part of the repo.

