# prompts Specification

## Purpose

TBD - created by archiving change optimize-rule-of-five. Update Purpose after archive.

## Requirements

### Requirement: Optimized Rule of Five Prompt

The system SHALL use the following optimized prompt for the "Rule of Five" workflow.

#### Scenario: Prompt Content

- **WHEN** the `dat-rule-of-five` command is invoked
- **THEN** the system uses the following prompt content:

```markdown
---
description: Use when completing non-trivial work (designs, plans, implementations, tests) before declaring completion; triggers iterative multi-pass review with role-based perspectives until convergence
---

# Rule of Five: Iterative Review
