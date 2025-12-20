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
