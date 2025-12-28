# Requirement: Workflow Integration

The system MUST provide workflows to streamline the transition from informal design to formal specs to execution tasks.

## ADDED Requirements

### Requirement: Plan to Beads Automation

The system MUST provide a mechanism to convert a Design Document directly into Beads tasks.

#### Scenario: Direct Import

Given a design document at `docs/plans/feature.md`
When the user runs `/dat-plan-to-beads`
Then an Epic is created in Beads
And child tasks are created for each implementation step

### Requirement: Spec Refinement

The system MUST provide a tool to iteratively refine Beads tasks.

#### Scenario: Refining an Epic

Given a Beads Epic with coarse tasks
When the user runs `/dat-refine-epic`
Then the system analyzes tasks for granularity and dependencies
And proposes improvements (splits, merges, links)

### Requirement: Spec Promotion

The system MUST provide a mechanism to promote a Design Document to an OpenSpec Change.

#### Scenario: Creating a Proposal

Given a design document
When the user runs `/openspec-from-design`
Then a new OpenSpec change folder is created
And `proposal.md` and `specs/` are populated from the design

### Requirement: Beads from Spec

The system MUST provide a mechanism to create Beads tasks from a validated OpenSpec Change.

#### Scenario: executing a spec

Given a validated OpenSpec change
When the user runs `/beads-from-openspec`
Then an Epic is created linking to the Spec
And actions defined in `tasks.md` become Beads tasks
