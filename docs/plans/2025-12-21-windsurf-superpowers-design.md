# Windsurf Superpowers Integration Design

**Date:** 2025-12-21
**Status:** Implemented

## Overview

This design establishes a comprehensive system for integrating superpowers workflows into Windsurf (Cascade AI), enabling context-aware workflow suggestions while maintaining user control.

## Problem Statement

Windsurf workflows weren't clearly grouped as "superpowers", making them harder to discover and understand as a cohesive system. Additionally, Cascade needed a way to know when to suggest specific workflows based on user intent without auto-executing them.

## Solution Architecture

### 1. Workflow Naming & Organization

All 11 core superpowers workflows use a `superpowers-` prefix for discoverability:

- `superpowers-using-superpowers` - Session initialization
- `superpowers-brainstorming` - Creative/design work
- `superpowers-systematic-debugging` - Bug investigation
- `superpowers-test-driven-development` - Feature implementation
- `superpowers-verification-before-completion` - Completion verification
- `superpowers-writing-plans` - Implementation planning
- `superpowers-executing-plans` - Plan execution
- `superpowers-requesting-code-review` - Review requests
- `superpowers-receiving-code-review` - Review feedback processing
- `superpowers-using-git-worktrees` - Workspace isolation
- `superpowers-finishing-a-development-branch` - Work integration

This grouping makes workflows discoverable in Windsurf's workflow menu and clearly identifies them as special "superpower" capabilities.

### 2. Global Rule - Awareness-First Approach

A single global rule (`codeium/.codeium/windsurf/memories/global_rules.md`) with `trigger: always_on` provides:

**Intent Mapping:**
A trigger table mapping user intent/context to specific workflows:
- "Encountering a bug, error, or test failure" → `superpowers-systematic-debugging`
- "Starting a new task, feature, or design" → `superpowers-brainstorming`
- And 9 more mappings...

**Interaction Protocol:**
4-step process when a trigger is met:
1. Stop and acknowledge the intent
2. Suggest the relevant workflow
3. Ask: "Would you like to run the `[Workflow Name]` workflow?"
4. Wait for user confirmation

**Boundaries:**
Clear DO NOTs:
- Don't auto-run workflows (user must confirm)
- Don't ignore workflows when intent is clear

This lives in `memories/` (not `global_workflows/`) because it's a meta-rule about *when* to use workflows, not a workflow itself.

### 3. Sync Architecture

The `openskills-to-windsurf` script automates one-way sync from openskills → Windsurf:

**Source of Truth:**
- `.agent/skills/*/SKILL.md` - Openskills format

**Generated Artifacts:**
- `codeium/.codeium/windsurf/global_workflows/superpowers-*.md` - Windsurf native workflows

**Sync Process:**
1. Parse each skill's frontmatter (name, description) and body
2. Generate Windsurf workflow with `auto_execution_mode: 0` (manual invoke only)
3. Prefix filename with `superpowers-` for grouping
4. Write to global_workflows directory

**One Command:**
```bash
openskills-to-windsurf sync
```

**When to Sync:**
- After updating skills via openskills
- After pulling new skills from upstream
- When skills seem out of sync between Claude Code and Windsurf

## Implementation Details

### Files Modified

1. **`bin/.local/dotfiles-bin/openskills-to-windsurf`**
   - Added 2 new skills: `using-superpowers`, `executing-plans`
   - Added `superpowers-` prefix to all generated filenames
   - Now syncs 11 total workflows

2. **`codeium/.codeium/windsurf/memories/global_rules.md`**
   - Updated trigger table from 8 → 11 workflows
   - Added: `using-superpowers`, `receiving-code-review`, `finishing-a-development-branch`

3. **`.gitignore`**
   - Changed to allow `*.md` files in memories directory
   - Pattern: `codeium/.codeium/windsurf/memories/*` with exception `!codeium/.codeium/windsurf/memories/*.md`

### Files Deleted

- Old unprefixed workflows (9 files): `brainstorming.md`, `systematic-debugging.md`, etc.
- Bootstrap workflows in both `.agent/workflows/` and `codeium/.codeium/windsurf/global_workflows/`

### Files Added

- 11 new `superpowers-*` prefixed workflows in `global_workflows/`
- `codeium/.codeium/windsurf/memories/global_rules.md` (now tracked in git)

## User Experience

1. User starts a conversation in Windsurf
2. Cascade detects intent (e.g., "I have a bug in auth")
3. Cascade suggests: "Would you like to run `superpowers-systematic-debugging`?"
4. User confirms or declines
5. If confirmed, workflow loads with full instructions

## Maintenance

To update workflows after changing skills:
```bash
openskills-to-windsurf sync
```

The sync script ensures Windsurf always has the latest skill content without manual copying.

## Design Principles

- **User Control:** Always ask before running workflows
- **Discoverability:** Prefix grouping makes workflows easy to find
- **Single Source of Truth:** Openskills are authoritative, Windsurf workflows are generated
- **Automation:** One command to sync all changes
- **Context-Awareness:** Global rule maps intent to workflows intelligently
