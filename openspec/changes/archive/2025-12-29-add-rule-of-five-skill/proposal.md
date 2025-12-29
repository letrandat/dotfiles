# Change: Add Rule of Five Iterative Review Skill

## Why

Jeffrey Emanuel discovered that agents produce significantly better output when forced to review their work 4-5 times before declaring completion. This "Rule of Five" pattern creates convergence where agents reach a quality threshold they won't improve upon with additional reviews. Current agent workflows produce first-draft quality that users must review and iterate on manually, wasting time and creating rework.

Implementing this as a systematic skill ensures:

- Agents catch their own issues before user review
- Design, planning, implementation, and testing all reach convergent quality
- The pattern is applied consistently across all non-trivial work
- Users can trust agent output at a fundamentally higher level

## What Changes

- **NEW**: `dat-rule-of-five` skill that instructs agent to perform iterative reviews
- **NEW**: Multi-pass review protocol (narrow → broad → architectural)
- **NEW**: Convergence detection mechanism (agent performs 4-5 passes until "as good as we can make it")
- **NEW**: Integration points with existing skills (systematic-debugging, verification-before-completion, etc.)

**How it works:**

User invokes skill **once** (e.g., `/dat-rule-of-five`) and agent autonomously:

1. Performs 2-3 review passes for small tasks, 4-5 for large tasks
2. Takes on different reviewer perspectives each pass:
   - Engineer (correctness, edge cases, performance)
   - Tester (failure modes, test coverage, edge cases)
   - Designer (UX, accessibility, user experience)
   - End user (usability, clarity, value)
   - Architect (patterns, coupling, maintainability)
   - PM/EM (requirements, scope, business value)
3. Progressively broadens scope: code-level → design → architecture
4. Declares convergence when "as good as we can make it"
5. Applies to all phases: design, planning, implementation, testing, code health

**Availability:**

Cross-platform via native implementations in each agent platform (Claude Code skill, Windsurf workflow, Antigravity workflow)

## Impact

**Affected specs:**

- `skills` - New requirement for iterative review capability

**Affected code:**

- New Claude Code skill: `~/.claude/skills/dat-rule-of-five/SKILL.md` (includes all protocols and perspectives inline)
- New Windsurf workflow: `codeium/.codeium/windsurf/global_workflows/dat-rule-of-five.md`
- New Antigravity workflow: `.agent/workflows/dat-rule-of-five.md`
- Integration with: systematic-debugging, verification-before-completion, writing-plans

**User workflow:**

- User explicitly invokes skill: `/dat-rule-of-five` (Claude Code) or workflow trigger (Windsurf/Antigravity)
- Agent then autonomously performs 2-3 review passes for small tasks, 4-5 for large tasks
- Agent applies role-based perspectives and progressive scope escalation
- Agent declares convergence when reaching "as good as we can make it" threshold

**Performance implications:**

- Increased token usage per task (4-5x review passes)
- Increased latency per task (additional review iterations)
- Reduced rework and iteration cycles with users
- Higher trust threshold for agent output
