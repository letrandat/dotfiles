# Change: Optimize Rule of Five Workflow

## Why

The current "Rule of Five" prompt is verbose and contains redundant instruction for human readers (e.g., cost warnings, basic role definitions) that wastes context tokens for AI agents. However, the core "Iron Law" and role-based review logic are critical for high-quality output. We need a streamlined version that retains the psychological triggers for compliance while removing the "fat."

## What Changes

- **Optimize Prompt:** Refactor the `dat-rule-of-five` prompt to:
  - Remove "Cost Awareness" and "Integration Points".
  - Remove "Quick Reference" tables.
  - Consolidate "Review Process" and "Convergence" into a single "Execution Loop".
  - Simplify "Progressive Scope" description.
  - **Retain:** The "Iron Law" (tone), full Role Definitions (questions), and the Login Form example (few-shot).
- **Deploy to Gemini:** Create the missing `gemini/.gemini/antigravity/global_workflows/dat-rule-of-five.md`.
- **Update Existing:** Update the prompt in `.claude/commands/dat/rule-of-five.md` and `codeium/.codeium/windsurf/global_workflows/dat-rule-of-five.md`.

## Impact

- **Affected Workflows:** Rule of Five (iterative review).
- **Affected Systems:** Claude, Windsurf (Codeium), Gemini.
