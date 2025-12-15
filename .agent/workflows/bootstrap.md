---
description: Initialize agent with bd skill and list available skills at conversation start
---

1. Load bd issue tracking instructions:

   ```bash
   bd onboard
   ```

2. List all available skills for reference:

   ```bash
   openskills list
   ```

3. **You MUST use these skills throughout this session:**
   - Load skills with `openskills read <skill-name>` before applying them
   - **Mandatory skills:**
     - `bd` - For ALL task/issue tracking (never use markdown TODOs)
     - `brainstorming` - BEFORE writing code or implementation plans
     - `verification-before-completion` - BEFORE claiming work is complete
