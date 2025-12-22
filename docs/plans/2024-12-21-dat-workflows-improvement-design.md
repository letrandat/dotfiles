# dat-* Workflows Improvement Design

**Date:** 2024-12-21
**Status:** Approved
**Task:** dotfiles-fdk

## Overview

Improve dat-* Windsurf workflows by adding lightweight integration points with superpowers workflows. Focus on the 5 most frequently used workflows while removing 2 unused ones.

## Goals

- Create a cohesive workflow ecosystem
- Make superpowers workflows more discoverable from dat-* workflows
- Maintain simplicity with lightweight, non-intrusive references
- Focus on practical value over theoretical completeness

## Workflow Classification

### High Priority (Frequently Used)
1. **dat-hive-query** - SQL generation (used often)
2. **dat-product-owner** - Issue creation (used regularly)
3. **dat-prompter** - Prompt engineering (used regularly)
4. **dat-w-wiki** - Confluence search (used a lot)
5. **dat-z-github** - GitHub search (used a lot)

### Medium Priority (New/Testing)
6. **dat-b2** - b2 initialization (new)
7. **dat-lego** - Modular design (still testing)

### Low Priority (Rarely Used)
- **dat-faster** - Performance optimization (used once)
- **dat-recall-skills** - Workflow reminder (rarely used)

### To Remove (Not Useful)
- **dat-rewrite-doc** - Documentation rewriting
- **dat-rewrite** - Code rewriting

## Design Approach

### Integration Pattern

Add a lightweight "Related Workflows" section to each workflow immediately after the frontmatter. Format:

```markdown
---
description: [existing]
auto_execution_mode: [existing]
---

## Related Workflows

- 📋 `@workflow superpowers-name` - When to use this
- ✓ `@workflow superpowers-name` - When to use this
```

**Rationale:**
- Non-intrusive: doesn't interrupt main workflow content
- Scannable: uses emojis and clear descriptions
- Actionable: tells you when to use each integration
- Low maintenance: simple format, easy to update

## Specific Integrations

### dat-hive-query (SQL Generation)

```markdown
## Related Workflows

- 📋 `@workflow superpowers-brainstorming` - Use when designing complex data models or new analytics features
- ✓ `@workflow superpowers-verification-before-completion` - Run before executing queries in production
- 🔧 `@workflow dat-lego` - Use for breaking down complex multi-step queries into modular CTEs
```

**Rationale:** SQL work often needs design thinking (brainstorming), modular breakdown (lego), and validation before production use (verification).

### dat-product-owner (Issue Creation)

```markdown
## Related Workflows

- 📋 `@workflow superpowers-brainstorming` - Use BEFORE creating issues for new features to ensure requirements are clear
- 📝 `@workflow superpowers-writing-plans` - Reference for breaking epics into detailed implementation tasks
- 🎯 `@workflow superpowers-using-git-worktrees` - Mentioned in issue description as setup step for assignees
```

**Rationale:** Product owners benefit from brainstorming requirements first, understanding how to structure implementation plans, and guiding assignees to proper workspace setup.

### dat-prompter (Prompt Engineering)

```markdown
## Related Workflows

- 🧪 `@workflow superpowers-test-driven-development` - Apply TDD principles: write test cases for prompts before optimizing
- ✓ `@workflow superpowers-verification-before-completion` - Test optimized prompt across multiple scenarios before finalizing
- 📋 `@workflow superpowers-brainstorming` - Use when designing prompt systems or complex multi-step prompt chains
```

**Rationale:** Prompt engineering benefits from test-first thinking (what outputs do we want?), verification (does it actually work?), and design thinking for complex systems.

### dat-w-wiki & dat-z-github (MCP Search)

```markdown
## Related Workflows

- 🔍 `@workflow superpowers-systematic-debugging` - Use when search results don't match expectations or MCP tools fail
- 📋 `@workflow superpowers-brainstorming` - Use when researching unfamiliar codebases or documentation areas
```

**Rationale:** Search tools benefit from systematic debugging when things go wrong, and brainstorming when exploring new territory.

### dat-b2 (Task Tracker Initialization)

```markdown
## Related Workflows

- 📋 `@workflow superpowers-using-superpowers` - Review available workflows after b2 onboard
- 🎯 `@workflow dat-product-owner` - Use for creating well-structured issues with b2
```

**Rationale:** After initializing b2, users should know what workflows are available and how to create quality issues.

### dat-lego (Modular Design)

```markdown
## Related Workflows

- 📋 `@workflow superpowers-brainstorming` - Use FIRST to understand requirements before designing modules
- 📝 `@workflow superpowers-writing-plans` - Use AFTER lego breakdown to create implementation plan
- 🧪 `@workflow superpowers-test-driven-development` - Each module should be developed with TDD
- ✓ `@workflow superpowers-verification-before-completion` - Verify module boundaries and integration points
```

**Rationale:** Lego fits perfectly into the superpowers workflow: brainstorm → design modules → plan implementation → TDD each module → verify integration.

## Implementation

### File Changes

**Remove (2 files):**
- `codeium/.codeium/windsurf/global_workflows/dat-rewrite.md`
- `codeium/.codeium/windsurf/global_workflows/dat-rewrite-doc.md`

**Update (7 files):**
- `codeium/.codeium/windsurf/global_workflows/dat-hive-query.md`
- `codeium/.codeium/windsurf/global_workflows/dat-product-owner.md`
- `codeium/.codeium/windsurf/global_workflows/dat-prompter.md`
- `codeium/.codeium/windsurf/global_workflows/dat-w-wiki.md`
- `codeium/.codeium/windsurf/global_workflows/dat-z-github.md`
- `codeium/.codeium/windsurf/global_workflows/dat-b2.md`
- `codeium/.codeium/windsurf/global_workflows/dat-lego.md`

### Update Pattern

For each file, insert the "Related Workflows" section immediately after the frontmatter:

```markdown
---
description: [existing description]
auto_execution_mode: [existing value]
---

## Related Workflows

[specific integrations as designed above]

[rest of existing content unchanged]
```

### Testing

After updates:
1. Verify workflows appear correctly in Windsurf's workflow menu
2. Check that all `@workflow` references are accurate
3. Test invoking related workflows from within dat-* workflows

### Rollout

1. Write this design document
2. Commit design document
3. Create git worktree for implementation (if desired)
4. Make file changes
5. Test in Windsurf
6. Commit and push

## Success Criteria

- ✅ 2 unused workflows removed
- ✅ 7 workflows enhanced with integration points
- ✅ All references accurate and working
- ✅ Design documented and committed
- ✅ Changes tested in Windsurf

## Future Considerations

### Low Priority Workflows

**dat-faster** and **dat-recall-skills** remain unchanged for now since they're rarely used. If usage increases, consider:
- dat-faster: Add verification and TDD integration
- dat-recall-skills: Already updated with new workflows, consider auto_execution_mode tuning

### Metrics

Track which dat-* workflows get used most over the next month to validate prioritization and identify if any low-priority workflows should be removed or promoted.

## Rationale

This design prioritizes practical value over theoretical completeness. By focusing on the 5 most-used workflows and using lightweight integration points, we create a cohesive ecosystem without overwhelming users or creating maintenance burden.

The "Related Workflows" pattern is:
- **Discoverable**: Users see integrations when viewing a workflow
- **Non-intrusive**: Doesn't disrupt existing workflow content
- **Actionable**: Clear guidance on when to use each integration
- **Scalable**: Easy to add/remove/update integrations as workflows evolve
