# Fresh LazyVim Setup - Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace current LazyVim config with fresh minimal setup, preserve old as nvim-full for reference.

**Architecture:** Rename current config to nvim-full, install fresh LazyVim starter as default, add essential customizations only, enable NVIM_APPNAME switching between configs.

**Tech Stack:** LazyVim (Neovim distro), GNU Stow (symlink management), Git

---

## Task 1: Backup and Rename Current Config

**Files:**
- Rename: `nvim/.config/nvim/` → `nvim/.config/nvim-full/`
- Delete: `.config/nvim/lazy-lock.json`

**Step 1: Rename current nvim config to nvim-full**

Run:
```bash
mv nvim/.config/nvim nvim/.config/nvim-full
```

**Step 2: Verify rename succeeded**

Run:
```bash
ls -la nvim/.config/
```

Expected output: Directory listing shows `nvim-full/`, no `nvim/` directory

**Step 3: Remove orphaned lazy-lock.json**

Run:
```bash
rm -f .config/nvim/lazy-lock.json
rmdir .config/nvim 2>/dev/null || true
```

**Step 4: Verify cleanup**

Run:
```bash
ls -la .config/nvim 2>&1
```

Expected output: "No such file or directory" or empty directory

**Step 5: Commit the backup**

Run:
```bash
git add -A
git commit -m "feat: Rename nvim to nvim-full and clean up orphaned files

Preserves current LazyVim config as nvim-full for reference.
Removes orphaned .config/nvim/lazy-lock.json.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Clean commit, working tree clean

---

## Task 2: Install Fresh LazyVim Starter

**Files:**
- Create: `nvim/.config/nvim/` (entire LazyVim starter structure)

**Step 1: Clone LazyVim starter template**

Run:
```bash
git clone https://github.com/LazyVim/starter nvim/.config/nvim
```

Expected: LazyVim starter cloned into `nvim/.config/nvim/`

**Step 2: Remove .git folder to integrate into dotfiles repo**

Run:
```bash
rm -rf nvim/.config/nvim/.git
```

**Step 3: Verify fresh install structure**

Run:
```bash
ls -la nvim/.config/nvim/
```

Expected output: Should show `init.lua`, `lua/` directory, `LICENSE`, `README.md`, `.gitignore`, etc.

Check init.lua exists:
```bash
cat nvim/.config/nvim/init.lua
```

Expected: File contains `require("config.lazy")`

**Step 4: Commit fresh LazyVim baseline**

Run:
```bash
git add nvim/.config/nvim
git commit -m "feat: Add fresh LazyVim starter as default nvim config

Fresh LazyVim starter template with no customizations.
This commit marks the baseline before any customizations.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Clean commit with all LazyVim starter files

---

## Task 3: Add Essential Customizations

**Files:**
- Modify: `nvim/.config/nvim/lua/config/options.lua`
- Create: `nvim/.config/nvim/lua/plugins/nvim-spider.lua`
- Create: `nvim/.config/nvim/lua/plugins/guess-indent.lua`
- Create: `nvim/.config/nvim/lua/plugins/disabled.lua`

**Step 1: Disable autoformat in options.lua**

Add to `nvim/.config/nvim/lua/config/options.lua`:
```lua
-- Disable auto format
vim.g.autoformat = false
```

**Step 2: Verify options.lua modification**

Run:
```bash
cat nvim/.config/nvim/lua/config/options.lua
```

Expected: File contains `vim.g.autoformat = false`

**Step 3: Create nvim-spider plugin**

Create `nvim/.config/nvim/lua/plugins/nvim-spider.lua`:
```lua
return {
  "chrisgrieser/nvim-spider",
  opts = {},
  keys = {
    {
      "w",
      "<cmd>lua require('spider').motion('w')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to start of next of word",
    },
    {
      "e",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to end of word",
    },
    {
      "b",
      "<cmd>lua require('spider').motion('b')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to start of previous word",
    },
  },
}
```

**Step 4: Create guess-indent plugin**

Create `nvim/.config/nvim/lua/plugins/guess-indent.lua`:
```lua
return {
  "NMAC427/guess-indent.nvim",
  opts = {},
}
```

**Step 5: Create disabled.lua to disable bufferline**

Create `nvim/.config/nvim/lua/plugins/disabled.lua`:
```lua
return {
  { "akinsho/bufferline.nvim", enabled = false },
}
```

**Step 6: Verify all plugin files created**

Run:
```bash
ls -la nvim/.config/nvim/lua/plugins/
```

Expected: Shows `nvim-spider.lua`, `guess-indent.lua`, `disabled.lua`

**Step 7: Commit essential customizations**

Run:
```bash
git add nvim/.config/nvim/lua/config/options.lua \
        nvim/.config/nvim/lua/plugins/nvim-spider.lua \
        nvim/.config/nvim/lua/plugins/guess-indent.lua \
        nvim/.config/nvim/lua/plugins/disabled.lua
git commit -m "feat: Add essential customizations

- Disable autoformat (user preference)
- Add nvim-spider for better w/e/b word motions
- Add guess-indent for auto-detect indentation
- Disable bufferline for clean UI

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Clean commit with 4 files changed

---

## Task 4: Add Language Extras

**Files:**
- Create: `nvim/.config/nvim/lua/plugins/language-extras.lua`

**Step 1: Create language extras plugin file**

Create `nvim/.config/nvim/lua/plugins/language-extras.lua`:
```lua
return {
  -- Import LazyVim language extras
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.java" },
  { import = "lazyvim.plugins.extras.lang.scala" },
  { import = "lazyvim.plugins.extras.lang.vue" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.sql" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.git" },
}
```

**Step 2: Verify language extras file created**

Run:
```bash
cat nvim/.config/nvim/lua/plugins/language-extras.lua
```

Expected: File contains all 13 language import statements

**Step 3: Commit language extras**

Run:
```bash
git add nvim/.config/nvim/lua/plugins/language-extras.lua
git commit -m "feat: Add LazyVim language extras

Languages: typescript, go, python, java, scala, vue
Formats: json, yaml, toml, markdown, sql
Tools: docker, git

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Clean commit with 1 file added

---

## Task 5: Add Utility Extras

**Files:**
- Create: `nvim/.config/nvim/lua/plugins/utility-extras.lua`

**Step 1: Create utility extras plugin file**

Create `nvim/.config/nvim/lua/plugins/utility-extras.lua`:
```lua
return {
  -- Import LazyVim utility extras
  { import = "lazyvim.plugins.extras.editor.mini-files" },
  { import = "lazyvim.plugins.extras.editor.dial" },
  { import = "lazyvim.plugins.extras.editor.inc-rename" },
  { import = "lazyvim.plugins.extras.util.dot" },
}
```

**Step 2: Verify utility extras file created**

Run:
```bash
cat nvim/.config/nvim/lua/plugins/utility-extras.lua
```

Expected: File contains all 4 utility import statements

**Step 3: Commit utility extras**

Run:
```bash
git add nvim/.config/nvim/lua/plugins/utility-extras.lua
git commit -m "feat: Add LazyVim utility extras

- editor.mini-files: File explorer
- editor.dial: Smart increment/decrement
- editor.inc-rename: LSP rename with preview
- util.dot: Dotfiles syntax highlighting

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Clean commit with 1 file added

---

## Task 6: Create Migration Reference Document

**Files:**
- Create: `docs/nvim-migration-reference.md`

**Step 1: Create migration reference document**

Create `docs/nvim-migration-reference.md`:
```markdown
# Nvim Migration Reference

Quick reference for cherry-picking from nvim-full config.

## Essential Customizations Already Added

- ✅ vim.g.autoformat = false
- ✅ nvim-spider (better word motions: w/e/b)
- ✅ guess-indent (auto-detect indentation)
- ✅ disabled bufferline (clean UI)

## Custom Plugins from nvim-full

Located in `nvim/.config/nvim-full/lua/plugins/`:

- [x] **nvim-spider.lua** - Better word motions (ADDED)
- [x] **guess-indent.lua** - Auto-detect indentation (ADDED)
- [x] **disabled.lua** - Disables bufferline (ADDED)
- [ ] **extend-mini-files.lua** - Wider preview (width: 100)
  - Add when: You want wider file preview in mini.files
  - How: `cp nvim/.config/nvim-full/lua/plugins/extend-mini-files.lua nvim/.config/nvim/lua/plugins/`
- [ ] **extend-snacks.lua** - Show hidden files in picker
  - Customizations: Shows hidden/ignored files, excludes node_modules & .git
  - Add when: You need to see hidden files in fuzzy finder
  - How: `cp nvim/.config/nvim-full/lua/plugins/extend-snacks.lua nvim/.config/nvim/lua/plugins/`
  - Note: Remove session-related code (lines 4-9) if you don't use sessions

## LazyVim Extras Already Added

### Languages (13)
- ✅ typescript
- ✅ go
- ✅ python
- ✅ java
- ✅ scala
- ✅ vue
- ✅ json
- ✅ yaml
- ✅ toml
- ✅ markdown
- ✅ sql
- ✅ docker
- ✅ git

### Editor Utilities (3)
- ✅ mini-files (file explorer)
- ✅ dial (smart increment/decrement)
- ✅ inc-rename (LSP rename preview)

### Utilities (1)
- ✅ dot (dotfiles syntax)

## LazyVim Extras Available in nvim-full (Not Added)

Add these via `:LazyExtras` when needed:

- [ ] **coding.yanky** - Enhanced clipboard/yank history
  - Status: SKIP - Not needed
- [ ] **test.core** - Neotest integration for running tests
  - Add when: You need to run tests in nvim
  - How: `:LazyExtras` → search "test" → press `x`
- [ ] **util.mini-hipatterns** - Highlight color codes, TODOs
  - Add when: You want visual highlighting of #colors and TODO comments
  - How: `:LazyExtras` → search "hipatterns" → press `x`

## Other Languages from nvim-full (Not Added)

These were in nvim-full but not in initial setup. Add when working on those projects:

- [ ] **lang.cmake** - `:LazyExtras` → "cmake"
- [ ] **lang.kotlin** - `:LazyExtras` → "kotlin"

## Custom Options

- ✅ `vim.g.autoformat = false` - Already in `lua/config/options.lua`

## Cherry-Pick Workflow

### To add a plugin from nvim-full:

1. **Identify:** Find plugin file in list above
2. **Copy:**
   ```bash
   cp nvim/.config/nvim-full/lua/plugins/<file>.lua \
      nvim/.config/nvim/lua/plugins/
   ```
3. **Edit if needed:** Remove unwanted features (e.g., session stuff in extend-snacks)
4. **Reload:** Restart nvim or run `:Lazy sync`
5. **Test:** Verify plugin loads without errors (`:Lazy` to check status)
6. **Commit:**
   ```bash
   git add nvim/.config/nvim/lua/plugins/<file>.lua
   git commit -m "feat: Add <plugin-name> from nvim-full"
   ```
7. **Track:** Check off `[x]` in this document

### To add a LazyVim extra:

**Method 1: Interactive (Recommended)**
1. Open nvim: `nvim`
2. Run: `:LazyExtras`
3. Browse available extras
4. Press `x` to toggle install
5. Restart nvim
6. Commit:
   ```bash
   git add nvim/.config/nvim/lazy-lock.json
   git commit -m "feat: Add LazyVim extra: <extra-name>"
   ```

**Method 2: Manual**
1. Create/edit a plugin file in `nvim/.config/nvim/lua/plugins/`
2. Add: `{ import = "lazyvim.plugins.extras.<category>.<name>" }`
3. Restart nvim or `:Lazy sync`
4. Commit as above

## Config Switching

### Default (Fresh LazyVim)
```bash
nvim                    # Uses nvim/.config/nvim/
```

### Old Config (nvim-full)
```bash
NVIM_APPNAME=nvim-full nvim
```

### Optional Shell Aliases
Add to `.zshrc`:
```bash
alias nvim-full='NVIM_APPNAME=nvim-full nvim'
alias nvim-kick='NVIM_APPNAME=nvim-kickstart nvim'
```

## Stow Management

After making changes to nvim configs:
```bash
stow -R nvim            # Refresh symlinks
```

Verify default symlink:
```bash
ls -la ~/.config/nvim   # Should point to dotfiles/nvim/.config/nvim
```

## Success Indicators

You'll know the setup is working when:
- ✅ `nvim` launches LazyVim without errors
- ✅ No autoformat on save (your preference)
- ✅ `w`, `e`, `b` motions feel smarter (nvim-spider)
- ✅ No buffer line at top (clean UI)
- ✅ Indentation auto-detected in files
- ✅ Language servers work for your primary languages
- ✅ `NVIM_APPNAME=nvim-full nvim` opens old config for reference
```

**Step 2: Verify migration reference created**

Run:
```bash
cat docs/nvim-migration-reference.md | head -30
```

Expected: File contains well-structured markdown with checklists

**Step 3: Commit migration reference**

Run:
```bash
git add docs/nvim-migration-reference.md
git commit -m "docs: Add nvim migration reference for cherry-picking

Comprehensive guide for migrating plugins and extras from nvim-full.
Includes cherry-pick workflow and config switching instructions.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Clean commit with 1 file added

---

## Task 7: Activate with Stow and Test

**Step 1: Refresh stow symlinks**

Run:
```bash
stow -R nvim
```

Expected: Stow updates symlinks, no errors

**Step 2: Verify symlink points to fresh config**

Run:
```bash
ls -la ~/.config/nvim
```

Expected output: Symlink points to `<dotfiles-path>/nvim/.config/nvim`

**Step 3: Test fresh LazyVim loads**

Run:
```bash
nvim --headless +Lazy! +qa
```

Expected: Command completes without errors (LazyVim installs plugins)

**Step 4: Test nvim-full config still accessible**

Run:
```bash
NVIM_APPNAME=nvim-full nvim --headless +Lazy! +qa
```

Expected: Command completes without errors (old config still works)

**Step 5: Manual verification (open nvim)**

Open nvim interactively:
```bash
nvim
```

Verify:
- LazyVim dashboard appears
- No errors in `:messages`
- `:Lazy` shows installed plugins
- `:LazyExtras` shows enabled extras
- Type `w` in normal mode (should use nvim-spider motion)
- No bufferline at top of screen

**Step 6: Document completion**

Create a summary of what was accomplished:
- Fresh LazyVim is default (`nvim`)
- Old config accessible (`NVIM_APPNAME=nvim-full nvim`)
- 4 essential customizations added
- 13 language extras installed
- 4 utility extras installed
- Migration reference created for future cherry-picking
- Clean git history with 6 granular commits

---

## Validation Checklist

After completing all tasks, verify:

- [ ] Fresh LazyVim loads without errors
- [ ] Old config accessible via `NVIM_APPNAME=nvim-full`
- [ ] No autoformat on save (test by editing a file)
- [ ] nvim-spider motions work (`w`/`e`/`b` feel different)
- [ ] No bufferline visible at top
- [ ] Language servers load for TypeScript, Go, Python, etc.
- [ ] Migration reference document exists and is accurate
- [ ] Stow symlink points to `nvim/.config/nvim`
- [ ] Git history shows 6 clean commits
- [ ] `nvim-full` config still works independently

## Next Steps

After implementation:

1. **Use fresh LazyVim** as your daily driver
2. **Reference migration doc** when you miss a feature
3. **Add extras gradually** via `:LazyExtras` as needed
4. **Cherry-pick plugins** from nvim-full when you remember "I had X"
5. **Commit each addition** with clear messages
6. **Update migration reference** to track what you've added

## Rollback Plan

If something goes wrong:

```bash
# Restore nvim-full as default
mv nvim/.config/nvim nvim/.config/nvim-fresh-backup
mv nvim/.config/nvim-full nvim/.config/nvim
stow -R nvim

# Or use git to revert commits
git log --oneline  # Find commit hash
git revert <hash>  # Revert specific commit
```
