# Spec: Workflow Migration Parity

## ADDED Requirements

### Requirement: File Parity and Naming

The system SHALL ensure that every workflow file in `.agent/workflows` has a corresponding file in `codeium/.codeium/windsurf/global_workflows/`.

#### Scenario: Unified Naming

Given a file named `dat-wiki.md` exists in Antigravity
When checking Windsurf workflows
Then the file SHALL be named `dat-wiki.md`, NOT `dat-w-wiki.md` or other prefixed variations.

### Requirement: Content Transformation

The system SHALL transform the content of migrated workflows to be compatible with the Windsurf environment.

#### Scenario: Syntax Adaptation

Given a workflow containing Antigravity slash commands (e.g., `/superpower-brainstorming`)
When migrating to Windsurf
Then the syntax SHALL be converted to Windsurf workflow mentions (e.g., `@workflow superpowers-brainstorming` or `@workflow <name>`).

#### Scenario: Frontmatter Injection

Given an Antigravity workflow
When migrating to Windsurf
Then the file SHALL include `auto_execution_mode: 0` in the YAML frontmatter.

### Requirement: Standardized Beads Workflow

The system SHALL ensure that the `dat-beads.md` and `dat-bd.md` workflows both reflect the same "Auto-Close Policy" as defined in the global rules.

#### Scenario: Policy Parity

Given the `dat-beads.md` and `dat-bd.md` workflows exist
When comparing their "Auto-Close Policy" or "Task Completion Policy" sections
Then they should both require reporting completion to the user.
