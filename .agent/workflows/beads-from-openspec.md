---
description: Import an OpenSpec change into Beads tasks
---

# Beads from OpenSpec

## Overview

Converts a VALIDATED OpenSpec change into actionable Beads tasks. This is the Execution phase of the "Funnel".

## When to Use

- After an OpenSpec change has been successfully validated (`openspec validate <id>` returns success)
- When you are ready to start coding
- To transition from Planning (OpenSpec) to Execution (Beads)

## The Process

### 1. Identify Input

**Command:** `/beads-from-openspec <change-id>`

- **Validation Check**: Run `openspec validate <change-id> --strict`. If it fails, abort and ask user to fix specs first.

### 2. Parse OpenSpec Data

Read the files in `openspec/changes/<change-id>/`:

- `proposal.md`: Sources the Epic Description.
- `tasks.md`: Sources the list of implementation tasks.
- `specs/*/*.md`: Used for reference links.

### 3. Create Beads Epic

Create a parent Epic to track the entire change.

```bash
# Epic Title: "[Prop] <Title from proposal>"
# Description: Motivation + Links to Spec

bd create "Epic: <Title>" --type epic --description "..."
```

**Description Template**:

```markdown
## Context

(Content from Proposal Motivation)

## Specs

- Proposal: [Link]
- Design: [Link]
- Change ID: <change-id>
```

### 4. Create Child Tasks

Iterate through `tasks.md`. For each line item:

1.  **Create Task**:
    `bd create "<Item Text>" --parent <epic-id>`

2.  **Enrich Description**:
    Add a link to the relevant Spec Requirement if detected.

3.  **Set Dependencies** (Optional but recommended):
    If the task list is numbered 1..N, assume Task N depends on Task N-1?
    _Decision_: No, strictly sequential dependency is often wrong. Create them as independent tasks under the Epic unless explicit dependencies are noted.

### 5. Completion

Report to user:

```markdown
**Beads Epic Created**: `task-xyz`

- [x] Validated OpenSpec change `<change-id>`
- [x] Created Epic `task-xyz`
- [x] Created N child tasks

**Next Step**:
Run `/dat-refine-epic task-xyz` to polish the task details before starting work.
```
