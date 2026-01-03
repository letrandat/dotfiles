# OpenSkills Cheatsheet

> AI Skills for Windsurf & Other Agents

OpenSkills is a universal skills loader for AI coding agents. It replicates Anthropic's skills system for Claude Code but works with **Windsurf**, **Cursor**, **Aider**, and other AI agents.

📦 **GitHub**: [numman-ali/openskills](https://github.com/numman-ali/openskills)

---

## Installation

```bash
# Install OpenSkills CLI globally (requires Node.js 12+)
npm i -g openskills
```

---

## Quick Start Workflow

### Step 1: Install Anthropic's official skills

```bash
openskills install anthropics/skills
```

- Interactive: select desired skills like `pdf`, `xlsx`
- Installs to `./.claude/skills/` (project-level, gitignored)

### Step 2: Install obra/superpowers skills

```bash
openskills install obra/superpowers
```

- Interactive: select `testing`, `debugging`, `collaboration` skills
- Provides TDD, systematic debugging, structured planning

### Step 3: Sync installed skills to AGENTS.md

```bash
openskills sync
```

- Interactive: confirm which skills to include
- Adds `<available_skills>` XML block to AGENTS.md
- Requires pre-existing AGENTS.md file

---

## Core Commands

| Command                       | Description                                      |
| ----------------------------- | ------------------------------------------------ |
| `openskills install <source>` | Install from GitHub, local path, or private repo |
| `openskills sync`             | Update AGENTS.md with `<available_skills>` block |
| `openskills list`             | Show all installed skills                        |
| `openskills read <name>`      | Load/read a skill (used by agents)               |
| `openskills manage`           | Remove skills (interactive TUI)                  |
| `openskills remove <name>`    | Remove a specific skill                          |

---

## Installation Modes

### Default: Project-level (recommended)

```bash
openskills install anthropics/skills
# → Installs to ./.claude/skills (gitignored)
```

### Global: Shared across all projects

```bash
openskills install anthropics/skills --global
# → Installs to ~/.claude/skills
```

### Universal: For multi-agent setups

```bash
openskills install anthropics/skills --universal
# → Installs to ./.agent/skills/
```

---

## Flags

| Flag             | Description                                      |
| ---------------- | ------------------------------------------------ |
| `--global`       | Install to `~/.claude/skills` (shared)           |
| `--universal`    | Install to `.agent/skills/` (multi-agent)        |
| `-y`, `--yes`    | Skip prompts (for CI/scripts)                    |
| `-o`, `--output` | Custom output file for sync (default: AGENTS.md) |

---

## Sync Options

```bash
openskills sync                      # Sync to default AGENTS.md
openskills sync -o .ruler/AGENTS.md  # Sync to custom file
openskills sync -y                   # Non-interactive (CI/CD)
```

---

## Install From Other Sources

### Local paths

```bash
openskills install /path/to/my-skill
openskills install ./local-skills/my-skill
```

### Private GitHub repos (uses SSH keys)

```bash
openskills install git@github.com:your-org/private-skills.git
```

---

## Skill Packs Reference

### anthropics/skills

Official Anthropic marketplace skills:

- Specialized document processing (PDF, XLSX)
- Data analysis capabilities
- Content creation tools

### obra/superpowers

Developer workflow skills:

| Skill | Description |
|-------|-------------|
| `test-driven-development` | Write tests first |
| `systematic-debugging` | Four-phase debug framework |
| `brainstorming` | Refine ideas before coding |
| `verification-before-completion` | Evidence before assertions |
| `requesting-code-review` | Dispatch code reviewer subagent |
| `receiving-code-review` | Handle review feedback properly |
| `writing-plans` | Create detailed implementation plans |

---

## How Agents Use Skills

Once synced, agents invoke skills via:

```bash
openskills read <skill-name>
```

The skill content loads with:

- Detailed instructions for the task
- Base directory for bundled resources
- `References/`, `scripts/`, `assets/` locations

---

## Windsurf-Specific Notes

1. **AGENTS.md must exist** before running `openskills sync`
2. Skills are stored in `.claude/skills/` by default
3. For Windsurf + other agents, use `--universal` flag
4. The `<available_skills>` XML block is added to AGENTS.md
5. Windsurf's AI reads AGENTS.md to discover available skills

---

## Full Setup Example

```bash
cd /path/to/your/project

# Ensure AGENTS.md exists
touch AGENTS.md

# Install skill packs
openskills install anthropics/skills
openskills install obra/superpowers

# Sync to AGENTS.md
openskills sync

# Done! Windsurf will now see available skills in AGENTS.md
```
