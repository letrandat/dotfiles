# OpenSpec-Beads Integration Design

**Date**: 2025-12-28
**Status**: Design Phase
**Author**: Agent (Collaborating with User)

## Problem Statement

The user has two powerful systems:

1. **OpenSpec** (Design Documents): Detailed planning in `docs/plans/YYYY-MM-DD-<topic>-design.md`
2. **Beads** (Task Management): Task tracking with epics, tasks, and dependencies

Currently, these systems are disconnected. The advice from Steve Yegge suggests:

> Plan outside Beads, then import. Create detailed Beads epics and issues from the plan, focusing on dependencies, detailed designs, and potential parallelization. Then iterate and refine up to 5 times.

**Goal**: Create workflows that bridge OpenSpec → Beads seamlessly, enabling agents to translate designs into actionable task hierarchies.

---

## Use Cases

### Use Case 1: New Feature Development

**Scenario**: User has a new feature idea

**Current Flow**:

1. `/superpower-brainstorming` → Creates design doc
2. Manual step: User/agent creates Beads tasks
3. Implementation begins

**Desired Flow**:

1. `/superpower-brainstorming` → Creates design doc
2. **NEW**: `/dat-plan-to-beads` → Auto-generates epic + tasks from design
3. **NEW**: `/dat-refine-epic` → Iterates on task breakdown (up to 5x)
4. Implementation begins with clear task hierarchy

### Use Case 2: Existing Design Needs Tasks

**Scenario**: User has an existing design doc but no Beads tasks

**Desired Flow**:

1. User points to design doc: `@docs/plans/2025-12-27-antigravity-skills-sync-design.md`
2. `/dat-plan-to-beads` → Generates epic + tasks
3. `/dat-refine-epic` → Refines breakdown

### Use Case 3: Epic Refinement

**Scenario**: Beads epic exists but tasks are too coarse

**Desired Flow**:

1. `/dat-refine-epic task-ab6` → Agent analyzes epic
2. Agent proposes refined task breakdown
3. User approves → Agent updates Beads

### Use Case 4: End-to-End Planning

**Scenario**: Complex multi-phase project

**Desired Flow**:

1. `/superpower-brainstorming` → Design doc (Phase 1)
2. `/dat-plan-to-beads` → Epic + high-level tasks
3. `/dat-refine-epic` → Iterate 5x on breakdown
4. `/dat-refine-epic` → Iterate 5x on dependencies
5. Implementation begins with battle-tested plan

---

## Proposed Workflows

### Workflow 1: `/dat-plan-to-beads`

**Purpose**: Import OpenSpec design → Beads epic + tasks

**Input**:

- Design doc path (e.g., `docs/plans/2025-12-27-antigravity-skills-sync-design.md`)
- OR current brainstorming session (if called after `/superpower-brainstorming`)

**Process**:

1. Parse design doc sections:
   - Problem Statement → Epic description
   - Proposed Changes → Task breakdown
   - Verification Plan → Acceptance criteria
2. Create Beads epic with rich description
3. Create child tasks with:
   - Detailed descriptions (context, scope, success criteria)
   - Dependencies (inferred from design)
   - Priority (P1 for critical path, P2 for parallel work)
4. Output summary of created tasks

**Output**: Epic ID + list of task IDs

---

### Workflow 2: `/dat-refine-epic`

**Purpose**: Iteratively refine Beads epic breakdown

**Input**: Epic ID (e.g., `task-ab6`)

**Process**:

1. Fetch epic + all child tasks
2. Analyze for:
   - **Granularity**: Are tasks too large? Too small?
   - **Dependencies**: Are dependencies clear and correct?
   - **Parallelization**: Can tasks run in parallel?
   - **Completeness**: Missing tasks? Edge cases?
   - **Clarity**: Are descriptions detailed enough?
3. Propose refinements:
   - Split large tasks
   - Merge tiny tasks
   - Add missing tasks
   - Clarify dependencies
   - Improve descriptions
4. User approves → Agent updates Beads
5. Repeat up to 5 times (or until agent says "can't improve further")

**Output**: Updated epic with refined tasks

---

### Workflow 3: Enhanced `/superpower-brainstorming`

**Purpose**: Add Beads integration to existing brainstorming workflow

**Changes**:

- **After design doc is created and committed**:
  - Ask: "Ready to create Beads tasks from this design?"
  - If yes → Invoke `/dat-plan-to-beads` automatically
  - Then ask: "Want to refine the epic breakdown?"
  - If yes → Invoke `/dat-refine-epic` iteratively

**New completion state**:

```markdown
<!-- WORKFLOW-STATE: brainstorming-complete -->
<!-- BEADS-EPIC: task-xyz -->
```

---

## Architecture

### Design Doc Parsing Strategy

**Section Mapping**:

```
Design Doc Section          → Beads Field
─────────────────────────────────────────
# [Title]                   → Epic title
## Problem Statement        → Epic description (context)
## Proposed Changes         → Task breakdown
  ### Component A           → Task group (or sub-epic)
    #### File X             → Individual task
## Verification Plan        → Acceptance criteria
  ### Automated Tests       → Task: "Write tests for X"
  ### Manual Verification   → Task: "Manual QA for X"
```

### Dependency Detection

**Heuristics**:

1. **Explicit**: "depends on", "requires", "after"
2. **Implicit**: File dependencies (e.g., model before controller)
3. **Logical**: Tests depend on implementation

**Representation**:

```bash
bd create "Implement auth middleware" -p 1 --depends-on task-abc
```

### Iteration Strategy

**Refinement Loop** (up to 5 iterations):

1. **Iteration 1**: Granularity check (split/merge tasks)
2. **Iteration 2**: Dependency validation
3. **Iteration 3**: Parallelization opportunities
4. **Iteration 4**: Edge case coverage
5. **Iteration 5**: Final polish (descriptions, acceptance criteria)

**Exit Condition**: Agent determines no further improvements possible

---

## Implementation Plan

### Phase 1: Core Workflows

- [ ] Create `/dat-plan-to-beads` workflow
- [ ] Create `/dat-refine-epic` workflow
- [ ] Test with existing design doc

### Phase 2: Brainstorming Integration

- [ ] Enhance `/superpower-brainstorming` with Beads integration
- [ ] Add workflow state markers

### Phase 3: Documentation

- [ ] Create usage guide: `docs/openspec-beads-integration.md`
- [ ] Add examples for each use case
- [ ] Document best practices

---

## Verification Plan

### Manual Testing

1. **Test `/dat-plan-to-beads`**:

   - Input: `docs/plans/2025-12-27-antigravity-skills-sync-design.md`
   - Expected: Epic created with 5-10 child tasks
   - Verify: Task descriptions are detailed, dependencies are correct

2. **Test `/dat-refine-epic`**:

   - Input: Epic from step 1
   - Expected: Agent proposes refinements
   - Verify: Refinements improve clarity/granularity

3. **Test Enhanced Brainstorming**:
   - Run full brainstorming session
   - Expected: Design doc + Beads epic created
   - Verify: Seamless flow from design → tasks

### Success Criteria

- [ ] All 3 workflows execute without errors
- [ ] Generated tasks have rich descriptions (context, scope, success criteria)
- [ ] Dependencies are correctly inferred
- [ ] Refinement loop improves task quality
- [ ] Documentation is clear and complete

---

## Open Questions

1. **Epic vs Task Hierarchy**: Should we support sub-epics for large projects?
2. **Auto-close**: Should refined tasks auto-close the "refine epic" meta-task?
3. **Design Doc Format**: Should we enforce a specific template for easier parsing?
4. **Beads API**: Does Beads support bulk operations (create multiple tasks at once)?

---

## Next Steps

1. Review this design with user
2. Create implementation plan for workflows
3. Build `/dat-plan-to-beads` first (highest value)
4. Iterate based on user feedback
