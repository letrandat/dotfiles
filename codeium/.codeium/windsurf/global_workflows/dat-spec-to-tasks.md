---
description: Import an OpenSpec change into Beads tasks with high-quality detail
auto_execution_mode: 0
---

# Beads from OpenSpec

## Overview

Converts a VALIDATED OpenSpec change into actionable, high-quality, **self-contained** Beads tasks.
This workflow acts as a **Product Owner**, synthesizing the Proposal, Task List, and Specifications to create deep, verifiable tasks that do not rely on the existence of the source files.

## Checklist

- [ ] `openspec validate <change-id>` passes.
- [ ] You are ready to transition from Planning to Execution.

## The Process

### 1. Validate & Orient

1. Run `openspec validate <change-id> --strict`. **STOP** if this fails.
2. Read the source of truth files in `openspec/changes/<change-id>/`:
   - `proposal.md`: Understand the "Why" and "What".
   - `tasks.md`: The list of "How".
3. Read ALL referenced specs in `specs/`. **Crucial**: You must read the specific requirement files to generate good acceptance criteria.

### 2. Create Epic

Create a parent Epic to house the work.

```bash
bd create "Epic: <Proposal Title>" --type epic --description "Implements OpenSpec Change: <change-id>. $(<Proposal Summary>)" --json
```

### 3. Create Rich, Self-Contained Tasks

Iterate through the items in `tasks.md`. For **EACH** task, perform this mental step:
_"As a Product Owner, how to I create a self-contained task that an engineer can execute even if the original spec files are deleted?"_

Construct the `bd create` command with a rich description. **EXTRACT AND EMBED** specific requirements; do not just link to them.

```bash
bd create "<Verb> <Object>" \
  --parent <Epic-ID> \
  --priority <P1/P2> \
  --type task \
  --description "
**Context**
<Extract the 'Why' from proposal.md. Do not rely on links.>

**Requirements**
- <EMBED specific text of the requirement from specs/foo.md>
- <EMBED specific text of the requirement from specs/bar.md>
*(Note: Quote the relevant spec lines directly so the task stands alone.)*

**Acceptance Criteria**
- [ ] <Observable Outcome 1>
- [ ] <Observable Outcome 2>

**Design Guidance**
<Relevant design details, technical decisions, or constraints extracted from the specs>
" --json
```

### 4. Verify & Report

1. Run `bd ready` to confirm the tasks are correctly queued.
2. Report the created structure to the user.

```markdown
**Beads Implementation Ready**
Epic: `task-xyz` (<Title>)

**Created Tasks**:

- `task-abc`: <Task 1>
- `task-def`: <Task 2>
  ...
```
