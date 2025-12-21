---
description: Initialize agent with bd skill and available workflows/skills at conversation start
auto_execution_mode: 1
---

1. Load bd issue tracking instructions:

   ```bash
   bd onboard
   ```

2. **Core skills are available as native Windsurf workflows** (invoke via Cascade menu or @workflow):
   - `brainstorming` - BEFORE writing code or implementation plans
   - `systematic-debugging` - When encountering bugs or test failures
   - `test-driven-development` - When implementing features/bugfixes
   - `verification-before-completion` - BEFORE claiming work is complete
   - `writing-plans` - When creating implementation plans
   - `requesting-code-review` - Before merging/completing major features
   - `receiving-code-review` - When processing code review feedback
   - `using-git-worktrees` - When starting isolated feature work
   - `finishing-a-development-branch` - When implementation is complete

3. **Additional specialized skills** available via openskills (for advanced use):
   - View all: `openskills list`
   - Load: `openskills read <skill-name>`

4. **Mandatory workflow usage:**
   - `bd` - For ALL task/issue tracking (never use markdown TODOs)
   - `brainstorming` - BEFORE any creative/implementation work
   - `verification-before-completion` - BEFORE claiming anything is done
