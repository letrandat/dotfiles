---
description: Mid-conversation reminder to check available workflows/skills for the current situation
auto_execution_mode: 1
---

**STOP.** You may have forgotten to use available workflows. Before continuing:

1. **Check if a core workflow applies** (invoke via Cascade menu or @workflow):

   - Debugging? → `@workflow systematic-debugging`
   - Writing code? → Did you use `@workflow brainstorming` first?
   - About to claim done? → `@workflow verification-before-completion`
   - Creating tasks? → `bd` (never markdown TODOs)
   - Writing tests? → `@workflow test-driven-development`
   - Making a plan? → `@workflow writing-plans`
   - Code review? → `@workflow requesting-code-review` or `@workflow receiving-code-review`
   - Starting feature? → `@workflow using-git-worktrees`
   - Finishing work? → `@workflow finishing-a-development-branch`

2. **For specialized skills not listed above**, use openskills:

   ```bash
   openskills list
   openskills read <skill-name>
   ```

3. Apply the workflow/skill methodology and resume your work.
