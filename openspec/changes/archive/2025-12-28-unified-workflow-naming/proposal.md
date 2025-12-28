---
title: Unified Workflow Naming
status: proposed
---

# Unified Workflow Naming

## Problem Statement

The current `dat-` workflow namespace uses inconsistent naming conventions (`dat-bd`, `dat-w-wiki`, `dat-z-github`), causing friction in "Recall" and usage. There is no clear standard for tool naming.

## Solution

Standardize the `dat-` workflow namespace to use a **Minimalist Noun-based** convention.

- Strictly associate personal tools with their primary object/noun.
- Remove arbitrary prefixes like `w-`, `z-`.
- Use `dat-<noun>` for standard tools.
- Use `dat-<verb>-<noun>` for complex transformations.

## Risks

- **Recall Friction**: Users accustomed to old shortcuts (e.g., `dat-b2`) might need to relearn names.
- **Breaking Changes**: Scripts or other workflows referencing the old names (like `dat-bd` in `task.md`) will break if not updated.
