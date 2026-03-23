# My dotFiles
*My final dotFiles that I wll be maintaining indefinitely.*

## Bootstrap

Install the prerequisites, then run the bootstrap script:

```bash
sudo pacman -S git go-yq
git clone git@github.com:JoshuahBoardman/new_dotFIles.git ~/.dotFiles
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

## Repository Structure

```
dotfiles/
├── configs/      # Config files, symlinked to their destinations
├── system/
│   ├── spec/     # TOML specs — packages, managers, symlinks, settings
│   └── bin/      # Bootstrap scripts
├── scripts/
│   ├── lib/      # Shared bash utilities (logging, error handling)
│   └── misc/     # Personal workflow scripts
└── agents/       # AI agent instruction files
```

## Agents

The `agents/` folder contains AI agent instruction files used across all machines.

`baseline.md` is the equivalent of `AGENTS.md` — referenced at the top of any `CLAUDE.md` or similar file. Only update it when a specific behavior needs guidance or correction.
