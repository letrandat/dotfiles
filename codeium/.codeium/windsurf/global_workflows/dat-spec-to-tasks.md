---
description: Import an OpenSpec change into Beads tasks
auto_execution_mode: 0
---

# Beads from OpenSpec

## Overview

Converts a VALIDATED OpenSpec change into actionable Beads tasks. This is the **Implementation** phase of the workflow (Execution).

## When to Use

- After `openspec validate <id>` returns success
- When you are ready to start coding
- To transition from Planning (OpenSpec) to Execution (Beads)

## The Process

### 1. Identify Input

**Command:** `@workflow dat-spec-to-tasks <change-id>`

### 2. Validation Check

**Agent Action**:
Run `openspec validate <change-id> --strict`.

- If it fails: **ABORT**. Report errors to user.
- If it passes: Proceed.

### 3. Parse OpenSpec Data

Read the files in `openspec/changes/<change-id>/`:

- `proposal.md`: Sources the Epic Description.
- `tasks.md`: Sources the list of implementation tasks.
- `specs/**/*.md`: Used for referencing requirements.

### 4. Create Beads Epic

Create a parent Epic to track the entire change.

```bash
# Title derived from proposal title
# Description includes link to proposal and summary
bd create "Epic: <Title>" --type epic --description "$(<proposal_summary>)"
```

### 5. Create Child Tasks

Iterate through `tasks.md` (which should contain a list of tasks).
For each task:

1. **Create Task**:

   ```bash
   bd create "<Task Text>" --parent <epic-id> --priority <P1/P2>
   ```

2. **Enrich Description**:
   - Add "Context" from the OpenSpec intent.
   - Link to specific Spec Requirements if applicable (e.g., "See `specs/auth/spec.md` Req 1.2").

### 6. Completion

**Report to user:**

```markdown
**Beads Implementation Ready**: `task-xyz`

- [x] Validated OpenSpec change `<change-id>`
- [x] Created Epic `task-xyz`
- [x] Created N child tasks

**Next Step**:
Run `bd show task-xyz` or start working with `bd ready`.
```
