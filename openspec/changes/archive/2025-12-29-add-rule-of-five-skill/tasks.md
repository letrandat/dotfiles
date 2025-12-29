## 1. Claude Code Skill Implementation

- [ ] 1.1 Create `~/.claude/skills/dat-rule-of-five/SKILL.md` with metadata and overview
- [ ] 1.2 Write "When to Use" section defining small vs large task criteria
- [ ] 1.3 Write "The Iron Law" establishing minimum pass requirements
- [ ] 1.4 Document "Role-Based Review Protocol" with reviewer perspectives
- [ ] 1.5 Document "Progressive Review Scope" (narrow → broad → architectural)
- [ ] 1.6 Write "Convergence Criteria" section with examples
- [ ] 1.7 Create "Integration Points" section linking to other skills
- [ ] 1.8 Add "Red Flags" section for superficial reviews
- [ ] 1.9 Create "Common Rationalizations" table
- [ ] 1.10 Write "Quick Reference" summary table
- [ ] 1.11 Verify skill loads in Claude Code with `/dat-rule-of-five`
- [ ] 1.12 Test skill discovery via description keywords

## 2. Windsurf Workflow Implementation

- [ ] 2.1 Create `.codeium/windsurf/global_workflows/dat-rule-of-five.md`
- [ ] 2.2 Adapt skill content for Windsurf workflow format
- [ ] 2.3 Include role-based review perspectives
- [ ] 2.4 Test workflow invocation in Windsurf
- [ ] 2.5 Verify workflow appears in Windsurf workflow selector

## 3. Antigravity Workflow Implementation

- [ ] 3.1 Create `.agent/workflows/dat-rule-of-five.md`
- [ ] 3.2 Adapt skill content for Antigravity workflow format
- [ ] 3.3 Include role-based review perspectives
- [ ] 3.4 Test workflow invocation in Antigravity

## 4. Supporting Documentation

- [x] 4.1 Create supporting docs for review protocols (inline in SKILL.md)
- [x] 4.2 Document role-based perspectives:
  - [x] 4.2.1 Engineer perspective (correctness, edge cases, performance)
  - [x] 4.2.2 Tester perspective (failure modes, test coverage)
  - [x] 4.2.3 Designer perspective (UX, accessibility)
  - [x] 4.2.4 End user perspective (usability, clarity, value)
  - [x] 4.2.5 Architect perspective (patterns, coupling, maintainability)
  - [x] 4.2.6 PM/EM perspective (requirements, scope, business value)
- [x] 4.3 Document Pass 1-2 protocol (code-level, narrow focus)
- [x] 4.4 Document Pass 3-4 protocol (design patterns, integration)
- [x] 4.5 Document Pass 5 protocol (architecture, fundamental questions)
- [ ] 4.6 Add examples of each pass type with before/after
- [x] 4.7 Document convergence indicators and false convergence warnings

## 5. Integration with Existing Skills

- [ ] 5.1 Review `systematic-debugging/SKILL.md` for integration points
- [ ] 5.2 Review `verification-before-completion/SKILL.md` for integration points
- [ ] 5.3 Review `test-driven-development/SKILL.md` for integration points
- [ ] 5.4 Review `writing-plans/SKILL.md` for integration points
- [ ] 5.5 Update related skills to reference dat-rule-of-five where appropriate
- [ ] 5.6 Ensure no duplicate review requirements across skills

## 6. Documentation and Examples

- [ ] 6.1 Add real-world example: design review progression
- [ ] 6.2 Add real-world example: code review progression with role perspectives
- [ ] 6.3 Add real-world example: test review progression
- [ ] 6.4 Document typical findings per pass number
- [ ] 6.5 Document typical findings per reviewer perspective
- [ ] 6.6 Add section on "Why This Matters" with impact data (when available)

## 7. Cross-Platform Testing

- [ ] 7.1 Manually test skill on small task in Claude Code (verify 2-3 passes)
- [ ] 7.2 Manually test workflow on small task in Windsurf (verify 2-3 passes)
- [ ] 7.3 Manually test workflow on small task in Antigravity (verify 2-3 passes)
- [ ] 7.4 Manually test skill on large task in Claude Code (verify 4-5 passes)
- [ ] 7.5 Manually test workflow on large task in Windsurf (verify 4-5 passes)
- [ ] 7.6 Verify progressive scope increase across passes (all platforms)
- [ ] 7.7 Verify role-based perspectives are applied (all platforms)
- [ ] 7.8 Verify convergence detection works correctly (all platforms)
- [ ] 7.9 Test integration with verification-before-completion
- [ ] 7.10 Verify content consistency across platforms

## 8. Quality Checks

- [ ] 8.1 Check for markdown lint issues with `markdownlint-cli2`
- [ ] 8.2 Verify all files pass IDE diagnostics
- [ ] 8.3 Ensure skill follows `writing-skills` best practices
- [ ] 8.4 Verify token efficiency (keep concise where possible)

## 9. Spec Archive

- [ ] 9.1 Archive change after deployment: `openspec archive add-rule-of-five-skill`
- [ ] 9.2 Verify `specs/skills/spec.md` created with requirements
- [ ] 9.3 Verify change moved to `changes/archive/YYYY-MM-DD-add-rule-of-five-skill/`
- [ ] 9.4 Run `openspec validate --strict` to confirm clean state
