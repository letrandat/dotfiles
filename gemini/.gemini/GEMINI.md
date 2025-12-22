# Gemini Project Instructions

## Commit Attribution

When making commits in this repository, always append the following footer to the commit message:

🤖 Generated with [Gemini](https://gemini.google.com)

Co-Authored-By: Gemini <gemini@google.com>

## Task Management Policy

### Tooling

- Always use `b2` as the task manager.
  - `b2` is a drop-in replacement for `bd` (Beads) with enhanced features.
  - Use it exactly like `bd` (e.g., `b2 create "task name"`, `b2 list`, `b2 close <id>`).
  - Key features:
    - **Stealth Mode**: By default, it does not pollute the git repo (stored in `~/.local/share/b2`).
    - **Short Hashes**: You can use the last 3 characters of an ID if unique (e.g., `b2 close 8jk`).
    - **Auto-Project**: Automatically detects the project from the git remote.
  - For full details, see the design doc: [b2 Wrapper Design](docs/plans/2025-12-21-b2-wrapper-design.md).

### Critical Rules

**NEVER auto-close or delete tasks, OR commit and push changes without explicit user confirmation.**

This applies to:

- ✅ Creating tasks: Allowed without confirmation
- ✅ Updating tasks: Allowed without confirmation
- ✅ Listing/viewing tasks: Allowed without confirmation
- ❌ Closing tasks: **REQUIRES USER CONFIRMATION**
- ❌ Deleting tasks: **REQUIRES USER CONFIRMATION**
- ❌ Committing changes: **REQUIRES USER CONFIRMATION**
- ❌ Pushing changes: **REQUIRES USER CONFIRMATION**

### Workflow

1. Agent completes work → Report to user
2. **User explicitly requests to close the task**
3. Agent then closes the task

## Superpowers Workflow Triggers

You have access to powerful "Superpowers" workflows. Your goal is to **proactively suggest** them when the user's intent matches a workflow, but **ALWAYS ask for confirmation** before running them.

### Trigger Rules

| User Intent / Context                                    | Suggested Workflow                            |
| -------------------------------------------------------- | --------------------------------------------- |
| Starting any conversation or new session                 | `/superpowers-using-superpowers`              |
| Starting a new task, feature, or design                  | `/superpowers-brainstorming`                  |
| Encountering a bug, error, or test failure               | `/superpowers-systematic-debugging`           |
| Writing code for a feature or fix                        | `/superpowers-test-driven-development`        |
| Claiming a task is "done" or "complete"                  | `/superpowers-verification-before-completion` |
| Creating a complex implementation plan                   | `/superpowers-writing-plans`                  |
| Executing an existing plan in parallel session           | `/superpowers-executing-plans`                |
| Executing plan with independent tasks in current session | `/superpowers-subagent-driven-development`    |
| 2+ independent tasks that can run in parallel            | `/superpowers-dispatching-parallel-agents`    |
| Asking for a code review                                 | `/superpowers-requesting-code-review`         |
| Receiving code review feedback                           | `/superpowers-receiving-code-review`          |
| Need to switch context/branch                            | `/superpowers-using-git-worktrees`            |
| Implementation complete, ready to integrate              | `/superpowers-finishing-a-development-branch` |
| Creating or editing skills                               | `/superpowers-writing-skills`                 |

### Interaction Protocol

When a trigger is met:

1. **Stop** and acknowledge the intent.
2. **Suggest** the relevant workflow.
3. **Ask** the user: "Would you like to run the `/[Workflow Name]` workflow?"
4. **Wait** for user confirmation.

### DO NOT

- Do NOT run the workflow automatically without asking.
- Do NOT ignore the workflows when the intent is clear.
