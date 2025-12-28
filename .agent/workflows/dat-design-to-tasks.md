---
description: Import OpenSpec design documents into Beads epics and tasks
---

# Plan to Beads

## Overview

This workflow translates OpenSpec design documents into structured Beads epics and tasks, preserving the design's structure, dependencies, and verification requirements.

## When to Use

- After completing `/superpower-brainstorming` and creating a design doc
- When you have an existing design doc that needs task tracking
- Before starting implementation on a planned feature

## The Process

### 1. Identify the Design Document

**If called after brainstorming:**

- Use the most recently created design doc in `docs/plans/`

**If called standalone:**

- Ask user for the design doc path
- Validate the file exists and is readable

### 2. Parse the Design Document

**Extract key sections:**

```
# [Title]                   → Epic title
## Problem Statement        → Epic description (context)
## Proposed Changes         → Task breakdown
  ### Component A           → Task group
    #### [MODIFY] file.js   → Individual task
    #### [NEW] file.js      → Individual task
    #### [DELETE] file.js   → Individual task
## Verification Plan        → Acceptance criteria + test tasks
  ### Automated Tests       → Task: "Write tests for X"
  ### Manual Verification   → Task: "Manual QA for X"
```

**Parsing rules:**

- Extract title from first `# ` heading
- Problem Statement becomes epic description
- Each `###` under "Proposed Changes" becomes a task group
- Each `####` becomes an individual task
- Verification Plan items become test/QA tasks

### 3. Create the Epic

```bash
bd create "Epic: [Title from design]" -p 1 --type epic --description "$(<design_description>)"
```

**Epic description format:**

```markdown
## Context

[Problem Statement from design]

## Design Document

[Link to design doc]

## Success Criteria

[From Verification Plan]
```

### 4. Create Child Tasks

**For each component/section:**

```bash
bd create "[Component Name]: [Task Title]" -p 1 --parent <epic-id> --description "$(<task_description>)"
```

**Task description format:**

```markdown
## Context

[Brief context from design]

## Scope

- [Specific files/changes from design]

## Success Criteria

- [Acceptance criteria from design]

## Related

- Design: [link to design doc section]
```

**Infer dependencies:**

- Tests depend on implementation tasks
- Controllers depend on models
- Look for explicit "depends on", "requires", "after" keywords

**Set priorities:**

- P1: Critical path tasks (blocking other work)
- P2: Parallel work (can run independently)

### 5. Output Summary

**Report to user:**

```markdown
## Created from Design: [design doc name]

**Epic**: task-xyz - [Epic Title]

**Tasks Created** (X total):

- task-abc: [Component A] Implement feature X (P1)
- task-def: [Component A] Write tests for X (P1, depends on task-abc)
- task-ghi: [Component B] Implement feature Y (P2)
  ...

**Next Steps**:

- Review tasks: `bd show task-xyz`
- Refine breakdown: `/dat-refine-epic task-xyz`
- Start work: `bd ready`
```

### 6. Offer Refinement

Ask: "Want to refine this epic breakdown? (Recommended for complex projects)"

If yes → Invoke `/dat-refine-epic <epic-id>`

## Best Practices

**Design Doc Quality:**

- Ensure design has clear "Proposed Changes" section
- Use consistent heading structure
- Include verification plan

**Task Granularity:**

- Aim for tasks that take 1-4 hours
- If a task seems too large, note it for refinement
- Group related small changes into single tasks

**Dependencies:**

- Be conservative: only add dependencies you're certain about
- User can refine dependencies in `/dat-refine-epic`

**Descriptions:**

- Always include context, scope, and success criteria
- Link back to design doc sections
- Make tasks actionable for any agent

## Example

**Input**: `docs/plans/2025-12-27-antigravity-skills-sync-design.md`

**Output**:

```
Epic: task-abc - Antigravity Skills Sync System

Tasks:
- task-abc.1: [Core] Implement unified sync script (P1)
- task-abc.2: [Core] Create plugin architecture (P1, depends on task-abc.1)
- task-abc.3: [Plugins] Implement Antigravity plugin (P1, depends on task-abc.2)
- task-abc.4: [Plugins] Implement Windsurf plugin (P1, depends on task-abc.2)
- task-abc.5: [Context] Setup context source directory (P2)
- task-abc.6: [Verification] Write automated tests (P1, depends on task-abc.3, task-abc.4)
- task-abc.7: [Verification] Manual QA verification (P2, depends on task-abc.6)
```

## After This Workflow

**Next steps:**

1. Review created tasks: `bd show <epic-id>`
2. Refine if needed: `/dat-refine-epic <epic-id>`
3. Start implementation: `bd ready` → pick a task
4. Use `/superpower-writing-plans` for detailed implementation plans

## Completion State

After successfully creating tasks, emit:

```markdown
<!-- WORKFLOW-STATE: plan-to-beads-complete -->
<!-- BEADS-EPIC: task-xyz -->
```
