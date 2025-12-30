---
description: Import an OpenSpec change into Beads tasks with high-quality detail
auto_execution_mode: 0
---

# Beads from OpenSpec

## Overview

Converts a VALIDATED OpenSpec change into actionable, high-quality, **self-contained** Beads tasks.
This workflow acts as a **Product Owner**, synthesizing the Proposal, Task List, and Specifications to create deep, verifiable tasks that any agent (even a new hire with zero context) can execute.

**Key Principles:**

- **Atomic**: Each task touches at MOST 3 files (aim for 2 on average)
- **Self-Contained**: No reliance on spec files - all context embedded
- **Verifiable**: Clear acceptance criteria and verification steps
- **Actionable**: Includes problem statement, solution, files to change, and expected outcome

## Quick Reference

**Before you start:**

1. Validate: `openspec validate <change-id> --strict`
2. Detect project name: `get-project-name` (optional)
3. Read proposal.md, tasks.md, and ALL referenced specs

**Task creation formula:**

- 1-3 files = ideal task size
- Must include: Problem + Solution + Files + Requirements + Verification
- Priority: P1 (blocking/critical), P2 (important/normal), P3 (nice to have)
- Tags: `[project-name]` in title + label

**Quality checks:**

- ✅ Each task stands alone (no external references)
- ✅ Verification steps are specific commands/tests
- ✅ All tasks.md items converted
- ✅ Dependencies documented

## Checklist

- [ ] `openspec validate <change-id>` passes.
- [ ] You are ready to transition from Planning to Execution.

## The Process

### 0. Detect Project Name (Optional)

**Use the project name if user provided it explicitly.** Otherwise, optionally try to detect it:

```bash
PROJECT_NAME=$(get-project-name 2>/dev/null || echo "")
if [ -n "$PROJECT_NAME" ]; then
  echo "Using project name: $PROJECT_NAME"
else
  echo "No project name detected, skipping tagging"
fi
```

If a project name is found (either from user or detection), use it as a tag: `[project-name]` in task titles and labels.
If not available, skip tagging - it's a nice-to-have feature.

### 1. Validate & Orient

1. Run `openspec validate <change-id> --strict`. **STOP** if this fails.
2. Read the source of truth files in `openspec/changes/<change-id>/`:
   - `proposal.md`: Understand the "Why" and "What".
   - `tasks.md`: The list of "How".
3. Read ALL referenced specs in `specs/`. **Crucial**: You must read the specific requirement files to generate good acceptance criteria.

### 2. Create Epic

Create a parent Epic to house the work. Include project tag if available.

```bash
bd create "[project-name] Epic: <Proposal Title>" \
  --type epic \
  --label "project-name,epic" \
  --description "Implements OpenSpec Change: <change-id>. $(<Proposal Summary>)" \
  --json
```

### 3. Break Down & Create Atomic Tasks

For **EACH** item in `tasks.md`:

1. **Analyze File Impact**: List all files this task will touch.
2. **Split if Needed**: If >3 files, break into smaller sub-tasks (aim for 2 files/task).
3. **Create Self-Contained Task**: Use the template below.

#### Task Breakdown Rules

- ✅ **GOOD**: 1-2 files per task (optimal)
- ✅ **ACCEPTABLE**: 3 files per task (maximum)
- ❌ **TOO LARGE**: 4+ files → Split into multiple tasks

**Splitting Strategies:**

- Split by layer (e.g., "Update API endpoint" + "Update UI component")
- Split by concern (e.g., "Add validation logic" + "Add error handling")
- Split by file type (e.g., "Update schema" + "Update migration" + "Update tests")

**Priority Assignment:**

- **P1**: Blocks other tasks, critical bugs, security issues, must-have for MVP
- **P2**: Important features, normal development work, non-blocking enhancements
- **P3**: Nice-to-have improvements, polish, optional features

#### Task Creation Template

For each atomic task, create with this structure:

```bash
bd create "[project-name] <Verb> <Object>" \
  --parent <Epic-ID> \
  --priority <P1/P2> \
  --type task \
  --label "project-name,<relevant-tags>" \
  --description "
## Problem Statement
<WHY does this specific task need to be done? What problem does it solve?
Extract from proposal.md but make it specific to THIS task.>

## Solution Approach
<WHAT needs to be implemented? High-level approach.
Extract design details from specs/ and embed them here.>

## Files to Change
1. \`path/to/file1.ext\` - <What changes here>
2. \`path/to/file2.ext\` - <What changes here>
[3. \`path/to/file3.ext\` - <What changes here>] ← Only if absolutely necessary

## Requirements (Embedded from Specs)
- <COPY exact requirement from specs/foo.md line X-Y>
- <COPY exact requirement from specs/bar.md line A-B>
- <COPY any constraints, edge cases, or technical decisions>

## Expected Outcome
<What does success look like? What should work after this task?>
- User can <do something>
- System behaves <in this way>
- Code meets <these standards>

## Verification Steps
- [ ] <Specific test to run or behavior to verify>
- [ ] <Lint/type check passes for changed files>
- [ ] <Integration point works (if applicable)>
- [ ] <Edge cases handled (list specific cases)>

## Context for New Agents
<Any domain knowledge, project conventions, or background needed.
Assume the agent knows NOTHING about this codebase.>
" \
  --json
```

### 4. Verify & Report

1. **Verify all items converted**: Check that every item in `tasks.md` has a corresponding task created
2. **Run `bd ready`** to confirm tasks are correctly queued
3. **Check dependencies**: Ensure tasks with dependencies have them documented
4. Report the created structure to the user

```markdown
**Beads Implementation Ready**
Epic: `task-xyz` ([project-name] <Title>)

**Created Tasks** (X tasks, avg Y files/task):

- `task-abc`: [project-name] <Task 1> (2 files) [P1]
- `task-def`: [project-name] <Task 2> (1 file) [P2]
  ...

**Verification:**
- ✅ All tasks.md items converted
- ✅ Dependencies documented
- ✅ All tasks are atomic (≤3 files)
- ✅ All tasks have complete context
```

## Examples

### ❌ BAD: Overly Broad Task (7 files)

```bash
bd create "Add user authentication"
# Files: api/auth.ts, db/schema.sql, db/migrations/001.sql,
#        ui/login.tsx, ui/signup.tsx, lib/jwt.ts, tests/auth.test.ts
```

**Problem**: Too many files, too many concerns, impossible for a new agent to tackle.

### ✅ GOOD: Split into Atomic Tasks

```bash
# Task 1: Database Schema (2 files)
bd create "[myapp] Add user authentication schema" \
  --description "
## Problem Statement
Need database tables to store user credentials and sessions for authentication system.

## Solution Approach
Create users table with email/password fields and sessions table for JWT tracking.

## Files to Change
1. \`db/schema.sql\` - Add users and sessions tables
2. \`db/migrations/001.sql\` - Migration script to create tables

## Requirements (Embedded from Specs)
- Users table must have: id (UUID), email (unique), password_hash, created_at
- Sessions table must have: id, user_id (FK), token_hash, expires_at
- Email must be case-insensitive unique (use LOWER index)
..."

# Task 2: JWT Library (1 file)
bd create "[myapp] Implement JWT token utilities" \
  --description "
## Problem Statement
Need functions to generate and verify JWT tokens for session management.

## Solution Approach
Create utility module with sign() and verify() functions using HS256 algorithm.

## Files to Change
1. \`lib/jwt.ts\` - Token generation and verification functions
..."

# Task 3: Auth API Endpoint (2 files)
bd create "[myapp] Create login/signup API endpoints" \
  --description "
## Problem Statement
Need REST endpoints for users to register and login.

## Solution Approach
POST /api/auth/signup and POST /api/auth/login endpoints.

## Files to Change
1. \`api/auth.ts\` - Signup and login route handlers
2. \`tests/auth.test.ts\` - Integration tests for auth endpoints
..."

# Task 4: Login UI (1 file)
bd create "[myapp] Build login form component"

# Task 5: Signup UI (1 file)
bd create "[myapp] Build signup form component"
```

**Why This Is Better:**

- Each task is 1-2 files (3 max)
- New agent can complete any task independently
- Clear dependencies: Task 1 → Task 2 → Task 3 → Task 4/5
- Each has specific problem, solution, and verification

### Task Dependency Management

When tasks have dependencies, note them in the description:

```bash
bd create "[myapp] Create login API endpoint" \
  --description "
## Problem Statement
...

## Dependencies
⚠️ This task requires:
- Task dotfiles-123: JWT utilities must be implemented first
- Task dotfiles-456: Database schema must be migrated

## Solution Approach
..."
```

## Tips for Product Owners

### Critical Rules

1. **Read the actual files** mentioned in specs/ - don't just reference them
2. **Think like a new hire** - what would THEY need to know?
3. **Be specific about verification** - "run tests" is vague, "run `pytest tests/auth.test.ts` and verify all 5 tests pass" is clear
4. **Embed, don't link** - copy the actual requirement text, not just "see spec X"
5. **2 files is the sweet spot** - most tasks should be 2 files (implementation + test)
6. **Project tags help filtering** - consistent tagging makes task management easier

### Error Handling

If commands fail:

- **`openspec validate` fails**: Fix the OpenSpec change first, don't proceed

### Integration with Other Workflows

This workflow integrates with:

- **verification-before-completion**: Use after implementing tasks to verify completion
- **dat-rule-of-five**: Apply when creating complex task descriptions or reviewing task quality

## Summary

This workflow ensures every Beads task created from an OpenSpec change is:

- ✅ **Atomic** (1-3 files max, aim for 2)
- ✅ **Self-contained** (all context embedded, no external references)
- ✅ **Verifiable** (specific verification steps with commands)
- ✅ **Actionable** (clear problem, solution, files, expected outcome)
- ✅ **Prioritized** (P1/P2/P3 assigned appropriately)
- ✅ **Tagged** (project name for filtering and organization)

Ready for any agent to execute, even with zero project context.
