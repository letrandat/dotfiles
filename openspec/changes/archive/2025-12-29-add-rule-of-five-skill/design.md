# Design: Rule of Five Iterative Review

## Context

Jeffrey Emanuel's "Rule of Five" research shows that agents produce significantly better output when reviewing their work 4-5 times before declaring completion. This counterintuitive pattern creates convergence where further reviews yield diminishing returns.

**Current state:**

- Agents produce first-draft quality output
- Users must manually review and iterate multiple times
- Quality gaps emerge in designs, plans, implementations, and tests
- No systematic enforcement of iterative review

**Constraints:**

- Must work across three agent platforms: Claude Code, Windsurf, Antigravity
- Must integrate with existing skills (systematic-debugging, verification-before-completion, TDD)
- Must avoid becoming a "checkbox ritual" where agents rubber-stamp without genuine review
- Must balance cost (4-5x token usage) against quality improvement

**Stakeholders:**

- User (this dotfiles repo owner) - needs consistent quality across all agents
- Future agents - need clear guidance on when/how to apply iterative review
- Existing skills ecosystem - must integrate without duplication

## Goals / Non-Goals

**Goals:**

- Provide systematic review protocol agents can apply autonomously
- Define clear convergence criteria ("as good as we can make it")
- Progressive review scope (narrow → broad → architectural)
- Cross-platform availability (Claude Code, Windsurf, Antigravity)
- Integration with existing quality skills

**Non-Goals:**

- Forcing 5 passes on trivial tasks (typos, one-liners)
- Replacing verification-before-completion (different purpose: evidence vs. review)
- Automating review quality assessment (requires human judgment)
- Optimizing token cost (quality over cost in this case)

## Decisions

### Decision 1: Multi-Platform Distribution Strategy

**Chosen approach:** Create native formats directly for each platform (no openskill intermediary)

1. **Claude Code native** (`~/.claude/skills/dat-rule-of-five/SKILL.md`):
   - Directly loaded by Claude Code
   - Invoked via `/dat-rule-of-five`
   - Source of truth for skill content

2. **Windsurf workflow** (`codeium/.codeium/windsurf/global_workflows/dat-rule-of-five.md`):
   - Native Windsurf global workflow
   - Deployed via stow (codeium package)
   - Adapted from Claude Code skill content

3. **Antigravity workflow** (`.agent/workflows/dat-rule-of-five.md`):
   - Native Antigravity workflow format
   - Created directly (not synced from openskill)
   - Adapted from Claude Code skill content

**Why:** Each platform has different skill/workflow loading mechanisms. Creating native formats directly is simpler than maintaining an openskill that syncs to Windsurf. Claude Code skill becomes the source of truth, and we manually adapt content for Windsurf and Antigravity workflows. For personal dotfiles, manual replication is acceptable and keeps things simple.

**Alternatives considered:**

- *Openskill + sync approach:* Over-engineering; adds unnecessary complexity for personal use
- *Single platform only:* Would limit availability across the user's three agent platforms
- *Automated sync tooling:* Not worth building for personal dotfiles; manual copy-paste is fine

### Decision 2: Personal Namespace (`dat-` prefix)

**Chosen approach:** Use `dat-rule-of-five` naming following personal namespace convention

**Why:**

- Per workflows spec, `dat-*` prefix is for personal tools
- `superpower-*` prefix is for core capabilities
- Rule of Five is based on external research (Jeffrey Emanuel), not official core capability
- Being implemented in personal dotfiles repo as personal customization

**Alternatives considered:**

- *`superpowers:rule-of-five`:* Incorrect namespace; not a core superpower
- *`rule-of-five` without prefix:* Violates naming conventions in workflows spec

### Decision 3: Progressive Review Protocol with Role-Based Perspectives

**Chosen approach:** Combine progressive scope escalation with role-based reviewer perspectives

**Progressive scope:**

1. **Pass 1-2 (Narrow):** Code-level correctness, edge cases, basic errors
2. **Pass 3-4 (Broader):** Design patterns, integration concerns, coupling
3. **Pass 5 (Architectural):** Existential questions, "is this the Right Thing?"

**Role-based perspectives** (agent takes on different roles across passes):

- **Engineer:** Correctness, edge cases, performance
- **Tester:** Failure modes, test coverage, edge cases
- **Designer:** UX, accessibility, user experience (for user-facing work)
- **End User:** Usability, clarity, value delivered
- **Architect:** Patterns, coupling, maintainability
- **PM/EM:** Requirements alignment, scope, business value

**Why:** Jeffrey's research shows each pass naturally finds different types of issues. Adding role-based perspectives ensures comprehensive coverage - the agent examines work from multiple stakeholder viewpoints, catching issues that a single perspective might miss. For example, code that's correct from an engineer's perspective might have poor UX from an end user's perspective.

**Alternatives considered:**

- *Progressive scope only:* Would miss perspective-specific issues (e.g., accessibility, business value)
- *Role-based only:* Would miss the narrow→broad→architectural progression
- *Unstructured "review 5 times":* Agents would review same aspects repeatedly
- *Fixed role-to-pass mapping:* Too rigid; better to let agent choose appropriate perspectives for the work type

### Decision 4: Convergence Criteria

**Chosen approach:** Agent declares convergence when review finds no meaningful improvements AND minimum pass count met

**Indicators of convergence:**

- Agent states "this is about as good as we can make it"
- Last review found only trivial/stylistic improvements
- Multiple review passes finding nothing substantive

**Safeguards against false convergence:**

- Minimum pass count enforced (2-3 for small, 4-5 for large)
- Reviews must show progressive deepening of scope
- Integration with verification-before-completion for final evidence check

**Why:** Jeffrey's research shows convergence typically occurs at 4-5 iterations. Defining this explicitly prevents both premature stopping and endless iteration.

**Alternatives considered:**

- *Fixed 5 passes always:* Wasteful for tasks that converge earlier or diverge
- *User-defined pass count:* Adds complexity without clear benefit
- *No convergence detection:* Risk of endless iteration or premature stopping

### Decision 5: Integration vs. Duplication

**Chosen approach:** Rule of Five focuses on *iterative refinement*, existing skills focus on *specific quality checks*

**Delineation:**

- **Rule of Five:** Framework for multiple review passes with progressive scope
- **verification-before-completion:** Evidence-based validation (run tests, check output)
- **systematic-debugging:** Root cause investigation protocol
- **test-driven-development:** RED-GREEN-REFACTOR cycle

**Integration points:**

- Rule of Five *uses* verification-before-completion in final pass (verify evidence)
- Rule of Five *uses* systematic-debugging when reviewing implementation (check for debug patterns)
- Rule of Five *applies to* TDD-created tests (review test quality in 5 passes)

**Why:** Each skill has distinct purpose. Rule of Five is meta-skill that orchestrates application of others during iterative review.

**Alternatives considered:**

- *Merge with verification-before-completion:* Different concerns (review vs. evidence)
- *Separate skills per review type:* Over-fragmentation, loses progression pattern
- *Replace existing skills:* They serve different purposes, not replacements

## Risks / Trade-offs

### Risk 1: Rubber-Stamp Reviews

**Risk:** Agents claim "reviewed 5 times" but superficially without genuine critical analysis

**Mitigation:**

- Explicit "Red Flags" section warning against superficial reviews
- Require reviews to find different types of issues (prove progressive depth)
- "Common Rationalizations" table addressing "looks good" shortcuts
- Skill design follows `writing-skills` guidance on bulletproofing against rationalization

**Residual risk:** Agent rationalization is sophisticated; may find new loopholes

### Risk 2: Token Cost

**Risk:** 4-5x review passes significantly increases token usage per task

**Mitigation:**

- Scope reviews to non-trivial tasks only (guidance in skill)
- Accept cost as tradeoff for quality (stated in design)
- Users can opt-out by not invoking skill explicitly

**Residual risk:** Auto-application could surprise users with costs; make invocation explicit

### Risk 3: Cross-Platform Content Drift

**Risk:** Three separate implementations (Claude Code skill, Windsurf workflow, Antigravity workflow) diverge over time

**Mitigation:**

- Claude Code skill is source of truth (documented in design)
- Update checklist includes all three formats (tasks.md)
- Content should be manually replicated across platforms
- Test all three platforms after changes (documented in tasks.md section 7)

**Residual risk:** Manual replication process can be forgotten; accept this for personal dotfiles (simplicity over automation)

### Risk 4: Skill Testing Gap

**Risk:** Following `writing-skills` TDD approach, we need pressure scenarios to test this skill, but scope is large

**Mitigation:**

- Phase 1: Deploy minimal skill without full TDD cycle (document as technical debt)
- Phase 2: Create pressure scenarios after observing real usage
- Phase 3: Iterate based on actual rationalization patterns observed

**Justification:** Rule of Five itself is complex; bootstrapping with limited testing acceptable for personal use

**Residual risk:** Untested skill may have loopholes; accept and iterate

## Migration Plan

**No migration needed** - this is a new skill, no existing behavior to migrate from

**Deployment sequence:**

1. Create Claude Code skill in `~/.claude/skills/dat-rule-of-five/SKILL.md`
2. Create Windsurf workflow in `codeium/.codeium/windsurf/global_workflows/dat-rule-of-five.md`
3. Create Antigravity workflow in `.agent/workflows/dat-rule-of-five.md`
4. Run `stow -R codeium` to deploy Windsurf workflow
5. Test invocation on small task in each platform
6. Document findings and iterate

**Rollback:** Delete skill files, revert commits. No system dependencies.

## Open Questions

**All questions resolved during implementation:**

1. **Should this skill auto-apply or require explicit invocation?**
   - **RESOLVED**: Explicit invocation (`/dat-rule-of-five`) - user controls when to apply the intensive review process

2. **How to measure convergence quantitatively?**
   - **RESOLVED**: Qualitative approach ("no meaningful improvements") - quantitative metrics add complexity without clear benefit

3. **Should review protocols be inline or separate file?**
   - **RESOLVED**: Inline in SKILL.md - all protocols embedded in single file for token efficiency and ease of use

4. **What's the right balance between completeness and token efficiency?**
   - **RESOLVED**: Accept higher token count (~1200 words) for thoroughness - this is a complex meta-skill that requires comprehensive guidance

## Implementation Notes

**Critical path:**

1. Write Claude Code skill following `writing-skills` checklist format
2. Test on one small task manually (verify 2-3 passes work)
3. Test on one large task manually (verify 4-5 passes work)
4. Create Windsurf and Antigravity workflow adaptations
5. Archive change and document learnings

**Quality checks before archiving:**

- Markdown lint passes (`markdownlint-cli2`)
- OpenSpec validation passes (`openspec validate --strict`)
- Manual testing shows progressive review depth
- Integration with verification-before-completion works
