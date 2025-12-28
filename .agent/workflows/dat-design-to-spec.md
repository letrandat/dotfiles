---
description: Scaffolds a new OpenSpec change from an existing design document
---

# OpenSpec from Design

## Overview

A bridge workflow that initiates the formal OpenSpec Proposal process using an existing Design Document.
This separates the "Proposal" phase (Design -> Specs) from the "Implementation" phase.

## When to Use

- After completing `/superpower-brainstorming`
- When you have a `docs/plans/` file ready for specification
- To create a validated OpenSpec proposal

## The Process

### 1. Identify Input

**Command:** `/dat-design-to-spec <path/to/design.md>`

If no path is provided, ask the user to select from recent files in `docs/plans/`.

### 2. Instruct Agent

**Role**: You are an OpenSpec Supervisor.
**Goal**: Execute the standard OpenSpec Proposal workflow using the Design Doc as the source of truth.

**Action**:
Read the design document, then execute the following instruction:

> "Please execute the standard OpenSpec Proposal workflow (`/openspec-proposal.md`) for this design.
>
> **Source Material**: `<path/to/design.md>` > **Change ID**: `<derive-from-title>`
>
> 1. Follow the `openspec-proposal` steps strictly.
> 2. Use the Design Doc to populate the content.
> 3. Run strict validation (`openspec validate`).
> 4. **STOP** after validation and present the proposal for review."

### 3. Review & Handoff

**Report to user:**

```markdown
**OpenSpec Proposal Ready**: `openspec/changes/<id>`

- [x] Validated strict compliance
- [ ] User Review required

**Next Steps**:

1. Review the generated files.
2. Refine specs if needed.
3. When ready to implement, run: `/dat-spec-to-tasks <id>`
```
