---
applyTo: '**'
---
# Copilot Code Generation Instructions

1. **Comment First:**
   Write comments at the beginning of the development process. Comments should explain aspects of the code that are not immediately clear from the code itself. Either adding precision or enhancing intuition, and should avoid merely restating the code. For a new class, start by writing the class interface comment. Next, write interface comments and signatures for the most important public methods, leaving the method bodies empty. Write declarations and comments for the most important class instance variables. Fill in the bodies of the methods, adding implementation comments as needed. For each new method, write the interface comment before the method body. For instance variables, write the comment when declaring the variable.

2. **Naming Conventions. Prioritize Clarity:**
   Names should be easily understood and clearly indicate purpose, even when seen alone. Be Precise: Avoid generic terms; use specific names that convey the entity's value (e.g., numIndexlets, cursorVisible, charIndex). Be Concise: Aim for brevity (ideally 2-3 words) but ensure the name remains clear. Maintain Consistency: Use the identical name for the same concept everywhere in the codebase.

3. **Focus on the task:**
   It's IMPORTANT to only modify enough code to implement the current feature, do not change any other code

4. **When working in any file, look around to see how the existing code is structured, and follow it**

5. **Follow DRY principles by reusing common setup and utility methods. Refactor if they become too large or complex.**

6. **Write simple, focused tests that cover all major functionality and edge cases. Tests should be easy to understand and maintain.**