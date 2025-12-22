# Windsurf Workflow State Machine Design

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Transform Windsurf's flat workflow trigger system into a sequential state machine that guides users through the complete development lifecycle.

**Architecture:** Workflows emit HTML comment markers on completion. Global rules detect these markers and proactively suggest the next logical workflow in the development cycle.

**Tech Stack:** Windsurf workflows (markdown), global_rules.md, HTML comments for state markers

---

## 1. Architecture Overview

The workflow state machine transforms Windsurf's current flat trigger system into a sequential guidance system. Instead of suggesting workflows based only on user intent, it tracks where users are in the development lifecycle and proactively suggests the next logical step.

**Core mechanism:** Workflows emit invisible state markers when they complete. The global rules file contains a state transition table that detects these markers in the conversation history and triggers targeted suggestions for the next workflow.

**Key components:**

1. **State Markers** - HTML comments emitted by workflows: `<!-- WORKFLOW-STATE: workflow-name-complete -->`
2. **Transition Table** - New section in global_rules.md mapping completed states to next-step suggestions
3. **Detection Rules** - Pattern matching logic that scans for markers and triggers suggestions
4. **Fallback System** - Original intent-based triggers remain active when no state is detected

**Benefits:** Users get guided through the complete development cycle (brainstorming → worktrees/plans → execution → verification → review → merge) without having to remember what comes next. The system remains non-blocking—suggestions are offered, never forced.

## 2. Marker Format & Detection

**Marker Format:**

Each workflow emits a standardized marker at completion:

```html
<!-- WORKFLOW-STATE: <state-name> -->
```

**State names map to workflow completion:**
- `brainstorming-complete` - Design validated and documented
- `worktree-setup-complete` - Isolated workspace ready
- `plan-complete` - Implementation plan written
- `execution-complete` - All plan tasks implemented
- `verification-complete` - Tests passing, work verified
- `code-review-complete` - Review feedback addressed
- `branch-finished` - Work merged/PR created

**Detection in global_rules.md:**

New section after the current trigger table:

```markdown
## State-Based Workflow Suggestions

When a workflow completion marker is detected, suggest the next logical step:

| Detected State | Suggested Next Workflow | Suggestion Text |
|----------------|------------------------|-----------------|
| brainstorming-complete | worktrees + writing-plans | "Design complete! Would you like me to create an isolated workspace and write the implementation plan?" |
| plan-complete | executing-plans | "Plan ready! Would you like me to execute this plan in batches with review checkpoints?" |
| execution-complete | verification-before-completion | "Implementation done! Let's verify everything works before calling it complete." |
| verification-complete | requesting-code-review | "All verified! Ready to request code review?" |
| code-review-complete | finishing-a-development-branch | "Review complete! Let's finalize this work with merge/PR/cleanup options." |
```

**Priority:** State-based suggestions take precedence over intent-based triggers. If both match, show state-based suggestion first.

## 3. State Transition Flow & Integration

**Complete State Machine Flow:**

```
START (any new feature/design work)
  ↓
[Intent: "build X"] → Suggest: brainstorming
  ↓
[State: brainstorming-complete] → Suggest: worktrees + writing-plans
  ↓
[State: worktree-setup-complete + plan-complete] → Suggest: executing-plans
  ↓
[State: execution-complete] → Suggest: verification-before-completion
  ↓
[State: verification-complete] → Suggest: requesting-code-review
  ↓
[State: code-review-complete] → Suggest: finishing-a-development-branch
  ↓
END (work merged/cleaned up)
```

**Integration with existing triggers:**

The current intent-based triggers in global_rules.md (lines 62-77) remain fully functional as "entry points." State-based suggestions layer on top:

- **Intent triggers** = Entry points (user says "build X" → suggest brainstorming)
- **State triggers** = Sequential guidance (brainstorming done → suggest worktrees/plans)

**Handling parallel paths:**

Some workflows have alternatives:
- After `plan-complete`: Suggest both `executing-plans` OR `subagent-driven-development` (let user choose)
- After any error/bug: Intent trigger for `systematic-debugging` overrides state flow temporarily

**Edge cases:**

- Multiple markers in history: Use most recent
- User skips a step: State-based doesn't trigger, intent-based takes over
- User explicitly requests different workflow: Honor request, update state

## 4. Implementation in global_rules.md

**Location:** Add new section after line 96 (after current "Superpowers Workflow Triggers" section)

**New section structure:**

```markdown
## State-Based Workflow Progression

**Priority:** State-based suggestions override intent-based when both apply.

**Detection:** Scan conversation for most recent `<!-- WORKFLOW-STATE: ... -->` marker.

### State Transition Table

| Current State | Next Suggestion | Prompt Template |
|---------------|-----------------|-----------------|
| `brainstorming-complete` | `superpowers-using-git-worktrees` + `superpowers-writing-plans` | "Design complete! Ready to set up for implementation?<br><br>I can:<br>1. Create an isolated workspace (worktree)<br>2. Write a detailed implementation plan<br><br>Would you like me to proceed?" |
| `plan-complete` | `superpowers-executing-plans` OR `superpowers-subagent-driven-development` | "Plan ready! Two execution options:<br><br>1. **Batch execution** (separate session) - executing-plans workflow<br>2. **Task-by-task** (this session) - subagent-driven-development<br><br>Which approach?" |
| `execution-complete` | `superpowers-verification-before-completion` | "Implementation complete! Before we call this done, let's verify everything works. Run the verification workflow?" |
| `verification-complete` | `superpowers-requesting-code-review` | "All tests passing! Ready to request code review before merging?" |
| `code-review-complete` | `superpowers-finishing-a-development-branch` | "Review feedback addressed! Let's finalize this work (merge/PR/cleanup)." |

### Interaction Protocol

1. Detect most recent state marker in conversation
2. Check if matching state in transition table
3. If match: Present suggestion using prompt template
4. Wait for user confirmation
5. If confirmed: Invoke suggested workflow(s)
```

**Changes to existing section:** No changes needed to lines 56-96. State-based section complements, doesn't replace.

## 5. Workflow Modifications

Each workflow in the chain needs to emit its completion marker. Here's what needs to be added:

**superpowers-brainstorming.md** (line 50, after "Use superpowers:writing-plans"):
```markdown
After completing the design documentation, emit completion state:

<!-- WORKFLOW-STATE: brainstorming-complete -->
```

**superpowers-using-git-worktrees.md** (line 214, at end):
```markdown
<!-- WORKFLOW-STATE: worktree-setup-complete -->
```

**superpowers-writing-plans.md** (line 117, after execution handoff):
```markdown
<!-- WORKFLOW-STATE: plan-complete -->
```

**superpowers-executing-plans.md** (line 50, before finishing-a-development-branch):
```markdown
<!-- WORKFLOW-STATE: execution-complete -->
```

**superpowers-verification-before-completion.md** (needs to be read first):
```markdown
<!-- WORKFLOW-STATE: verification-complete -->
```
(Add at end after all verifications pass)

**superpowers-requesting-code-review.md** (needs to be read first):
```markdown
<!-- WORKFLOW-STATE: code-review-complete -->
```
(Add after review feedback is addressed)

**superpowers-finishing-a-development-branch.md** (end of workflow):
```markdown
<!-- WORKFLOW-STATE: branch-finished -->
```

**Key principle:** Markers are emitted ONLY on successful completion, not on errors or cancellations.

## 6. Testing & Rollout

**Testing approach:**

1. **Unit test each state transition:**
   - Manually emit marker: `<!-- WORKFLOW-STATE: brainstorming-complete -->`
   - Verify Windsurf suggests correct next workflow
   - Confirm prompt text matches template

2. **Integration test full flow:**
   - Run brainstorming → worktrees → writing-plans → executing-plans → verification → code-review → finishing
   - Verify each transition triggers automatically
   - Ensure fallback to intent-based triggers works when state absent

3. **Edge case validation:**
   - Skip a workflow (brainstorming → directly request execution) - should fall back to intent triggers
   - Multiple markers in history - should use most recent
   - Error mid-workflow - marker not emitted, state doesn't advance

4. **Sync validation (REQUIRED):**
   - **After every `openskills-to-windsurf sync`**, agent MUST:
     - Review all changed workflow files
     - Verify state markers still present and correctly placed
     - Check if workflow changes break state transition flow
     - Identify if new follow-up workflows need to be added to state machine
     - Update global_rules.md state transition table if needed

**Rollout strategy:**

1. **Phase 1:** Update global_rules.md with state transition table
2. **Phase 2:** Add markers to core workflows (brainstorming, writing-plans, executing-plans)
3. **Phase 3:** Add markers to completion workflows (verification, code-review, finishing)
4. **Phase 4:** Test full cycle and iterate

**Maintenance:**

- When syncing workflows via `openskills-to-windsurf sync`, markers must be manually verified (not auto-preserved)
- Add reminder in sync script output: "⚠️  Agent: Review synced workflows for state marker integrity"
- Any new workflow in the chain needs marker added to source skill AND state transition table updated

## 7. Sync Script Enhancement

**Modification to `openskills-to-windsurf` script:**

Add post-sync reminder at end of `syncSkills()` function (after line 124):

```javascript
console.log('\n⚠️  AGENT REQUIRED: Review synced workflows for:');
console.log('   - State marker integrity (<!-- WORKFLOW-STATE: ... -->)');
console.log('   - State transition flow compatibility');
console.log('   - New workflows requiring state machine updates');
console.log('   - global_rules.md state transition table accuracy\n');
```

This ensures agents are prompted to validate the state machine after every sync operation.

---

## Implementation Checklist

- [ ] Update global_rules.md with state transition table
- [ ] Add state markers to superpowers-brainstorming.md
- [ ] Add state markers to superpowers-using-git-worktrees.md
- [ ] Add state markers to superpowers-writing-plans.md
- [ ] Add state markers to superpowers-executing-plans.md
- [ ] Read and add markers to superpowers-verification-before-completion.md
- [ ] Read and add markers to superpowers-requesting-code-review.md
- [ ] Add state markers to superpowers-finishing-a-development-branch.md
- [ ] Update openskills-to-windsurf script with agent reminder
- [ ] Test unit transitions (each state → next suggestion)
- [ ] Test full lifecycle integration
- [ ] Test edge cases (skip workflow, multiple markers, errors)
- [ ] Document state machine in windsurf-workflows-sync.md
