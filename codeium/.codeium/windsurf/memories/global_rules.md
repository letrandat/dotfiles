---
trigger: always_on
---

# Global Rules

This file contains global rules that apply to all conversations.

# Tool Rules

- **Issue Tracking**: ALWAYS use `b2` (not `bd`). `b2` is the improved wrapper with stealth mode.
  - Start session: `b2 onboard`
  - List tasks: `b2 list`
  - Update task: `b2 update`
  - Close task: `b2 close`

# Superpowers Workflow Triggers

You have access to powerful "Superpowers" workflows. Your goal is to **proactively suggest** them when the user's intent matches a workflow, but **ALWAYS ask for confirmation** before running them.

## Trigger Rules

| User Intent / Context | Suggested Workflow |
|-----------------------|--------------------|
| Starting any conversation or new session | `superpowers-using-superpowers` |
| Starting a new task, feature, or design | `superpowers-brainstorming` |
| Encountering a bug, error, or test failure | `superpowers-systematic-debugging` |
| Writing code for a feature or fix | `superpowers-test-driven-development` |
| Claiming a task is "done" or "complete" | `superpowers-verification-before-completion` |
| Creating a complex implementation plan | `superpowers-writing-plans` |
| Executing an existing plan | `superpowers-executing-plans` |
| Asking for a code review | `superpowers-requesting-code-review` |
| Receiving code review feedback | `superpowers-receiving-code-review` |
| Need to switch context/branch | `superpowers-using-git-worktrees` |
| Implementation complete, ready to integrate | `superpowers-finishing-a-development-branch` |

## Interaction Protocol

When a trigger is met:

1. **Stop** and acknowledge the intent.
2. **Suggest** the relevant workflow.
3. **Ask** the user: "Would you like to run the `[Workflow Name]` workflow to help with this?"
4. **Wait** for user confirmation (Yes/No).

**Example:**
User: "I'm getting a weird error in the auth service."
Agent: "I see you're dealing with an error. That sounds like a job for our systematic debugging process. Would you like to run the `superpowers-systematic-debugging` workflow?"

## DO NOT

- Do NOT run the workflow automatically without asking.
- Do NOT ignore the workflows when the intent is clear.