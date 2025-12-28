---
description: Refine Beads epic task breakdown iteratively
---

# Refine Epic

## Overview

Iteratively analyze and improve a Beads epic's task breakdown, focusing on granularity, dependencies, parallelization, and completeness. Supports up to 5 refinement iterations.

## When to Use

- After creating an epic with `/dat-plan-to-beads`
- When an existing epic has unclear or poorly structured tasks
- Before starting implementation on a complex epic
- When you want to optimize for parallel execution

## The Process

### 1. Fetch Epic and Tasks

```bash
bd show <epic-id>
# Get all child tasks
bd list --parent <epic-id>
```

### 2. Analyze Current State

**Evaluate across 5 dimensions:**

#### A. Granularity

- **Too Large**: Tasks that take >4 hours or span multiple components
- **Too Small**: Tasks that take <30 minutes or are trivial
- **Just Right**: Tasks that take 1-4 hours with clear deliverables

#### B. Dependencies

- **Missing**: Task B needs Task A but no dependency exists
- **Incorrect**: Dependency exists but isn't actually required
- **Circular**: Task A depends on B, B depends on A

#### C. Parallelization

- **Opportunities**: Tasks that can run in parallel but aren't marked as such
- **Blockers**: Critical path tasks that block multiple others
- **Batching**: Related tasks that should be grouped for efficiency

#### D. Completeness

- **Missing Tasks**: Edge cases, error handling, documentation
- **Missing Tests**: Verification tasks for each component
- **Missing Cleanup**: Refactoring, tech debt, deprecation

#### E. Clarity

- **Vague Descriptions**: Missing context, scope, or success criteria
- **Ambiguous Titles**: Unclear what the task actually does
- **Missing Links**: No reference to design docs or related tasks

### 3. Propose Refinements

**Present findings to user:**

```markdown
## Epic Refinement Analysis: task-xyz

### Iteration X of 5

#### Issues Found:

**Granularity** (3 issues):

- task-abc: Too large - "Implement auth system" spans 3 components
  → Propose: Split into 3 tasks (JWT, middleware, endpoints)
- task-def, task-ghi: Too small - Both are trivial config changes
  → Propose: Merge into "Configure auth settings"

**Dependencies** (2 issues):

- task-jkl: Missing dependency on task-abc
  → Propose: Add --depends-on task-abc
- task-mno: Incorrect dependency on task-pqr (not actually needed)
  → Propose: Remove dependency

**Parallelization** (1 opportunity):

- task-stu, task-vwx: Can run in parallel (both P1, no dependencies)
  → Propose: Confirm both are P1 and independent

**Completeness** (2 gaps):

- Missing: Error handling tests for auth endpoints
  → Propose: Add task "Write error handling tests"
- Missing: Documentation for auth API
  → Propose: Add task "Document auth API endpoints"

**Clarity** (1 issue):

- task-yz: Vague description "Fix auth bug"
  → Propose: Update description with specific bug details

#### Proposed Changes:

1. Split task-abc into 3 tasks
2. Merge task-def + task-ghi
3. Add dependency: task-jkl depends on task-abc
4. Remove dependency: task-mno no longer depends on task-pqr
5. Add task: "Write error handling tests" (P1, depends on task-jkl)
6. Add task: "Document auth API endpoints" (P2)
7. Update task-yz description

**Apply these changes?** (yes/no/modify)
```

### 4. Apply Approved Changes

**For each approved change:**

```bash
# Split task
bd create "[Component A] Implement JWT" -p 1 --parent <epic-id> --description "..."
bd create "[Component A] Implement middleware" -p 1 --parent <epic-id> --description "..."
bd create "[Component A] Implement endpoints" -p 1 --parent <epic-id> --description "..."
bd close task-abc --reason "Split into 3 tasks: task-new1, task-new2, task-new3"

# Merge tasks
bd create "Configure auth settings" -p 1 --parent <epic-id> --description "..."
bd close task-def --reason "Merged into task-new4"
bd close task-ghi --reason "Merged into task-new4"

# Add dependency
bd update task-jkl --depends-on task-abc

# Remove dependency
bd update task-mno --remove-dependency task-pqr

# Add new task
bd create "Write error handling tests" -p 1 --parent <epic-id> --depends-on task-jkl --description "..."

# Update description
bd update task-yz --description "Fix auth bug: JWT expiration not validated correctly..."
```

### 5. Iterate or Complete

**After applying changes:**

- **Iteration < 5**: Ask "Want another refinement pass?" (yes/no)
  - If yes → Return to step 2
  - If no → Complete workflow
- **Iteration = 5**: "Reached 5 iterations. Epic is well-refined."
- **No improvements found**: "No further improvements possible. Epic is well-refined."

### 6. Output Final Summary

```markdown
## Epic Refinement Complete: task-xyz

**Iterations**: X of 5

**Changes Made**:

- Split 1 large task into 3 tasks
- Merged 2 small tasks into 1 task
- Added 2 missing tasks
- Fixed 3 dependencies
- Improved 1 task description

**Final Task Count**: Y tasks (was Z)

**Next Steps**:

- Review epic: `bd show task-xyz`
- Start work: `bd ready`
- Create implementation plan: `/superpower-writing-plans`
```

## Refinement Strategy

**Iteration Focus** (recommended):

1. **Iteration 1**: Granularity (split/merge tasks)
2. **Iteration 2**: Dependencies (add/remove/fix)
3. **Iteration 3**: Parallelization (optimize P1/P2, remove blockers)
4. **Iteration 4**: Completeness (add missing tasks)
5. **Iteration 5**: Clarity (improve descriptions, titles)

**Exit Conditions**:

- No issues found in any dimension
- User declines further iteration
- Reached 5 iterations
- Agent determines no meaningful improvements possible

## Best Practices

**Be Conservative:**

- Don't split tasks unless clearly too large
- Don't add dependencies unless certain
- Don't merge tasks unless truly related

**Preserve Context:**

- When splitting tasks, copy relevant context to each new task
- When merging tasks, combine all context into new task
- Always link back to design docs

**Communicate Clearly:**

- Explain WHY each change is proposed
- Show BEFORE/AFTER for complex changes
- Give user option to modify proposals

**Respect User Decisions:**

- If user rejects a change, don't propose it again
- If user modifies a proposal, use their version
- If user wants to stop iterating, respect that

## Example

**Input**: `task-ab6` (Epic: Implement 'The Rule of Five' Workflow)

**Iteration 1 Output**:

```
Issues Found:
- task-ab6.1: Too large - "Create Rule of Five Design Review Workflow" spans multiple review types
  → Split into: Design Review, Implementation Plan Review, Code Review
- Missing: Integration task to tie all workflows together

Proposed Changes:
1. Split task-ab6.1 into 3 tasks
2. Add task: "Integrate Rule of Five into existing workflows"

Apply? yes

Changes Applied:
- Created task-ab6.1a: Design Review Workflow
- Created task-ab6.1b: Implementation Plan Review Workflow
- Created task-ab6.1c: Code Review Workflow
- Closed task-ab6.1
- Created task-ab6.8: Integration task

Want another refinement pass? yes
```

**Iteration 2 Output**:

```
Issues Found:
- task-ab6.8: Missing dependency on all other tasks (should be last)

Proposed Changes:
1. Add dependencies: task-ab6.8 depends on task-ab6.1a, task-ab6.1b, ...

Apply? yes

Changes Applied:
- Updated task-ab6.8 dependencies

Want another refinement pass? no

Epic Refinement Complete!
```

## After This Workflow

**Next steps:**

1. Review refined epic: `bd show <epic-id>`
2. Start implementation: `bd ready`
3. Use `/superpower-writing-plans` for detailed plans
4. Use `/superpower-using-git-worktrees` for isolated work

## Completion State

After successfully refining, emit:

```markdown
<!-- WORKFLOW-STATE: refine-epic-complete -->
<!-- BEADS-EPIC: task-xyz -->
<!-- ITERATIONS: X -->
```
