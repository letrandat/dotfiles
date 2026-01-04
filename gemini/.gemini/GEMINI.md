# Global Rules

## Core Mandates

- Use **Beads** for task management (`bd`).
- Use **OpenSpec** for understand the user intent and provide proposal (`openspec-proposal`).
- Always brainstorm with `/dat-brainstorm` before coding complex features.

<!-- BEADS:START -->
## Issue Tracking

This project uses **bd (beads)** for issue tracking.
Run `bd prime` for workflow context, or install hooks (`bd hooks install`) for auto-injection.

**Quick reference:**

- `bd ready` - Find unblocked work
- `bd create "Title" --type task --priority 2 --description="Why this issue exists and what needs to be done"` - Create issue
- `bd close <id>` - Complete work
- `bd sync` - Sync with git (run at session end)

For full workflow details: `bd prime`
<!-- BEADS:END -->

<!-- OPENSPEC:START -->
## OpenSpec Instructions

These instructions are for AI assistants working in this project.

Always open `@/openspec/AGENTS.md` when the request:

- Mentions planning or proposals (words like proposal, spec, change, plan)
- Introduces new capabilities, breaking changes, architecture shifts, or big performance/security work
- Sounds ambiguous and you need the authoritative spec before coding

Use `@/openspec/AGENTS.md` to learn:

- How to create and apply change proposals
- Spec format and conventions
- Project structure and guidelines

Keep this managed block so 'openspec update' can refresh the instructions.

<!-- OPENSPEC:END -->

## Land the Plane Workflow

**Trigger:** "land the plane"

**Instructions:**
This is the standard cleanup and finalization routine. When invoked, you MUST:

1. **Commit & Lint:**
    - Stage all changes: `git add .`
    - Run pre-commit ONLY on staged files: `pre-commit run --files $(git diff --cached --name-only)`
    - If pre-commit fixes files (auto-fix), re-stage them (`git add .`) and run again.
    - If manual fixes are needed, perform them.
    - Commit with a descriptive conventional commit message.

2. **Close Administrative Tasks:**
    - **OpenSpec:** Check `openspec list`. If a change proposal is active and implemented, archive it (`openspec archive <id> --yes`).
    - **Beads Health:** Run `bd doctor`. If issues found, run `bd doctor --fix`.
    - **Beads Close:** Check `bd list`. Close any open tasks/epics that were completed in this session (`bd close <id>`).
    - **Beads Sync:** Run `bd sync` to ensure local state matches git.

3. **Report:**
    - Provide a concise summary of the actions taken (commits, files, tickets closed).

**Example:**

**User:** "land the plane"

**Agent:**

- (Runs `git add .`)
- (Runs `pre-commit ...`) -> *Fixes trailing whitespace*
- (Runs `git commit -m "feat: optimize database queries"`)
- (Runs `openspec archive optimize-queries --yes`)
- (Runs `bd doctor --fix`)
- (Runs `bd close df-101`)
- (Runs `bd sync`)
- **Summary:** "Landed the plane. Committed 'feat: optimize database queries', passed all linters, archived 'optimize-queries' spec, verified beads health, closed task df-101, and synced beads."
