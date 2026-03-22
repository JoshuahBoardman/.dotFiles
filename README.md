# My dotFiles
*My final dotFiles that I wll be maintaining indefinitely.

## Bootstrap

Install the prerequisites, then run the bootstrap script:

```bash
sudo pacman -S git yq
git clone git@github.com:JoshuahBoardman/new_dotFIles.git ~/.dotFiles
~/.dotFiles/system/bin/bootstrap.sh
```

Pass `--dry-run` to preview all actions without making changes:

```bash
~/.dotFiles/system/bin/bootstrap.sh --dry-run
```

Pass `--priority` to install only packages of a given tier:

```bash
~/.dotFiles/system/bin/bootstrap.sh --priority high
```

## Agents Folder
*The agents folder contains AI agent specific files that I want to use across all my machines*


The `baseline.md` file is the equivilant of AGENTS.md and I link to it at the top of an AGENTS.md or other variations like CLAUDE.md. 
    - **Only update this file if I notice a specific behavior that I want to add guidance/correction for.**

The `personas/` folder is conains roles that an agent can take on. I would inject these at the start of an agentic session.

The `skills/` folder contains the skills that I consistently give agents when working on various tasks.

### Skills:
**When updating agent skills please reference the [Agent Spec](https://agentskills.io/home)


