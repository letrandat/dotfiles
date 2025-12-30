---
description: Import an OpenSpec change into Beads tasks with high-quality detail
auto_execution_mode: 0
---

# Beads from OpenSpec

## Overview

Converts a VALIDATED OpenSpec change into actionable, high-quality, **self-contained** Beads tasks.
This workflow acts as a **Product Owner**, synthesizing the Proposal, Task List, and Specifications to create deep, verifiable tasks that any agent (even a new hire with zero context) can execute.

**Key Principles:**

- **Atomic**: Each task is focused and manageable
- **Self-Contained**: No reliance on spec files - all context embedded
- **Verifiable**: Clear acceptance criteria and verification steps
- **Actionable**: Includes problem statement, solution, files to change, and expected outcome

## Quick Reference

**Before you start:**

1. Validate: `openspec validate <change-id> --strict` - STOP if this fails
2. Detect project name: `get-project-name` (optional, or use user-provided name)
3. Read proposal.md, tasks.md, and ALL referenced specs

**Task creation formula:**

- **1-2 files per task** (optimal) | **3 files** (maximum) | **4+ files** (split it!)
- Must include: Problem + Solution + Files + Requirements + Verification
- Priority: P1 (blocking/critical), P2 (important/normal), P3 (nice to have)
- Tags: `[project-name]` in title + label (if available)

**Quality checks:**

- ✅ Each task stands alone (no external references)
- ✅ Verification steps are specific commands/tests
- ✅ All tasks.md items converted
- ✅ Dependencies documented in descriptions

## The Process

### 0. Detect Project Name (Optional)

Use user-provided project name if available. Otherwise, optionally detect:

```bash
PROJECT_NAME=$(get-project-name 2>/dev/null || echo "")
```

Use `[project-name]` tags in titles and labels if available.

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
3. **Assign Priority**: P1 (blocks other work, critical bugs, security), P2 (normal work), P3 (nice-to-have)
4. **Create Self-Contained Task**: Use the template below.

**Splitting Strategies:**

- Split by layer (e.g., "Update API endpoint" + "Update UI component")
- Split by concern (e.g., "Add validation logic" + "Add error handling")
- Split by file type (e.g., "Update schema" + "Update migration" + "Update tests")

#### Task Creation Template

For each atomic task, create with this structure:

```bash
bd create "[project-name] <Verb> <Object>" \
  --parent <Epic-ID> \
  --priority <P1/P2/P3> \
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

## Dependencies (if applicable)
⚠️ This task requires:
- Task <project>-<id>: <Brief description of what must be done first>

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
  --parent "$EPIC_ID" \
  --priority P1 \
  --label "myapp,database,schema" \
  --description "
## Problem Statement
Need database tables to store user credentials and sessions for authentication system.

## Solution Approach
Create users table with email/password fields and sessions table for JWT tracking.

## Files to Change
1. db/schema.sql - Add users and sessions tables
2. db/migrations/001.sql - Migration script to create tables

## Requirements (Embedded from Specs)
- Users table must have: id (UUID), email (unique), password_hash, created_at
- Sessions table must have: id, user_id (FK), token_hash, expires_at
- Email must be case-insensitive unique (use LOWER index)

## Expected Outcome
- Database has users and sessions tables
- Email uniqueness is enforced case-insensitively
- Foreign key relationship exists between sessions.user_id and users.id

## Verification Steps
- [ ] Run migration: psql -f db/migrations/001.sql
- [ ] Verify tables exist: \dt in psql shows users and sessions
- [ ] Test email uniqueness: INSERT duplicate email with different case should fail
- [ ] Verify FK constraint: DELETE user should cascade to sessions

## Context for New Agents
This project uses PostgreSQL. Migrations are applied manually via psql.
Schema file is source of truth; migrations modify existing databases.
"

# Task 2: JWT Library (1 file) - P1
# Task 3: Auth API Endpoint (2 files) - P1
# Task 4: Login UI (1 file) - P2
# Task 5: Signup UI (1 file) - P2
```

## Tips for Product Owners

### Critical Rules

1. **Read the actual files** mentioned in specs/ - don't just reference them
2. **Think like a new hire** - what would THEY need to know?
3. **Be specific about verification** - "run tests" is vague, "run `pytest tests/auth.test.ts` and verify all 5 tests pass" is clear
4. **Embed, don't link** - copy the actual requirement text, not just "see spec X"
5. **Project tags help filtering** - consistent tagging makes task management easier

### Error Handling

If commands fail:

- **`openspec validate` fails**: Fix the OpenSpec change first, don't proceed

### When to Refine OpenSpec vs Create Tasks

**Refine the OpenSpec if:**

- Requirements are vague or contradictory
- Critical specs are missing
- Proposal doesn't explain "Why" clearly
- Tasks.md has items that are too large or unclear

**Create tasks if:**

- OpenSpec validates cleanly
- All referenced specs exist and are complete
- You can articulate clear problem statements for each task
- File impacts are identifiable

### Integration with Other Workflows

This workflow integrates with:

- **verification-before-completion**: Use after implementing tasks to verify completion
- **dat-rule-of-five**: Apply when creating complex task descriptions or reviewing task quality
