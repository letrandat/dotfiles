# skills Specification

## Purpose

Defines agent skill capabilities for systematic iterative review patterns. Skills provide reusable review protocols that agents invoke to improve output quality through multi-pass examination with role-based perspectives and progressive scope escalation.
## Requirements
### Requirement: Rule of Five Iterative Review

The system SHALL provide a Rule of Five skill that enforces systematic multi-pass review of agent work to achieve convergent quality before claiming completion.

#### Scenario: Small Task Review

- **WHEN** agent completes a small task (single file, <100 lines, straightforward scope)
- **THEN** agent MUST perform 2-3 review passes before claiming completion
- **AND** each review MUST progressively broaden scope
- **AND** agent MUST continue until declaring "this is about as good as we can make it"

#### Scenario: Large Task Review

- **WHEN** agent completes a large task (multi-file, complex logic, architectural changes)
- **THEN** agent MUST perform 4-5 review passes before claiming completion
- **AND** reviews MUST include: narrow code review, broader code review, architectural review
- **AND** agent MUST continue until reaching convergence

#### Scenario: Design Phase Review

- **WHEN** agent creates a design or proposal
- **THEN** agent MUST perform 5 review passes on the design
- **AND** final review MUST ask existential questions about whether this is the Right Thing
- **AND** agent MUST not proceed to implementation until design has converged

#### Scenario: Implementation Plan Review

- **WHEN** agent creates an implementation plan (tasks.md, Beads issues)
- **THEN** agent MUST perform 5 review passes on the plan
- **AND** reviews MUST verify task ordering, dependencies, completeness
- **AND** agent MUST refine plan until it converges

#### Scenario: Implementation Code Review

- **WHEN** agent writes code implementation
- **THEN** agent MUST perform at minimum: initial code generation + 4 review passes
- **AND** reviews MUST check: correctness, edge cases, error handling, style, architecture
- **AND** agent MUST integrate with verification-before-completion skill for final validation

#### Scenario: Test Review

- **WHEN** agent writes tests
- **THEN** agent MUST perform 5 review passes on test coverage and quality
- **AND** reviews MUST verify: test completeness, edge cases, failure scenarios, clarity
- **AND** agent MUST ensure tests actually fail when they should (red-green verification)

#### Scenario: Progressive Review Scope

- **WHEN** performing multi-pass reviews
- **THEN** first 1-2 reviews MUST focus in-the-small (code quality, correctness)
- **AND** reviews 3-4 MUST focus on broader concerns (patterns, integration, design)
- **AND** final review MUST focus in-the-large (architecture, right approach, fundamental questions)

#### Scenario: Role-Based Review Perspectives

- **WHEN** performing review passes
- **THEN** agent MUST take on different reviewer perspectives across passes
- **AND** perspectives MUST include: engineer, tester, designer, end user, architect, PM/EM (as applicable)
- **AND** each perspective MUST examine work from that role's concerns and priorities
- **AND** engineer perspective MUST check correctness, edge cases, performance
- **AND** tester perspective MUST check failure modes, test coverage, edge cases
- **AND** designer perspective MUST check UX, accessibility, user experience (for user-facing work)
- **AND** end user perspective MUST check usability, clarity, value
- **AND** architect perspective MUST check patterns, coupling, maintainability
- **AND** PM/EM perspective MUST check requirements alignment, scope, business value

#### Scenario: Convergence Detection

- **WHEN** agent performs review passes
- **THEN** agent MUST track diminishing returns across passes
- **AND** agent MUST declare convergence when review finds no meaningful improvements
- **AND** convergence MUST NOT occur before minimum pass count (2-3 for small, 4-5 for large)
- **AND** agent MUST explicitly state "this is about as good as we can make it" at convergence

#### Scenario: Integration with Existing Skills

- **WHEN** using rule-of-five skill
- **THEN** it MUST integrate with systematic-debugging for implementation reviews
- **AND** it MUST integrate with verification-before-completion for final validation
- **AND** it MUST integrate with test-driven-development for test quality reviews
- **AND** it MUST NOT duplicate checks performed by other skills

### Requirement: Automated Review Protocol

The system SHALL provide structured review protocols that guide agents through progressive review passes.

#### Scenario: Review Protocol Structure

- **WHEN** agent invokes rule-of-five skill
- **THEN** system MUST provide clear protocol for each review pass number
- **AND** protocol MUST specify what to look for in that pass
- **AND** protocol MUST escalate from narrow to broad concerns

#### Scenario: Review Documentation

- **WHEN** agent completes reviews
- **THEN** agent MAY document key findings from each pass
- **AND** agent MUST NOT clutter output with redundant review commentary
- **AND** final state after convergence MUST be clean, polished output

### Requirement: Review Quality Standards

The system SHALL define what constitutes a proper review pass.

#### Scenario: Genuine Review

- **WHEN** performing a review pass
- **THEN** agent MUST actively look for issues, not just re-read
- **AND** agent MUST check different aspects in each pass (not repeat same checks)
- **AND** agent MUST apply increasingly critical lens in later passes

