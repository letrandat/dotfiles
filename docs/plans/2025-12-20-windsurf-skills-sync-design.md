# Windsurf Skills Sync System Design

**Date**: 2025-12-20
**Status**: Implemented
**Author**: Claude (with user collaboration)

## Problem Statement

Windsurf AI agents don't reliably invoke superpowers skills via openskills, despite skills being documented in AGENTS.md. The root cause is an **invocation problem**: the AI knows skills exist but doesn't consistently run the Bash command `openskills read <skill-name>` to load them.

**Current flow**:
```
AGENTS.md lists skills
  → Windsurf AI reads AGENTS.md
  → AI must decide to run `openskills read <skill-name>` (unreliable)
  → Skill content loads into conversation
```

**Problem**: The Bash invocation is unstructured and easy to skip, unlike Claude Code's native `Skill` tool which provides structured, tracked invocation.

## Solution Overview

Build an automated sync system that converts openskills to native Windsurf workflows, eliminating the invocation problem while maintaining openskills as the single source of truth.

**New flow**:
```
openskills (source of truth)
  → openskills-to-windsurf sync (automated)
  → Native Windsurf workflows (generated)
  → Windsurf AI invokes directly via @workflow
```

## Architecture

### Components

1. **openskills-to-windsurf CLI tool**
   - Language: Node.js
   - Location: `bin/.local/dotfiles-bin/openskills-to-windsurf`
   - Command: `openskills-to-windsurf sync`

2. **Source: openskills**
   - Location: `.agent/skills/*/SKILL.md`
   - Format: Markdown with YAML frontmatter
   - Role: Single source of truth

3. **Generated: Windsurf workflows**
   - Location: `.codeium/windsurf/global_workflows/*.md`
   - Format: Markdown with Windsurf-specific frontmatter
   - Role: Native workflows for direct invocation

### Sync Process

```javascript
1. Read .agent/skills/*/SKILL.md for each core skill
2. Parse frontmatter (name, description)
3. Extract content (everything after frontmatter)
4. Generate workflow file:
   ---
   description: <from skill>
   auto_execution_mode: 0
   ---
   <skill content>
5. Write to .codeium/windsurf/global_workflows/<skill-name>.md
```

### Core Skills (9 total)

Only sync the most critical skills to keep the workflow list manageable:

1. brainstorming
2. systematic-debugging
3. verification-before-completion
4. test-driven-development
5. writing-plans
6. requesting-code-review
7. receiving-code-review
8. using-git-worktrees
9. finishing-a-development-branch

**Rationale**: These cover the most common development workflows. Specialized skills (root-cause-tracing, testing-anti-patterns, etc.) remain available via openskills.

## Design Decisions

### 1. Hybrid Approach

**Decision**: Core skills as workflows, specialized skills via openskills

**Alternatives considered**:
- A) Full conversion (all skills → workflows)
- B) Strengthen enforcement (better prompting for openskills)
- C) Hybrid (chosen)

**Rationale**:
- ✅ Solves invocation problem for critical workflows
- ✅ Maintains openskills ecosystem for edge cases
- ✅ Keeps workflow list manageable
- ✅ Single source of truth (openskills)

### 2. Manual Invoke Only

**Decision**: All workflows use `auto_execution_mode: 0`

**Rationale**:
- Skills should be invoked consciously, not auto-triggered
- Prevents workflows from running unintentionally
- Matches Claude Code's Skill tool behavior (explicit invocation)

### 3. Full Content Embedding

**Decision**: Embed full skill content in workflows, not just references

**Alternatives considered**:
- A) Workflow calls `openskills read` (rejected - same invocation problem)
- B) Workflow references openskills location (rejected - extra indirection)
- C) Embed full content (chosen)

**Rationale**:
- Solves the invocation problem completely
- Self-contained workflows
- No runtime dependencies on openskills CLI
- Immediate availability to Windsurf AI

### 4. Node.js Implementation

**Decision**: Implement as Node.js CLI tool

**Alternatives considered**:
- A) Shell script
- B) Python script
- C) Node.js (chosen)

**Rationale**:
- Matches openskills (also Node.js)
- Could be integrated into openskills CLI later
- Good ecosystem for markdown parsing
- Already have Node.js for openskills

## Maintenance Workflow

### When to Sync

1. After updating skills in openskills
2. After pulling new skills from upstream
3. When adding/removing core skills from the list
4. When skills seem out of sync

### How to Sync

```bash
openskills-to-windsurf sync
```

### Customization

To modify which skills sync, edit `CORE_SKILLS` array in the tool:

```javascript
const CORE_SKILLS = [
  'brainstorming',
  // ... add/remove skills here
];
```

## Updated Bootstrap Workflow

Updated `.codeium/windsurf/global_workflows/bootstrap.md` to:
- List core workflows available natively
- Mention openskills for specialized skills
- Clarify invocation methods (@workflow vs openskills read)

## Benefits

### For Windsurf Users

- ✅ Reliable skill invocation (no more "forgot to run openskills read")
- ✅ Native workflow discovery (Cascade menu, @workflow)
- ✅ Consistent experience across sessions
- ✅ Core workflows always available

### For Maintenance

- ✅ Single source of truth (openskills)
- ✅ Automated sync (no manual copy-paste)
- ✅ Version control (workflows in git)
- ✅ Easy to extend (add to CORE_SKILLS list)

### Comparison to Claude Code

| Feature | Claude Code | Windsurf (before) | Windsurf (after) |
|---------|-------------|-------------------|------------------|
| Invocation | Native Skill tool | Bash command | Native workflow |
| Reliability | ✅ High | ⚠️ Low | ✅ High |
| Discovery | Automatic | AGENTS.md | Cascade + @workflow |
| Tracking | Structured | Unstructured | Structured |

## Testing

Tested with:
- ✅ All 9 core skills sync successfully
- ✅ Generated workflows have correct format
- ✅ Frontmatter includes description and auto_execution_mode
- ✅ Full skill content embedded in workflow body
- ✅ Files appear in `.codeium/windsurf/global_workflows/`

## Future Enhancements

1. **Configuration file** (`.windsurf-sync.json`) for customizing sync behavior
2. **Incremental sync** - only update changed skills
3. **Integration with openskills CLI** - add as `openskills to-windsurf` command
4. **Auto-sync on openskills install/update** - hook into openskills lifecycle
5. **Bidirectional sync** - update openskills if workflow edited (advanced)

## Files

- **Design doc**: `docs/plans/2025-12-20-windsurf-skills-sync-design.md`
- **Usage doc**: `docs/windsurf-workflows-sync.md`
- **Sync tool**: `bin/.local/dotfiles-bin/openskills-to-windsurf`
- **Generated workflows**: `.codeium/windsurf/global_workflows/*.md` (9 files)
- **Updated bootstrap**: `.codeium/windsurf/global_workflows/bootstrap.md`
- **Updated recall**: `.codeium/windsurf/global_workflows/recall-skills.md`
