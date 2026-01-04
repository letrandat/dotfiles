---
description: Use when completing non-trivial work (designs, plans, implementations, tests) before declaring completion; triggers iterative multi-pass review with role-based perspectives until convergence
---

# Rule of Five: Iterative Review

## Overview

Agents produce significantly better output when reviewing their work 4-5 times before declaring completion.

**Core principle:** First-draft quality is never good enough. Systematic multi-pass review with progressive depth reaches "as good as we can make it" threshold.

## The Iron Law

**MINIMUM REVIEW PASSES BEFORE COMPLETION:**

- Small tasks (single file, <100 lines): 2-3 passes
- Large tasks (multi-file, complex logic): 4-5 passes

If you haven't completed minimum passes, you cannot declare completion.

**Violating the letter of this process is violating the spirit of iterative improvement.**

## Role-Based Review Protocol

Each review pass adopts a different stakeholder perspective.

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

## Execution Loop

1. **Initial Work:** Complete your first draft.
2. **Pass 1-2 (Narrow):** Review with **Engineer** & **Tester** perspectives. Focus on correctness, syntax, and local logic.
3. **Pass 3-4 (Broader):** Review with **Designer** (if UX), **Architect**, & **End User** perspectives. Focus on patterns, integration, and usability.
4. **Pass 5 (Deep):** Review with **PM/EM** perspective. Ask existential questions ("Is this the right thing?").
5. **Convergence Check:**
    - Did this pass find meaningful improvements?
    - Have you completed the minimum passes?
    - Can you honestly say "This is as good as we can make it"?

**If NO:** Loop back.
**If YES:** Declare convergence and proceed to verification.

## Red Flags - STOP

If you catch yourself thinking:

- "First draft looks good, ship it"
- "One review is enough"
- "Reviews are finding nothing" (before minimum passes)
- "Skipping perspectives that don't apply" (without justification)

**ALL of these mean: Continue review process until convergence.**
