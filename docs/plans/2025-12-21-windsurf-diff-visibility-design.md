# Windsurf Diff Visibility Design

## Problem

Windsurf agents frequently forget to show diffs in chat when making code changes, making it hard to review what was modified.

## Solution

Add explicit "Code Change Visibility Rules" to the global rules file (`codeium/.codeium/windsurf/memories/global_rules.md`).

## Requirements

1. **Show `git diff` output** after making edits
2. **Show inline before/after diffs** when proposing changes
3. **Include diffs in walkthroughs/summaries**
4. **Apply to significant changes only** (skip trivial one-liners)

## Implementation

Add the following section to `global_rules.md` after "# Tool Rules" and before "# Superpowers Workflow Triggers":

````markdown
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
````

### 2. Git Diff Output (After Applying Changes)

Run and display `git diff <file>` after significant edits.

### 3. In Walkthroughs/Summaries

Include a "Changes Made" section with inline diffs or git diff output.

## Enforcement

- Before committing: ALWAYS run `git diff` and show output
- After multi-file edits: Show summary of all changed files with key diffs
- In task completion: Reference what changed, don't just say "done"

```

## Verification

After implementation:
1. Start a new Windsurf session
2. Ask the agent to make a multi-line code change
3. Verify the agent shows diffs before/after the change
```
