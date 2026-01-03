# Global Rules

## Core Mandates

- **Plan & Approve**: Before starting implementation, you MUST provide a detailed implementation plan and obtain the user's explicit approval.
- Use **OpenSpec** for intent (`openspec-proposal`).
- Use **Beads** for task management (`bd`).
- Always brainstorm with `/dat-brainstorm` before coding complex features.

## Universal Workflow: Land the Plane

If I told you to "Land the Plane"" you MUST follow this ritual to prevent "session amnesia":

1. **Context Capture**: Run `bd update <id>` with a note summarizing the current logic state (e.g., "Mid-refactor of API, cursor at line 124").
2. **Quality Gates**: Run local tests/lints on **changed files only** (e.g., `pre-commit run --files <files>`). Do not run on all files. If errors exist, create a new Beads issue.
3. **State Reconciliation**: Run `bd sync`. This ensures local state matches the remote issue tracker.
