# OpenSpec & Beads Integration Guide

**How to plan outside Beads, then import for execution.**

## Overview

This guide explains how to use the "Plan → Import → Refine" workflow to turn detailed design documents (OpenSpec) into actionable Beads tasks.

> **Why this matters:** Design and Execution require different mindsets. Planning in a document allows for better thought structure than planning in ticket fields. Importing to Beads ensures nothing gets lost during execution.

## The Workflow

### 1. Plan (Brainstorming & Design)

Start by exploring your idea and creating a design document.

**Command:** `/superpower-brainstorming`

- engage in dialogue to refine the idea
- **Result**: A committed design doc in `docs/plans/YYYY-MM-DD-topic-design.md`

### 2. Choose Your Path

#### Path A: The "Just Do It" (Simple Features)

Skip the rigid spec formality and go straight to execution.

**Command:** `/dat-plan-to-beads`

- **Input**: Design Doc
- **Output**: Beads tasks

#### Path B: The "Strict Spec" (Complex Features / Rule of Five)

Formalize the design into an OpenSpec "Contract" first.

**Step 2a: Define**
**Command:** `/openspec-from-design`

- **Input**: Design Doc
- **Output**: OpenSpec Change Proposal (Specs, Scenarios)
- **Goal**: Run `openspec validate <id>` until passing.

**Step 2b: Execution**
**Command:** `/beads-from-openspec <change-id>`

- **Input**: Validated Change ID
- **Output**: Beads tasks linked to Specs

### 3. Refine (Iterate on Breakdown)

Review and polish the created tasks to ensure they are ready for workers.

**Command:** `/dat-refine-epic <epic-id>`

- **Goal**: Run this **up to 5 times** until the agent says "I don't think we can do much better."
- **Checks**:
  - **Granularity**: Are tasks 1-4 hours in size?
  - **Dependencies**: Are blockers correctly set?
  - **Parallelization**: Can we run tasks concurrently?
  - **Clarity**: Do tasks have "Success Criteria"?

## Cheatsheet

| Goal                    | Command                                           |
| ----------------------- | ------------------------------------------------- |
| **Start a new feature** | `/superpower-brainstorming` (follows with import) |
| **Import existing doc** | `/dat-plan-to-beads`                              |
| **Refine task list**    | `/dat-refine-epic <epic-id>`                      |
| **Start working**       | `bd ready`                                        |

## Example Scenario

1. **User**: `@[/superpower-brainstorming] I want to add a dark mode toggle.`
2. **Agent**: Helps design the feature, writes `docs/plans/...-dark-mode.md`.
3. **Agent**: "Ready to create tasks?" → **User**: "Yes".
4. **Agent**: Runs `/dat-plan-to-beads`, creates `task-dm1` (Epic).
5. **Agent**: "Want to refine?" → **User**: "Yes".
6. **Agent**: Runs `/dat-refine-epic task-dm1`. "Split 'Update CSS' into 'Variables' and 'Components'".
7. **User**: "Looks good".
8. **Agent**: Updates tasks. "Want another pass?"...
9. **User**: "No, let's build."
10. **User**: `bd ready` → Picks `task-dm1.1`.
