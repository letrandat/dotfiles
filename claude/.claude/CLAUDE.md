# Claude Code Project Instructions

## Lint Checking Requirements

### After Completing Any Work

**Check for lint/diagnostics when the IDE MCP server is available.**

The `mcp__ide__getDiagnostics` tool is only available when Claude Code is launched from within Neovim. When running standalone, this tool is unavailable.

#### Workflow

1. Complete the implementation/changes
2. **Try to check IDE diagnostics** (skip gracefully if unavailable):
   - If `mcp__ide__getDiagnostics` is available: Run it to check for lint issues
   - If unavailable (standalone mode): Note "IDE diagnostics unavailable in standalone mode - skipping lint check"
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

**✅ ALSO GOOD (Standalone mode):**

```text
Agent: "Changes complete. IDE diagnostics unavailable in standalone mode - skipping lint check."
```

### Critical Rules

- ✅ **TRY** to check diagnostics after completing work (if IDE MCP available)
- ✅ **ALWAYS** explicitly state whether you checked or skipped (with reason)
- ✅ **ALWAYS** fix lint errors related to your changes (when diagnostics available)
- ✅ Document why you're ignoring unrelated/minor issues
- ✅ Skip gracefully in standalone mode with a clear message
- ❌ **NEVER** silently ignore lint errors in modified files (when diagnostics available)
