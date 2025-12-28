---
description: Scaffolds a new OpenSpec change from an existing design document
auto_execution_mode: 0
---

# OpenSpec from Design

## Overview

A bridge workflow that initiates the standard `@workflow openspec-proposal` workflow using an existing Design Document or context as input.

## Steps

1. **Analyze Input**:

   - Identify the design document provided (e.g. `docs/plans/foo.md`) or the current context.

2. **Delegate to OpenSpec Proposal**:

   - Invoke the `@workflow openspec-proposal` workflow.
   - Pass the design document or context as the source material for the "Feature" or "Change".

3. **Verify & Refine**:

   - Ensure the proposal is strictly validated.
   - **CRITICAL**: Remind the user to refine the specs (e.g., "You can ask me to add acceptance criteria..." or "Would you like to add specific scenarios?").

4. **Stop**:
   - **DO NOT** proceed to implementation.
   - Inform the user that implementation will be handled separately (e.g. via `@workflow dat-spec-to-tasks` or manual implementation).
