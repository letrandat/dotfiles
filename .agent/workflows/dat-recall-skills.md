---
description: Mid-conversation reminder to check available workflows/skills for the current situation
---

**STOP.** You may have forgotten to use available workflows. Before continuing:

1. **Check if a core workflow applies** (invoke via Cascade menu or @workflow):

   - Starting session? → `@workflow superpowers-using-superpowers`
   - New feature/design? → `@workflow superpowers-brainstorming`
   - Debugging? → `@workflow superpowers-systematic-debugging`
   - Writing code? → `@workflow superpowers-test-driven-development`
   - About to claim done? → `@workflow superpowers-verification-before-completion`
   - Making a plan? → `@workflow superpowers-writing-plans`
   - Executing plan (parallel)? → `@workflow superpowers-executing-plans`
   - Executing plan (current session)? → `@workflow superpowers-subagent-driven-development`
   - 2+ independent tasks? → `@workflow superpowers-dispatching-parallel-agents`
   - Code review? → `@workflow superpowers-requesting-code-review` or `@workflow superpowers-receiving-code-review`
   - Starting feature? → `@workflow superpowers-using-git-worktrees`
   - Finishing work? → `@workflow superpowers-finishing-a-development-branch`
   - Creating/editing skills? → `@workflow superpowers-writing-skills`
   - Creating tasks? → `b2` (never markdown TODOs)

2. **For specialized skills not listed above**, use openskills:

   ```bash
   openskills list
   openskills read <skill-name>
   ```

3. Apply the workflow/skill methodology and resume your work.
