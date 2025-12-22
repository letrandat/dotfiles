# Windsurf Native Workflows

## Overview

Windsurf uses native **Workflows** to implement high-quality development patterns (Superpowers). These are direct, reliable, and accessible via the `@workflow` command or the Cascade menu.

## Available Superpowers

| Workflow | Usage |
|----------|-------|
| `superpowers-using-superpowers` | **MANDATORY** at start of every session |
| `superpowers-brainstorming` | Use BEFORE any new feature or design work |
| `superpowers-systematic-debugging` | Use for any bug, error, or test failure |
| `superpowers-test-driven-development` | Use when implementing features or fixes |
| `superpowers-verification-before-completion` | Use BEFORE claiming anything is "done" |
| `superpowers-writing-plans` | Use to create detailed implementation plans |
| `superpowers-executing-plans` | Use when executing a previously written plan |
| `superpowers-dispatching-parallel-agents` | Use for 2+ independent tasks that can run in parallel |
| `superpowers-subagent-driven-development` | Use when executing plans with independent tasks in current session |
| `superpowers-requesting-code-review` | Use before merging major work |
| `superpowers-receiving-code-review` | Use when processing review feedback |
| `superpowers-using-git-worktrees` | Use for isolated workspace management |
| `superpowers-finishing-a-development-branch` | Use to finalize and merge work |
| `superpowers-writing-skills` | Use when creating or editing skills |

## How to Use

### 1. In Conversation
Mention the workflow directly to the agent:
```
@workflow superpowers-brainstorming
```

### 2. From Menu
Click the Cascade menu icon and select "Workflows" to see the full list of superpowers.

## Auto-Suggestions

Windsurf uses a two-tier suggestion system:

### 1. Intent-Based Triggers
Suggests workflows based on your message content (e.g., mentioning a bug triggers `superpowers-systematic-debugging`).

### 2. State-Based Workflow Progression (New)
Automatically suggests the next logical workflow based on completion state. When a workflow completes, it emits a state marker, and Windsurf suggests the next step in the development lifecycle:

```
brainstorming complete → suggest: worktrees + writing-plans
plan complete → suggest: executing-plans
execution complete → suggest: verification-before-completion
verification complete → suggest: requesting-code-review
code-review complete → suggest: finishing-a-development-branch
```

**Priority:** State-based suggestions override intent-based when both apply.

---

## Maintenance (Internal Only)

The workflows are managed via a sync tool that ensures parity across different agent environments.

**Update workflows:**
```bash
# Sync latest skills from upstream first
openskills sync

# Then sync to Windsurf workflows
openskills-to-windsurf sync
```

**Note:** The `openskills-to-windsurf sync` command will automatically run `openskills sync` first to ensure you have the latest skill definitions before syncing to Windsurf.

### State Machine Maintenance

After syncing, agents MUST verify:
- State marker integrity (`<!-- WORKFLOW-STATE: ... -->` comments)
- State transition flow compatibility
- Whether new workflows need to be added to the state machine
- Accuracy of `global_rules.md` state transition table

The sync script will remind agents to perform this validation.