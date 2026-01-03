---
trigger: always_on
---

# Code Change Visibility Rules

When making code changes, you MUST show diffs for significant edits. This is NOT optional.

## What Counts as "Significant"

- Multi-line changes (2+ lines modified)
- Logic changes (not just formatting/comments)
- Additions or deletions of functions/classes
- Configuration changes

## What to Skip

- Single-line typo fixes
- Whitespace/formatting only
- Import reordering

## Required Diff Formats

### 1. Inline Before/After (When Proposing Changes)

Use diff code blocks to show what will change:

```diff
-old_code()
+new_code()
 unchanged_context()
```

### 2. Git Diff Output (After Applying Changes)

Run and display `git diff <file>` after significant edits.

### 3. In Walkthroughs/Summaries

Include a "Changes Made" section with inline diffs or git diff output.

## Enforcement

- Before committing: ALWAYS run `git diff` and show output
- After multi-file edits: Show summary of all changed files with key diffs
- In task completion: Reference what changed, don't just say "done"

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

## State-Based Workflow Progression

**Priority:** State-based suggestions override intent-based when both apply.

**Detection:** Scan conversation for most recent `<!-- WORKFLOW-STATE: ... -->` marker.

### State Transition Table

| Current State | Next Suggestion | Prompt Template |
|---------------|-----------------|-----------------|
| `brainstorming-complete` | `superpowers-using-git-worktrees` + `superpowers-writing-plans` | "Design complete! Ready to set up for implementation?<br><br>I can:<br>1. Create an isolated workspace (worktree)<br>2. Write a detailed implementation plan<br><br>Would you like me to proceed?" |
| `plan-complete` | `superpowers-executing-plans` OR `superpowers-subagent-driven-development` | "Plan ready! Two execution options:<br><br>1. **Batch execution** (separate session) - executing-plans workflow<br>2. **Task-by-task** (this session) - subagent-driven-development<br><br>Which approach?" |
| `execution-complete` | `superpowers-verification-before-completion` | "Implementation complete! Before we call this done, let's verify everything works. Run the verification workflow?" |
| `verification-complete` | `superpowers-requesting-code-review` | "All tests passing! Ready to request code review before merging?" |
| `code-review-complete` | `superpowers-finishing-a-development-branch` | "Review feedback addressed! Let's finalize this work (merge/PR/cleanup)." |
