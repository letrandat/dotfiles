# Antigravity Native Workflows

## Overview

Antigravity (Gemini) uses native **Workflows** from `.agent/workflows/`. These are synced from Windsurf to maintain parity across AI agent environments.

## Sync Flow

```
openskills (source of truth)
    ↓ superpowers-sync sync
Windsurf workflows
    ↓ openskills-to-antigravity sync
Antigravity workflows (.agent/workflows/)
```

## Available Workflows

| Prefix          | Usage                                                            |
| --------------- | ---------------------------------------------------------------- |
| `superpowers-*` | Core development workflows (brainstorming, debugging, TDD, etc.) |
| `dat-*`         | Custom workflows (b2, hive-query, product-owner, etc.)           |

Invoke via `/superpowers-brainstorming`, `/dat-b2`, etc.

## How to Use

Mention the workflow directly using slash command:

```
/superpowers-brainstorming
/dat-product-owner
```

---

## Maintenance

**Sync from Windsurf:**

```bash
openskills-to-antigravity sync
```

**Full sync (from openskills):**

```bash
superpowers-sync sync
# → Will prompt to sync to Antigravity
```

> [!NOTE]
> The `superpowers-sync sync` command will automatically prompt to sync to Antigravity after completing Windsurf sync.

## Files

- **Sync tool**: `bin/.local/dotfiles-bin/openskills-to-antigravity`
- **Workflows**: `.agent/workflows/`
- **Rules**: `gemini/.gemini/rules/`
