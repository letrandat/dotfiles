## ADDED Requirements

### Requirement: Antigravity Workflow Consolidation

The system SHALL consolidate all Antigravity workflows in the gemini stow package location.

#### Scenario: All Workflows in Gemini Package

- **WHEN** checking Antigravity workflow locations
- **THEN** all 21 workflows MUST be in `gemini/.gemini/antigravity/global_workflow/`
- **AND** they MUST be stowed to `~/.gemini/antigravity/global_workflow/`
- **AND** `.agent/workflows/` directory MUST NOT exist
- **AND** workflows include: 15 dat-*.md, 3 openspec-*.md, git-worktree.md, sample_workflow.md, superpower-brainstorming.md

#### Scenario: Git History Preserved During Migration

- **WHEN** workflows are moved from `.agent/workflows/` to `gemini/.gemini/antigravity/global_workflow/`
- **THEN** git history MUST be preserved using `git mv` command
- **AND** `git log --follow` MUST show complete history for moved files

### Requirement: Remove Workflow Sync Automation

The system SHALL NOT include automated workflow sync scripts.

#### Scenario: Sync Scripts Removed

- **WHEN** checking bin/.local/dotfiles-bin/
- **THEN** `superpowers-sync` MUST NOT exist
- **AND** `claude-plugins-sync` MUST NOT exist
- **AND** documentation references to sync scripts MUST be removed

#### Scenario: Manual Workflow Management

- **WHEN** workflows need to be synced between locations
- **THEN** manual file copying SHALL be used
- **AND** no automated sync mechanism SHALL be provided

### Requirement: AskUserQuestion Pattern Documentation

The brainstorming workflow SHALL document the AskUserQuestion pattern for reuse across AI agents.

#### Scenario: Pattern Structure Documented

- **WHEN** reading superpower-brainstorming.md
- **THEN** it MUST include a section titled "Using Structured Questions (AskUserQuestion Pattern)"
- **AND** it MUST explain the pattern components: header, multiSelect, options with label/description
- **AND** it MUST include concrete examples from real usage

#### Scenario: Meta-Example from This Proposal

- **WHEN** the AskUserQuestion pattern section is reviewed
- **THEN** it MUST include at least one example from the interview process for this proposal
- **AND** the example MUST show question, header, options with labels and descriptions
- **AND** it MUST explain WHY the pattern works (categorization, clarity, efficiency)

### Requirement: Natural Conversation Flow in Brainstorming

The brainstorming workflow SHALL NOT restrict question quantity for efficiency.

#### Scenario: No Question Quantity Restrictions

- **WHEN** using the brainstorming workflow
- **THEN** it MUST NOT include "ask questions one at a time" guidance
- **AND** it MUST NOT include "only one question per message" restrictions
- **AND** it MUST NOT include "One question at a time" in Key Principles
- **AND** it MUST allow asking multiple questions when contextually appropriate

#### Scenario: Quality Over Quantity Guidance Retained

- **WHEN** reviewing brainstorming workflow guidance
- **THEN** it MUST keep "prefer multiple choice" guidance
- **AND** it MUST keep other quality-focused guidance unchanged
- **AND** auto_execution_mode MUST remain 0 (manual invocation)

### Requirement: Windsurf Workflow Independence

Windsurf workflows SHALL remain completely independent from Antigravity workflow reorganization.

#### Scenario: No Windsurf Changes

- **WHEN** implementing workflow reorganization
- **THEN** `codeium/.codeium/windsurf/global_workflows/` MUST NOT be modified
- **AND** Windsurf workflows MUST remain in their current location
- **AND** no Windsurf workflow content MUST be changed

#### Scenario: Windsurf Independence Verification

- **WHEN** validating the implementation
- **THEN** `git status codeium/.codeium/windsurf/global_workflows/` MUST show no changes
- **AND** Windsurf workflow management MUST remain separate from Antigravity

### Requirement: Package Management Separation

The system SHALL separate workflow management from settings management for Antigravity.

#### Scenario: Antigravity Package for Settings Only

- **WHEN** checking the antigravity stow package
- **THEN** it MUST contain settings.json and keybindings.json
- **AND** it MUST NOT contain workflows
- **AND** it MUST remain in the PACKAGES list in setup.sh

#### Scenario: No Application Support Symlink for Antigravity

- **WHEN** checking setup.sh
- **THEN** `link_app_support "Antigravity" "Antigravity"` MUST NOT exist
- **AND** cleanup_legacy for Antigravity settings/keybindings MUST NOT exist
- **AND** Antigravity settings SHALL be managed by stow without Application Support rewrite

## MODIFIED Requirements

### Requirement: Deprecations

The system MUST remove unused workflows, deprecated workflow restrictions, and unused automation scripts.

#### Scenario: Verify dat-b2 deletion

Given the `dat-b2` workflow
When the migration is complete
Then the file `dat-b2.md` MUST NOT exist

#### Scenario: Remove Unused Superpower Workflows from Antigravity

- **WHEN** cleaning up Antigravity workflows
- **THEN** all 12 unused `superpower-*.md` files MUST be removed from `.agent/workflows/`
- **AND** only `superpower-brainstorming.md` SHALL be moved to gemini package
- **AND** `.agent/workflows/` directory SHALL be deleted entirely

#### Scenario: Remove Sync Automation Scripts

- **WHEN** cleaning up automation
- **THEN** `bin/.local/dotfiles-bin/superpowers-sync` MUST be deleted
- **AND** `bin/.local/dotfiles-bin/claude-plugins-sync` MUST be deleted
- **AND** all documentation references to these scripts MUST be removed

#### Scenario: Remove Unused Antigravity Workflows

- **WHEN** cleaning up Antigravity workflow directories
- **THEN** `~/.gemini/antigravity/global_workflows/rewrite.md` MUST be deleted
- **AND** all workflows from `.agent/workflows/` MUST be moved to gemini package
- **AND** no workflows SHALL remain in `.agent/workflows/` before directory deletion

## REMOVED Requirements

None - no existing requirements are being completely removed, only modified or deprecated.
