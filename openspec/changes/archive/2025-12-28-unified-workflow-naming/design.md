# Design: Unified Workflow Naming

**Status:** Approved
**Reason:** User Request (Brainstorming Session)

## Goal

Standardize the `dat-` workflow namespace to use a **Minimalist Noun-based** convention.
This solves the "Recall" friction by strictly associating personal tools with their primary object/noun, removing arbitrary prefixes like `w-`, `z-`, or verbose formatting.

## Constraints

1. **Namespace Separation**:
   - `superpower-*`: Core system capabilities (KEEP).
   - `openspec-*`: Official spec lifecycle (KEEP: `proposal`, `apply`, `archive`).
   - `dat-*`: User-created/personal tools.
2. **Naming Convention (Hybrid)**:
   - **Legacy**: Keep established workflows as is (`hive-query`, `product-owner`, `prompter`).
   - **General**: Use **Minimalist Noun** (`dat-<noun>`) for standard tools.
   - **New/Complex**: Use **Action-First** (`dat-<verb>-<noun>`) for complex transformations.

## Proposed Renames

| Current Name           | New Name                  | Rationale                              |
| :--------------------- | :------------------------ | :------------------------------------- |
| `dat-hive-query`       | **`dat-hive-query`**      | KEEP (User Request).                   |
| `dat-product-owner`    | **`dat-product-owner`**   | KEEP (User Request).                   |
| `dat-prompter`         | **`dat-prompter`**        | KEEP (User Request).                   |
| `dat-bd`               | **`dat-beads`**           | Standard Noun.                         |
| `dat-w-wiki`           | **`dat-wiki`**            | Standard Noun.                         |
| `dat-z-github`         | **`dat-github`**          | Standard Noun.                         |
| `dat-plan-to-beads`    | **`dat-design-to-tasks`** | User Request: Explicit Source-to-Dest. |
| `openspec-from-design` | **`dat-design-to-spec`**  | User Request: Explicit Source-to-Dest. |
| `beads-from-openspec`  | **`dat-spec-to-tasks`**   | User Request: Explicit Source-to-Dest. |
| `dat-b2`               | **[DELETE]**              | Unused.                                |

## Deletions

- `dat-b2`: Unused/Deprecated.

## Migration Steps

1. Rename files in `.agent/workflows/`.
2. Update references in `task.md` or other active documents if necessary.
3. Update `dat-lego` or other meta-workflows if they reference the old names.
