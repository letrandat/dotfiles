# Antigravity Skills Sync System Design

**Date**: 2025-12-27
**Status**: Planned
**Author**: Agent (Collaborating with User)

## Problem Statement

Antigravity agents (Gemini/Claude) need access to the "Superpowers" skill library to perform high-quality engineering tasks. However, simply having the skills available isn't enough; agents need:

1. **Reliable Invocation**: A standard way to trigger skills (slash commands).
2. **Context**: Instructions on _how_ to use the system (e.g., "Use `/superpower-brainstorming` before coding").
3. **Parity**: The same skills available in Windsurf must be available in Antigravity, sourced from the `openskills` repository.

Currently, there is no automated sync for Antigravity, leading to drift and manual copying.

## Solution Overview

Implement a synchronization pipeline that pulls from `openskills` and generates native Antigravity workflows, complete with user-defined context files to guide agent behavior.

**Flow**:

```
openskills (Source of Truth)
   ↓
openskills-to-antigravity (Bash Script)
   ↓
~/.agent/workflows/ (Destination)
   ├── superpower-brainstorming.md
   ├── ...
   ├── agent.md (Context Map)
   └── claude.md (Claude Usage Rules)
```

## Architecture

### Components

1. **Unified Sync Script**: `bin/.local/dotfiles-bin/superpowers-sync`

    - Language: **Node.js**.
    - Architecture: **Plugin-Based Runner**.
    - **Dispatcher**: simple CLI args (`--target=windsurf|antigravity`).
    - **Plugins**:
      - `AntigravityPlugin`: Syncs to `~/.agent/workflows`, injects `agent.md`.
      - `WindsurfPlugin`: Syncs to `.codeium/...`, injects state markers.

2. **Context Source**: `docs/agent-context/superpowers/`

    - `antigravity/`: Context files for Antigravity (`agent.md`, `claude.md`).
    - _Rationale_: Centralized documentation for agent behavior.

3. **Core Skills**:
    - Both environments sync only the `CORE_SKILLS` list to ensure parity and reduce noise.

### Flow

```text
               +-----------------------+
               |     OpenSkills Repo   |
               |     ~/.agent/skills   |
               +-----------+-----------+
                           | 1. openskills sync
                           v
          +----------------------------------+
          |         superpowers-sync         |
          |           (Runner)               |
          |          [Dispatcher]            |
          +-------+-------+--------+---------+
                  |                |
  --target=windsurf               --target=antigravity
                  v                v
      +-------------------+    +----------------------+
      |  Windsurf Plugin  |    |  Antigravity Plugin  |
      +-------------------+    +----------------------+
               |                          |
               v                          v
 +-----------------------------+  +---------------------------+
 | Windsurf Global Workflows   |  |   Antigravity Workflows   |
 +-----------------------------+  +---------------------------+
```

### Verification

The script includes an automated verification phase:

- Checks existence of all synced workflows.
- Verifies content integrity (state markers, headers).
- Verifies context files (agent.md).

## Maintenance

- **Docs**: `docs/antigravity-workflows-sync.md` is the Single Source of Truth for usage.
- **Context**: Edit `docs/antigravity-context/agent.md` to change global agent behavior.
