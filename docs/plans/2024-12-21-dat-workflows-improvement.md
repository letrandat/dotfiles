# dat-* Workflows Improvement Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add lightweight integration points between dat-* workflows and superpowers workflows, remove 2 unused workflows

**Architecture:** Insert "Related Workflows" sections after frontmatter in 7 workflow files, delete 2 unused workflow files

**Tech Stack:** Markdown, Git, Windsurf workflows

**Design Document:** docs/plans/2024-12-21-dat-workflows-improvement-design.md

---

## Task 1: Remove Unused Workflows

**Files:**

- Delete: `codeium/.codeium/windsurf/global_workflows/dat-rewrite.md`
- Delete: `codeium/.codeium/windsurf/global_workflows/dat-rewrite-doc.md`

**Step 1: Verify files exist before deletion**

Run:

```bash
ls -la codeium/.codeium/windsurf/global_workflows/dat-rewrite*.md
```

Expected: Shows both files with details

**Step 2: Delete the files**

Run:

```bash
git rm codeium/.codeium/windsurf/global_workflows/dat-rewrite.md
git rm codeium/.codeium/windsurf/global_workflows/dat-rewrite-doc.md
```

Expected: Files staged for deletion

**Step 3: Verify deletion**

Run:

```bash
git status
```

Expected: Shows 2 files deleted in staged changes

**Step 4: Commit**

Run:

```bash
git commit -m "refactor(windsurf): remove unused dat-rewrite workflows

Remove dat-rewrite.md and dat-rewrite-doc.md as they are not frequently
used and don't provide enough value to maintain.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 2: Update dat-hive-query.md

**Files:**

- Modify: `codeium/.codeium/windsurf/global_workflows/dat-hive-query.md:1-5`

**Step 1: Read current frontmatter**

Run:

```bash
head -5 codeium/.codeium/windsurf/global_workflows/dat-hive-query.md
```

Expected: Shows frontmatter ending at line 4

**Step 2: Insert Related Workflows section**

Add after line 4 (after `---`):

```markdown
## Related Workflows

- 📋 `@workflow superpowers-brainstorming` - Use when designing complex data models or new analytics features
- ✓ `@workflow superpowers-verification-before-completion` - Run before executing queries in production
- 🔧 `@workflow dat-lego` - Use for breaking down complex multi-step queries into modular CTEs

```

**Step 3: Verify the edit**

Run:

```bash
head -15 codeium/.codeium/windsurf/global_workflows/dat-hive-query.md
```

Expected: Shows frontmatter, then Related Workflows section, then original content

**Step 4: Commit**

Run:

```bash
git add codeium/.codeium/windsurf/global_workflows/dat-hive-query.md
git commit -m "feat(windsurf): add workflow integrations to dat-hive-query

Add Related Workflows section linking to brainstorming, verification,
and lego workflows for better discoverability.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 3: Update dat-product-owner.md

**Files:**

- Modify: `codeium/.codeium/windsurf/global_workflows/dat-product-owner.md:1-5`

**Step 1: Read current frontmatter**

Run:

```bash
head -5 codeium/.codeium/windsurf/global_workflows/dat-product-owner.md
```

Expected: Shows frontmatter ending at line 4

**Step 2: Insert Related Workflows section**

Add after line 4 (after `---`):

```markdown
## Related Workflows

- 📋 `@workflow superpowers-brainstorming` - Use BEFORE creating issues for new features to ensure requirements are clear
- 📝 `@workflow superpowers-writing-plans` - Reference for breaking epics into detailed implementation tasks
- 🎯 `@workflow superpowers-using-git-worktrees` - Mentioned in issue description as setup step for assignees

```

**Step 3: Verify the edit**

Run:

```bash
head -15 codeium/.codeium/windsurf/global_workflows/dat-product-owner.md
```

Expected: Shows frontmatter, then Related Workflows section, then original content

**Step 4: Commit**

Run:

```bash
git add codeium/.codeium/windsurf/global_workflows/dat-product-owner.md
git commit -m "feat(windsurf): add workflow integrations to dat-product-owner

Add Related Workflows section linking to brainstorming, writing-plans,
and using-git-worktrees for better issue creation workflow.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 4: Update dat-prompter.md

**Files:**

- Modify: `codeium/.codeium/windsurf/global_workflows/dat-prompter.md:1-5`

**Step 1: Read current frontmatter**

Run:

```bash
head -5 codeium/.codeium/windsurf/global_workflows/dat-prompter.md
```

Expected: Shows frontmatter ending at line 4

**Step 2: Insert Related Workflows section**

Add after line 4 (after `---`):

```markdown
## Related Workflows

- 🧪 `@workflow superpowers-test-driven-development` - Apply TDD principles: write test cases for prompts before optimizing
- ✓ `@workflow superpowers-verification-before-completion` - Test optimized prompt across multiple scenarios before finalizing
- 📋 `@workflow superpowers-brainstorming` - Use when designing prompt systems or complex multi-step prompt chains

```

**Step 3: Verify the edit**

Run:

```bash
head -15 codeium/.codeium/windsurf/global_workflows/dat-prompter.md
```

Expected: Shows frontmatter, then Related Workflows section, then original content

**Step 4: Commit**

Run:

```bash
git add codeium/.codeium/windsurf/global_workflows/dat-prompter.md
git commit -m "feat(windsurf): add workflow integrations to dat-prompter

Add Related Workflows section linking to TDD, verification, and
brainstorming workflows for systematic prompt engineering.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 5: Update dat-w-wiki.md

**Files:**

- Modify: `codeium/.codeium/windsurf/global_workflows/dat-w-wiki.md:1-5`

**Step 1: Read current frontmatter**

Run:

```bash
head -5 codeium/.codeium/windsurf/global_workflows/dat-w-wiki.md
```

Expected: Shows frontmatter ending at line 4

**Step 2: Insert Related Workflows section**

Add after line 4 (after `---`):

```markdown
## Related Workflows

- 🔍 `@workflow superpowers-systematic-debugging` - Use when search results don't match expectations or MCP tools fail
- 📋 `@workflow superpowers-brainstorming` - Use when researching unfamiliar codebases or documentation areas

```

**Step 3: Verify the edit**

Run:

```bash
head -15 codeium/.codeium/windsurf/global_workflows/dat-w-wiki.md
```

Expected: Shows frontmatter, then Related Workflows section, then original content

**Step 4: Commit**

Run:

```bash
git add codeium/.codeium/windsurf/global_workflows/dat-w-wiki.md
git commit -m "feat(windsurf): add workflow integrations to dat-w-wiki

Add Related Workflows section linking to systematic-debugging and
brainstorming for better Confluence search workflow.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 6: Update dat-z-github.md

**Files:**

- Modify: `codeium/.codeium/windsurf/global_workflows/dat-z-github.md:1-5`

**Step 1: Read current frontmatter**

Run:

```bash
head -5 codeium/.codeium/windsurf/global_workflows/dat-z-github.md
```

Expected: Shows frontmatter ending at line 4

**Step 2: Insert Related Workflows section**

Add after line 4 (after `---`):

```markdown
## Related Workflows

- 🔍 `@workflow superpowers-systematic-debugging` - Use when search results don't match expectations or MCP tools fail
- 📋 `@workflow superpowers-brainstorming` - Use when researching unfamiliar codebases or documentation areas

```

**Step 3: Verify the edit**

Run:

```bash
head -15 codeium/.codeium/windsurf/global_workflows/dat-z-github.md
```

Expected: Shows frontmatter, then Related Workflows section, then original content

**Step 4: Commit**

Run:

```bash
git add codeium/.codeium/windsurf/global_workflows/dat-z-github.md
git commit -m "feat(windsurf): add workflow integrations to dat-z-github

Add Related Workflows section linking to systematic-debugging and
brainstorming for better GitHub search workflow.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 7: Update dat-b2.md

**Files:**

- Modify: `codeium/.codeium/windsurf/global_workflows/dat-b2.md:1-5`

**Step 1: Read current frontmatter**

Run:

```bash
head -5 codeium/.codeium/windsurf/global_workflows/dat-b2.md
```

Expected: Shows frontmatter ending at line 3

**Step 2: Insert Related Workflows section**

Add after line 3 (after `---`):

```markdown
## Related Workflows

- 📋 `@workflow superpowers-using-superpowers` - Review available workflows after b2 onboard
- 🎯 `@workflow dat-product-owner` - Use for creating well-structured issues with b2

```

**Step 3: Verify the edit**

Run:

```bash
head -15 codeium/.codeium/windsurf/global_workflows/dat-b2.md
```

Expected: Shows frontmatter, then Related Workflows section, then original content

**Step 4: Commit**

Run:

```bash
git add codeium/.codeium/windsurf/global_workflows/dat-b2.md
git commit -m "feat(windsurf): add workflow integrations to dat-b2

Add Related Workflows section linking to using-superpowers and
product-owner for better b2 initialization workflow.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 8: Update dat-lego.md

**Files:**

- Modify: `codeium/.codeium/windsurf/global_workflows/dat-lego.md:1-5`

**Step 1: Read current frontmatter**

Run:

```bash
head -5 codeium/.codeium/windsurf/global_workflows/dat-lego.md
```

Expected: Shows frontmatter ending at line 4

**Step 2: Insert Related Workflows section**

Add after line 4 (after `---`):

```markdown
## Related Workflows

- 📋 `@workflow superpowers-brainstorming` - Use FIRST to understand requirements before designing modules
- 📝 `@workflow superpowers-writing-plans` - Use AFTER lego breakdown to create implementation plan
- 🧪 `@workflow superpowers-test-driven-development` - Each module should be developed with TDD
- ✓ `@workflow superpowers-verification-before-completion` - Verify module boundaries and integration points

```

**Step 3: Verify the edit**

Run:

```bash
head -20 codeium/.codeium/windsurf/global_workflows/dat-lego.md
```

Expected: Shows frontmatter, then Related Workflows section, then original content

**Step 4: Commit**

Run:

```bash
git add codeium/.codeium/windsurf/global_workflows/dat-lego.md
git commit -m "feat(windsurf): add workflow integrations to dat-lego

Add Related Workflows section linking to brainstorming, writing-plans,
TDD, and verification for complete modular design workflow.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 9: Verify All Changes

**Step 1: Check git status**

Run:

```bash
git status
```

Expected: Clean working tree, all changes committed

**Step 2: Review commit history**

Run:

```bash
git log --oneline -9
```

Expected: Shows 9 commits (1 removal + 7 updates + 1 design doc)

**Step 3: Verify workflow files**

Run:

```bash
ls -la codeium/.codeium/windsurf/global_workflows/dat-*.md
```

Expected: Shows 9 dat-* workflow files (11 original - 2 removed = 9)

**Step 4: Spot check one workflow**

Run:

```bash
head -15 codeium/.codeium/windsurf/global_workflows/dat-hive-query.md
```

Expected: Shows frontmatter, Related Workflows section, then content

---

## Task 10: Push to Remote

**Step 1: Push all commits**

Run:

```bash
git push
```

Expected: All commits pushed successfully

**Step 2: Verify push**

Run:

```bash
git status
```

Expected: "Your branch is up to date with 'origin/main'"

**Step 3: Update b2 task**

Run:

```bash
b2 update dotfiles-fdk --notes "Implementation complete. All 7 workflows updated with Related Workflows sections. 2 unused workflows removed. Changes committed and pushed."
```

Expected: Task updated successfully

---

## Success Criteria

- ✅ 2 workflows removed (dat-rewrite.md, dat-rewrite-doc.md)
- ✅ 7 workflows updated with Related Workflows sections
- ✅ All changes committed (9 commits total)
- ✅ All changes pushed to remote
- ✅ Git history is clean
- ✅ Task updated in b2

## Notes

- Each task creates a focused, atomic commit
- Related Workflows sections are consistent across all files
- Changes can be easily reverted if needed (per-file commits)
- No breaking changes to existing workflow functionality
