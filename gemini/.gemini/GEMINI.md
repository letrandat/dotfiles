# Gemini Project Instructions

## Commit Attribution

When making commits in this repository, always append the following footer to the commit message:

🤖 Generated with [Gemini](https://gemini.google.com)

Co-Authored-By: Gemini <noreply@google.com>

## Task Management Policy (ALL AGENTS)

### Critical Rules

**NEVER auto-close, update, or delete tasks without explicit user confirmation.**

This applies to:
- ✅ Creating tasks: Allowed without confirmation
- ✅ Listing/viewing tasks: Allowed without confirmation
- ❌ Closing tasks: **REQUIRES USER CONFIRMATION**
- ❌ Updating task status: **REQUIRES USER CONFIRMATION**
- ❌ Deleting tasks: **REQUIRES USER CONFIRMATION**

### Workflow
1. Agent completes work → Report to user
2. **User explicitly requests to close the task**
3. Agent then closes the task

## Git Worktree Workflow

Refer to `CLAUDE.md` or `docs/plans/2025-12-20-git-worktree-workflow-design.md` for details on the `git-worktree-create` workflow.
