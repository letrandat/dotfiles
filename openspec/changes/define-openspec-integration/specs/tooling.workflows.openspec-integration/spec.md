## ADDED Requirements

### Requirement: Workflow Integration

The system MUST provide workflows to streamline the transition from informal design to formal specs to execution tasks.

#### Scenario: Promoting Design to Spec

Given a design document exists at `docs/plans/feature.md`
When the user runs `/openspec-from-design docs/plans/feature.md`
Then a new OpenSpec change scaffold is created at `openspec/changes/<feature-id>`
And the `proposal.md` is populated with the content from the design doc
And `tasks.md` is pre-filled with implementation steps

#### Scenario: Promoting Spec to Beads

Given a validated OpenSpec change at `openspec/changes/<feature-id>`
And `tasks.md` contains a list of implementation tasks
When the user runs `/beads-from-openspec <feature-id>`
Then a Beads Epic is created for the change
And child tasks are created for each item in `tasks.md`
And the tasks contain references to the spec change ID
