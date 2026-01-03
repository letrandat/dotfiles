---
description: Mid-conversation reminder to check available workflows/skills for the current situation
---

**STOP.** You may have forgotten to use available workflows. Before continuing:

1. **Check if a core workflow applies** (invoke via Cascade menu or `/superpower-` command):

   - Starting session? → `/superpower-using-superpowers`
   - New feature/design? → `/superpower-brainstorming`
   - Debugging? → `/superpower-systematic-debugging`
   - Writing code? → `/superpower-test-driven-development`
   - About to claim done? → `/superpower-verification-before-completion`
   - Making a plan? → `/superpower-writing-plans`
   - Executing plan (parallel)? → `/superpower-executing-plans`
   - Executing plan (current session)? → `/superpower-subagent-driven-development`
   - 2+ independent tasks? → `/superpower-dispatching-parallel-agents`
   - Code review? → `/superpower-requesting-code-review` or `/superpower-receiving-code-review`
   - Starting feature? → `/superpower-using-git-worktrees`
   - Finishing work? → `/superpower-finishing-a-development-branch`
   - Creating/editing skills? → `/superpower-writing-skills`
   - Creating tasks? → `b2` (never markdown TODOs)

2. **For specialized skills not listed above**, use openskills:

   ```bash
   openskills list
   openskills read <skill-name>
   ```

3. Apply the workflow/skill methodology and resume your work.
