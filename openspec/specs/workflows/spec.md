# workflows Specification

## Purpose
TBD - created by archiving change unified-workflow-naming. Update Purpose after archive.
## Requirements
### Requirement: Namespace Standards

The system MUST enforce strict namespace separation for workflows.

- `superpower-*` for Core capabilities.
- `openspec-*` for Official lifecycle.
- `dat-*` for Personal tools.

#### Scenario: Verify Personal Namespace

Given a user workflow
When it is created
Then it MUST start with `dat-`

### Requirement: Naming Conventions

The system MUST use Minimalist Noun-based naming for standard tools.

- `dat-<noun>` (e.g. `dat-wiki`, `dat-beads`)

#### Scenario: Verify Beads Name

Given the beads workflow
When the user lists workflows
Then it MUST be named `dat-beads`
And NOT `dat-bd`

#### Scenario: Verify Wiki Name

Given the wiki workflow
When the user lists workflows
Then it MUST be named `dat-wiki`
And NOT `dat-w-wiki`

#### Scenario: Verify Github Name

Given the github workflow
When the user lists workflows
Then it MUST be named `dat-github`
And NOT `dat-z-github`

### Requirement: Action-First Naming

The system MUST use Action-First naming for complex transformations (`dat-<verb>-<noun>`).

#### Scenario: Verify Design-to-Spec

Given the design-to-spec workflow
When the user lists workflows
Then it MUST be named `dat-design-to-spec`

#### Scenario: Verify Spec-to-Tasks

Given the spec-to-tasks workflow
When the user lists workflows
Then it MUST be named `dat-spec-to-tasks`

### Requirement: Deprecations

The system MUST remove unused workflows.

#### Scenario: Verify dat-b2 deletion

Given the `dat-b2` workflow
When the migration is complete
Then the file `dat-b2.md` MUST NOT exist

