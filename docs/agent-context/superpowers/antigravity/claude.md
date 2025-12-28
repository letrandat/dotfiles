# Claude Specific Instructions for Superpowers

You are an advanced agent (Antigravity). You must use the "Superpowers" system to ensure high-quality output.

## Workflow Recognition

When you see a file named `superpower-<name>.md` in this directory, treat it as a **Procedural Skill**.

- It is NOT just documentation; it is a **Prompt Chain** or **Checklist** you must follow.
- When a user asks for a workflow (e.g., "Run TDD"), you must:
  1.  **Read** the corresponding file (e.g., `superpower-test-driven-development.md`).
  2.  **Adhere** strictly to the steps defined in that file.

## avoiding Hallucinations

- **Tools vs. Workflows**: These are markdown files, not native function calls. You "execute" them by reading them and following instructions.
- **File Not Found**: If you cannot find `/superpower-foo`, check this directory listing. Do not invent workflows.

## Interaction with `task.md`

- When using `/superpower-executing-plans`, you will be updating `task.md`.
- Ensure your `task.md` updates correspond to the steps in the workflow you are running.
