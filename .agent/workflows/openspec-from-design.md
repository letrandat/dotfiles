---
description: Scaffolds a new OpenSpec change from an existing design document
---

# OpenSpec from Design

## Overview

Promotes a natural language Design Document (from Brainstorming) into a formal OpenSpec Proposal scaffold.

## When to Use

- After completing `/superpower-brainstorming`
- When you have a `docs/plans/` file that you want to formalize
- Before starting implementation on a complex feature

## The Process

### 1. Identify Input

**Command:** `/openspec-from-design <path/to/design.md>`

If no path is provided, ask the user to select from recent files in `docs/plans/`.

### 2. Generate Scaffold

Create the change directory structure:

```bash
# Extract a short slug from the design title or filename
CHANGE_ID="<slug>"

# Create directory structure
mkdir -p "openspec/changes/$CHANGE_ID/specs"
```

### 3. Map Content (Agent Action)

Read the Design Doc and populate the OpenSpec files.

**Mapping Rules:**

- **Motivation (`proposal.md`)**:

  - Source: `## Problem Statement` / `## Overview` from Design.
  - Action: Summarize why we are doing this.

- **Design (`design.md`)**:

  - Source: Whole Design Doc.
  - Action: Copy the architectural details, diagrams, and trade-off discussions. reference the original file `docs/plans/...` as the source of truth if it's identical.

- **Specs (`specs/<change-id>/spec.md`)**:

  - Source: `## Proposed Changes` and `## Verification Plan`.
  - Action: Convert bullet points into Requirements and Scenarios.
    - _Requirement_: "The system MUST..."
    - _Scenario_: "Given... When... Then..."

- **Tasks (`tasks.md`)**:
  - Source: `## Implementation Plan` / `## Proposed Changes`.
  - Action: Create an ordered list of high-level steps.

### 4. Validation

Run `openspec validate $CHANGE_ID` to check for syntax errors.

### 5. Review

Present the generated proposal to the user for review.

```markdown
**OpenSpec Proposal Created**: `openspec/changes/<id>`

- Proposal: [Link]
- Design: [Link]
- Spec: [Link]

Run `openspec validate <id>` to check status.
```
