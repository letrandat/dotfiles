# Proposal: Allow Safe Shell Commands without Confirmation

## Problem

The Gemini CLI currently requires user confirmation for all shell commands. This creates unnecessary friction for common, safe, read-only operations like listing files (`ls`) or checking git status (`git status`), which are frequent in the development workflow.

## Solution

Configure the Gemini CLI's `autoApprovedTools` setting to automatically allow a specific set of "safe" commands. This will be implemented by adding a `.gemini/settings.json` file to the project root.

## Impact

- **Productivity**: Reduces interruptions during standard exploration and status check tasks.
- **Safety**: "Dangerous" commands (e.g., `rm`, `git push`) will still require confirmation.
- **Scope**: Affects only the local project environment.
