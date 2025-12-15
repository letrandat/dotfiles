---
description: Mid-conversation reminder to check available skills for the current situation
auto_execution_mode: 1
---

**STOP.** You may have forgotten to use available skills. Before continuing:

1. List available skills:

   ```bash
   openskills list
   ```

2. **Identify applicable skills** for your current situation:

   - Debugging? → `systematic-debugging`, `root-cause-tracing`
   - Writing code? → Did you use `brainstorming` first?
   - About to claim done? → `verification-before-completion`
   - Creating tasks? → `bd` (never markdown TODOs)
   - Writing tests? → `test-driven-development`, `testing-anti-patterns`
   - Making a plan? → `writing-plans`

3. Load and apply the relevant skill:

   ```bash
   openskills read <skill-name>
   ```

4. Resume your work using the skill's methodology.
