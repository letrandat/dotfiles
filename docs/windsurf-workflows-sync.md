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
| `superpowers-requesting-code-review` | Use before merging major work |
| `superpowers-receiving-code-review` | Use when processing review feedback |
| `superpowers-using-git-worktrees` | Use for isolated workspace management |
| `superpowers-finishing-a-development-branch` | Use to finalize and merge work |

## How to Use

### 1. In Conversation
Mention the workflow directly to the agent:
```
@workflow superpowers-brainstorming
```

### 2. From Menu
Click the Cascade menu icon and select "Workflows" to see the full list of superpowers.

## Auto-Suggestions
Windsurf is configured with **Global Rules** to automatically suggest the correct superpower based on your message (e.g., if you mention a bug, it will ask if you want to run `superpowers-systematic-debugging`).

---

## Maintenance (Internal Only)

The workflows are managed via a sync tool that ensures parity across different agent environments.

**Update workflows:**
```bash
openskills-to-windsurf sync
```
*Run this only if you have modified the source skill definitions.*