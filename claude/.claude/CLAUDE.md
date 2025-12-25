# Claude Code Project Instructions

## Lint Checking Requirements

### After Completing Any Work

**ALWAYS check for lint/diagnostics from the IDE (neovim) after completing work.**

Use the `mcp__ide__getDiagnostics` tool to check for errors and warnings.

#### Workflow

1. Complete the implementation/changes
2. **ALWAYS** run `mcp__ide__getDiagnostics` to check for lint issues
3. **Try to use appropriate linter to auto-fix** before manually fixing:
   - Markdown: `markdownlint-cli2 --fix <file>`
   - JavaScript/TypeScript: `eslint --fix <file>` or neovim LSP format
   - Python: `black <file>` or `ruff --fix <file>`
   - Other: Check for language-specific auto-fix tools
4. **ALWAYS** explicitly state in your response that you checked for lint
5. Evaluate the diagnostics:
   - **If lint is related to your changes**: Fix it immediately (auto-fix first, then manual)
   - **If lint is valid but unrelated to your changes**: Fix it if trivial, otherwise note it
   - **If lint is minor/false positive**: Document why you're ignoring it

#### Examples

**✅ GOOD (States check and takes action):**

```text
Agent: "Implementation complete. Checking IDE diagnostics..."
Agent: [Uses mcp__ide__getDiagnostics]
Agent: "I've checked the IDE diagnostics. Found 2 errors in the modified file - fixing them now..."
```

**✅ ALSO GOOD (No issues found):**

```text
Agent: "Changes complete. Checking IDE diagnostics..."
Agent: [Uses mcp__ide__getDiagnostics]
Agent: "I've checked the IDE diagnostics. No errors or warnings related to the changes."
```

**✅ ALSO GOOD (Ignoring unrelated):**

```text
Agent: "Updates complete. Checking IDE diagnostics..."
Agent: [Uses mcp__ide__getDiagnostics]
Agent: "I've checked the IDE diagnostics. Found 1 warning in an unrelated file (components/old-feature.tsx) - ignoring as it's not related to our authentication changes."
```

**❌ BAD (Didn't check):**

```text
Agent: "Implementation complete!"
[No diagnostic check performed]
```

### Critical Rules

- ✅ **ALWAYS** check diagnostics after completing work
- ✅ **ALWAYS** explicitly state that you checked
- ✅ **ALWAYS** fix lint errors related to your changes
- ✅ Document why you're ignoring unrelated/minor issues
- ❌ **NEVER** skip the diagnostic check
- ❌ **NEVER** silently ignore lint errors in modified files
