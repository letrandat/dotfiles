# Spec Delta: Task Management

## MODIFIED Requirements

### Requirement: Issue Prefix Configuration

The beads task management system SHALL use `df-` as the default issue prefix for the dotfiles repository.

#### Scenario: New issue creation uses df- prefix

- **WHEN** a user creates a new issue
- **THEN** the issue ID SHALL start with `df-` (e.g., `df-abc`, `df-xyz`)

#### Scenario: Initialize with custom prefix

- **WHEN** administrator runs `bd init -p df`
- **THEN** beads SHALL initialize with `df-` as the default prefix

## ADDED Requirements

### Requirement: Local Beads Instance

The dotfiles repository SHALL maintain its own local beads instance without redirecting to external locations.

#### Scenario: Local task storage

- **WHEN** beads is initialized in the dotfiles repository
- **THEN** tasks SHALL be stored in `.beads/beads.db` within the repository
- **AND** no redirect file SHALL exist

#### Scenario: Repository-specific tasks

- **WHEN** using beads in the dotfiles repository
- **THEN** tasks SHALL use the `df-` prefix
- **AND** tasks SHALL be isolated from other repositories
