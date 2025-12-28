# Syncing Agent Workflows (Superpowers)

This document is the **Single Source of Truth** for maintaining parity between the central skills repository and agent environments (Windsurf & Antigravity).

## Overview

All "Superpowers" (advanced engineering workflows) originate from a single source: the `openskills` repository (mapped to `~/.agent/skills`). To ensure all agents have access to these skills, we use automated sync scripts to generate native workflow files for each environment.

## Architecture

| Feature        | Source (Truth)           | Windsurf (Destination)                | Antigravity (Destination)   |
| :------------- | :----------------------- | :------------------------------------ | :-------------------------- |
| **Location**   | `~/.agent/skills/`       | `.codeium/windsurf/global_workflows/` | `~/.agent/workflows/`       |
| **Invocation** | `openskills read <name>` | `@workflow <name>`                    | `/superpower-<name>`        |
| **Sync Tool**  | `openskills` CLI         | `superpowers-sync`                    | `openskills-to-antigravity` |
| **Format**     | Markdown + Frontmatter   | Markdown (Auto-Execution Off)         | Markdown (Raw + Headers)    |
| **Context**    | N/A                      | State Markers (Injected)              | Context Files (`agent.md`)  |

## Sync Instructions

### Unified Sync Command

Run the single unified script to sync to all targets (Antigravity & Windsurf):

```bash
superpowers-sync sync
```

### Targeted Sync

You can also sync to specific targets using the `--target` flag:

```bash
# Sync only to Antigravity (Gemini/Claude)
superpowers-sync sync --target=antigravity

# Sync only to Windsurf
superpowers-sync sync --target=windsurf
```

**What it does:**

1.  Runs `openskills sync` (updates source).
2.  Parses SKILL.md files.
3.  **Antigravity Plugin**:
    - Generates `/superpower-<name>.md` in `~/.agent/workflows/`.
    - Injects context files (`agent.md`, `claude.md`) from `docs/agent-context/superpowers/antigravity/`.
4.  **Windsurf Plugin**:
    - Generates `superpowers-<name>.md` in `.codeium/windsurf/global_workflows/`.
    - Injects state persistence markers.
5.  **Verification**: Automatically verifies file existence and content integrity.

## Maintenance

### Context Files (Antigravity)

- **Location**: `docs/agent-context/superpowers/antigravity/`
- **Purpose**: Instructions that tell Antigravity agents (Claude/Gemini) how to interpret the workflow files (e.g., "Do not hallucinate files").
- **Edit**: Edit the files in `docs/agent-context/...`, then run `openskills-to-antigravity` to apply.

### Workflow Logic

- **Edit**: Always edit the source in `~/.agent/skills/<skill>/SKILL.md` (or the upstream repo).
- **Do not edit generated files** directly in `.agent/workflows` or `.codeium/...` as they will be overwritten.
