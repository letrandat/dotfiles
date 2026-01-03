---
description: Use when completing non-trivial work (designs, plans, implementations, tests) before declaring completion; triggers iterative multi-pass review with role-based perspectives until convergence
auto_execution_mode: 3
---

# Rule of Five: Iterative Review

## Overview

Agents produce significantly better output when reviewing their work 4-5 times before declaring completion. This creates convergence where further reviews yield diminishing returns.

**Core principle:** First-draft quality is never good enough. Systematic multi-pass review with progressive depth reaches "as good as we can make it" threshold.

## The Iron Law

**MINIMUM REVIEW PASSES BEFORE COMPLETION:**

- Small tasks (single file, <100 lines): 2-3 passes
- Large tasks (multi-file, complex logic): 4-5 passes

If you haven't completed minimum passes, you cannot declare completion.

**Violating the letter of this process is violating the spirit of iterative improvement.**

## When to Use

**ALWAYS use for:**

- Design documents and proposals
- Implementation plans (tasks.md, Beads issues)
- Code implementations (any non-trivial logic)
- Test suites (coverage and quality)
- Architecture decisions

**Skip only for:**

- Trivial changes (typos, one-liners, formatting)
- When you just need verification-before-completion (evidence check)

**Cost awareness:** This uses 4-5x more tokens than single-pass work. Quality improvement justifies the cost for non-trivial tasks.

## Role-Based Review Protocol

Each review pass adopts a different stakeholder perspective. Apply perspectives relevant to your work type.

### Engineer Perspective

**Focus:** Correctness, edge cases, performance

- Does this handle all edge cases?
- What happens with invalid input?
- Are there performance bottlenecks?
- Is error handling comprehensive?
- Does this follow language idioms?

### Tester Perspective

**Focus:** Failure modes, test coverage, edge cases

- What could break this?
- Are all code paths tested?
- Do tests actually fail when they should?
- Are edge cases covered?
- Can I write a test that breaks this?

### Designer Perspective

**Focus:** UX, accessibility, user experience (for user-facing work)

- Is this usable by target audience?
- Does this meet accessibility standards?
- Is the user flow intuitive?
- Are error messages helpful?
- Does this respect user's time/attention?

### End User Perspective

**Focus:** Usability, clarity, value delivered

- Would this solve the user's actual problem?
- Is the benefit clear and immediate?
- Is documentation understandable?
- Would I want to use this?
- Does this add unnecessary complexity?

### Architect Perspective

**Focus:** Patterns, coupling, maintainability

- Does this fit existing architecture?
- Is coupling minimal and intentional?
- Can this be maintained by others?
- Does this create technical debt?
- Are patterns consistent with codebase?

### PM/EM Perspective

**Focus:** Requirements alignment, scope, business value

- Does this meet stated requirements?
- Is scope appropriate (not over/under-engineered)?
- Does this deliver business value?
- Are there scope creep issues?
- Should this be split into smaller deliverables?

### Example: Multi-Perspective Review

Consider reviewing a login form implementation. Each perspective finds different issues:

**Engineer:** "Missing input sanitization. Password field allows paste, creating security risk. No rate limiting on submit."

**Tester:** "No test for network timeout. Edge case: what if user submits during session expiration? Missing test for special characters in username."

**Designer:** "Submit button not disabled during loading—user might double-submit. No visual feedback for password strength. Error message placement pushes form down, jarring UX."

**End User:** "Why do I need 12 characters AND special chars? Frustrating. 'Authentication failed' is cryptic—did I typo my password or is my account locked?"

**Architect:** "Hard-coded API endpoint breaks environment portability. Auth logic in component violates separation of concerns. Should use auth service."

**PM/EM:** "Requirement was 'secure login' but spec doesn't mention 2FA. Are we building the minimum or gold-plating? This adds 2 days to sprint."

**Key insight:** Same code, six different valid critiques. Single-perspective review misses 5/6 of these issues.

## Progressive Review Scope

Reviews escalate from narrow to broad concerns:

### Pass 1-2: In-the-Small (Narrow Focus)

- Code-level correctness
- Edge cases and error handling
- Basic performance issues
- Syntax and style
- Local logic flow

### Pass 3-4: In-the-Medium (Broader Concerns)

- Design patterns and consistency
- Integration with other components
- Cross-cutting concerns (logging, security)
- API design and contracts
- Testing strategy

### Pass 5: In-the-Large (Architectural)

- Fundamental approach ("Is this the Right Thing?")
- Architecture alignment
- Long-term maintainability
- Alternative approaches that might be better
- "Should we even do this this way?"

## Convergence Criteria

**You've reached convergence when:**

- Latest review finds no meaningful improvements
- Only trivial/stylistic changes suggested
- Multiple passes find nothing substantive
- You can honestly state: "This is about as good as we can make it"

**Convergence safeguards:**

- MUST complete minimum pass count (2-3 small, 4-5 large)
- MUST show progressive deepening of scope
- MUST apply multiple role perspectives
- Final pass MUST integrate with verification-before-completion

**Declare convergence:** Explicitly state "This is about as good as we can make it" before claiming completion.

## The Review Process

### Step 1: Initial Work

Complete your first-draft work (design, plan, code, tests).

### Step 2: Pass 1-2 (Narrow)

Review from Engineer and Tester perspectives. Focus in-the-small.

### Step 3: Pass 3-4 (Broader)

Review from Designer/End User (if applicable) and Architect perspectives. Focus in-the-medium.

### Step 4: Pass 5 (Architectural)

Review from PM/EM perspective. Focus in-the-large. Ask existential questions.

### Step 5: Convergence Check

- Did this pass find meaningful improvements?
- Have you completed minimum passes?
- Can you honestly say "as good as we can make it"?

If NO to any: Do another pass.
If YES to all: Declare convergence and proceed to verification-before-completion.

## Red Flags - STOP

If you catch yourself thinking:

- "First draft looks good, ship it"
- "One review is enough"
- "Reviews are finding nothing" (before minimum passes)
- "This is taking too long"
- "Skipping perspectives that don't apply" (without justification)
- "User won't notice these issues"
- Declaring completion before convergence
- Rubber-stamping passes without genuine review
- Repeating same checks in multiple passes

**ALL of these mean: Continue review process until convergence.**

## Integration Points

**REQUIRED integrations:**

- **systematic-debugging**: When reviewing implementations, check for debugging anti-patterns
- **verification-before-completion**: Final pass MUST verify with evidence (run tests, check output)
- **test-driven-development**: When reviewing tests, ensure RED-GREEN-REFACTOR cycle followed

**This workflow orchestrates:** You apply these skills during appropriate review passes. Don't duplicate their checks - reference and use them.

## Quick Reference

| Task Size | Min Passes | Focus Progression | Convergence Signal |
|-----------|------------|-------------------|-------------------|
| Small (<100 lines, 1 file) | 2-3 | Narrow → Medium | No substantive findings |
| Large (multi-file, complex) | 4-5 | Narrow → Medium → Large | "As good as we can make it" |

**Role coverage:**

- All tasks: Engineer, Tester, Architect (minimum)
- User-facing: Add Designer, End User
- Requirements-driven: Add PM/EM

**Remember:** Reviews should find DIFFERENT issues each pass. If you're finding the same type of issues, you're not escalating scope properly.
