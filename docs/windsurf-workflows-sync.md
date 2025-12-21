# Windsurf Workflows Sync

## Overview

This system syncs **openskills** (used by Claude Code) to **native Windsurf workflows**, solving the invocation problem where Windsurf AI doesn't reliably run `openskills read <skill-name>`.

**Problem solved**: Windsurf agents now have direct access to core skills as native workflows, eliminating the need for the AI to remember to run Bash commands.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│ Single Source of Truth: openskills                         │
│ Location: .agent/skills/                                    │
└─────────────────────────────────────────────────────────────┘
                          │
                          │ openskills-to-windsurf sync
                          ▼
┌─────────────────────────────────────────────────────────────┐
│ Generated Workflows (auto-updated)                          │
│ Location: .codeium/windsurf/global_workflows/              │
└─────────────────────────────────────────────────────────────┘
                          │
                          │ Windsurf AI reads directly
                          ▼
┌─────────────────────────────────────────────────────────────┐
│ Windsurf Agent (reliable invocation)                        │
│ Invocation: @workflow <skill-name> or Cascade menu         │
└─────────────────────────────────────────────────────────────┘
```

## Core Skills Synced

The following 9 critical skills are synced as native Windsurf workflows:

1. **brainstorming** - Use BEFORE any creative/implementation work
2. **systematic-debugging** - When encountering bugs or test failures
3. **test-driven-development** - When implementing features/bugfixes
4. **verification-before-completion** - BEFORE claiming work is complete
5. **writing-plans** - When creating implementation plans
6. **requesting-code-review** - Before merging/completing major features
7. **receiving-code-review** - When processing code review feedback
8. **using-git-worktrees** - When starting isolated feature work
9. **finishing-a-development-branch** - When implementation is complete

All workflows use `auto_execution_mode: 0` (manual invoke only).

## Usage

### Running the Sync

When you update skills in openskills or pull new skills:

```bash
openskills-to-windsurf sync
```

This will:
- Read all core skills from `.agent/skills/*/SKILL.md`
- Generate/update workflow files in `.codeium/windsurf/global_workflows/`
- Report sync status

### Invoking Workflows in Windsurf

**Method 1: @workflow mention**
```
@workflow brainstorming
```

**Method 2: Cascade menu**
- Click Cascade menu in Windsurf
- Select "Workflows"
- Choose the skill

**Method 3: Direct file reference**
The AI can also read workflows directly from `.codeium/windsurf/global_workflows/`

## Relationship with openskills

**Hybrid approach**:
- **Core skills** (9 most critical) → Native Windsurf workflows (reliable)
- **Specialized skills** (remaining) → openskills via `openskills read` (advanced use)

This gives you:
- ✅ Reliable invocation for critical workflows
- ✅ Full openskills ecosystem for specialized skills
- ✅ Single source of truth (openskills)
- ✅ Automatic sync via generator

## When to Sync

Run `openskills-to-windsurf sync` when:

1. **After updating skills** in openskills
2. **After pulling** new skills from upstream
3. **When skills seem out of sync** between Claude Code and Windsurf
4. **When adding new core skills** to the sync list

## Modifying Core Skills List

Edit the `CORE_SKILLS` array in `/Users/dat/workspace/dotfiles/bin/.local/dotfiles-bin/openskills-to-windsurf`:

```javascript
const CORE_SKILLS = [
  'brainstorming',
  'systematic-debugging',
  // ... add/remove skills here
];
```

Then run `openskills-to-windsurf sync` to regenerate workflows.

## Comparison: Claude Code vs Windsurf

| Aspect | Claude Code | Windsurf (before) | Windsurf (after sync) |
|--------|-------------|-------------------|----------------------|
| Invocation | Native `Skill` tool | `openskills read` (Bash) | Native workflows |
| Reliability | ✅ Structured, tracked | ⚠️ AI must remember | ✅ Direct access |
| Discovery | Automatic | Via AGENTS.md | Cascade menu + @workflow |
| Maintenance | Built-in updates | Manual sync | Auto-sync tool |

## Troubleshooting

**Workflows not appearing in Windsurf:**
- Restart Windsurf after running sync
- Check `.codeium/windsurf/global_workflows/` for generated files

**Skill content outdated:**
- Run `openskills-to-windsurf sync` to regenerate

**New skill not syncing:**
- Add to `CORE_SKILLS` list in sync tool
- Run sync command

## Files

- **Sync tool**: `bin/.local/dotfiles-bin/openskills-to-windsurf`
- **Skills source**: `.agent/skills/*/SKILL.md`
- **Generated workflows**: `.codeium/windsurf/global_workflows/*.md`
- **Bootstrap workflow**: `.codeium/windsurf/global_workflows/bootstrap.md` (auto-executes)
- **Recall workflow**: `.codeium/windsurf/global_workflows/recall-skills.md` (auto-executes)
