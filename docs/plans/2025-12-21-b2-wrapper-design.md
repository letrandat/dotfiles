# b2 - Beads Wrapper Design

**Date:** 2025-12-21
**Status:** Draft
**Related Task:** dotfiles-ru8

## Overview

b2 is a lightweight wrapper around bd (beads) that provides quality-of-life improvements for personal task tracking across multiple git repositories and worktrees. It emphasizes stealth mode by default (no git pollution) while maintaining full bd compatibility as a drop-in replacement.

## Philosophy

- **Stealth-first**: Local-only by default, opt-in to git sync
- **Frictionless**: Create tasks anywhere without setup
- **Smart defaults**: Auto-detect context, minimize configuration
- **Zero-config for agents**: Auto-setup when run by AI assistants in cloud environments
- **Drop-in replacement**: 100% compatible with bd commands

## Core Features

### 1. Drop-in BD Wrapper
- Pass through all bd commands unchanged
- Add quality-of-life features transparently
- Maintain full bd compatibility

### 2. Short Hash Support
- Type `b2 close 8jk` instead of `b2 close dotfiles-8jk`
- Auto-expand short hashes (3-6 chars) with project prefix
- Only expand when in git repo with detected project

### 3. Shared Beads Location
- Single database for all repos: `~/.local/share/b2/beads.db`
- Project prefixes keep issues organized
- Unified view of all work across projects

### 4. Project Prefix Auto-Detection
- Extract repo name from git remote URL
- Examples:
  - `git@github.com:user/dotfiles.git` → `dotfiles`
  - `https://github.com/user/my-app.git` → `my-app`
- No prefix when not in git repo (add `needs-project` label)

### 5. Stealth Mode by Default
- Run with `--stealth --no-daemon` by default
- Use `--no-stealth` flag to enable git sync
- No `.beads/` in git, no commits unless explicitly requested

### 6. Update Checking
- Check for bd updates on every invocation (24hr cache)
- Compare: `bd --version` vs GitHub releases API
- Show gentle reminder if outdated, don't block execution
- Cache: `~/.cache/b2/last_update_check`

### 7. Configuration System
- Shell-sourceable key=value format
- Global: `~/.config/b2/config`
- Per-repo: `.b2rc` (overrides global)
- Environment variables override all (e.g., `B2_STEALTH_MODE=false`)

### 8. Stow Installable
- Source: `bin/.local/dotfiles-bin/b2`
- Install: `stow bin` → `~/.local/bin/b2`
- Shared library: `bin/.local/dotfiles-bin/get-project-name`

### 9. Auto-Install BD
- Detect if bd is missing
- Auto-install via: `curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash`
- Silent for cloud agents, show message for humans

### 10. Auto-Setup
- First-run initialization (create config, dirs)
- Zero-config for AI agents (detect via TTY)
- Create: `~/.config/b2/config`, `~/.local/share/b2/`, `~/.cache/b2/`

### 11. Cloud Agent Support
- Auto-setup environment when run by AI assistants
- Detect cloud/agent environment (no TTY = cloud)
- Silent initialization, sensible defaults

### 12. Non-Git-Repo Handling
- Warn: "Not in git repo - creating ticket without project prefix"
- Still create ticket
- Add `needs-project` label for later update

## Architecture

### Implementation: Pure Bash Wrapper

**Why bash:**
- No dependencies beyond bd
- Fits naturally in dotfiles/stow workflow
- Shell-sourceable config is trivial
- Sufficient for all features

**Main flow:**
```bash
b2
├── Config loading          # Source configs, set defaults
├── Environment detection   # Git repo? Cloud agent? bd installed?
├── Auto-setup             # First-run initialization
├── Update checking        # Check bd version (cached)
├── Hash expansion         # 8jk → dotfiles-8jk
└── bd invocation          # Pass through with modified args
```

## Technical Design

### Config File Format

**Default config (`~/.config/b2/config`):**
```bash
BEADS_LOCATION="${HOME}/.local/share/b2"
STEALTH_MODE=true
CHECK_UPDATES=true
UPDATE_CHECK_INTERVAL=86400  # 24 hours in seconds
BD_INSTALL_URL="https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh"
BD_REPO="steveyegge/beads"
DEFAULT_LABELS="needs-project"
```

**Loading priority:**
1. Built-in defaults
2. Global config: `~/.config/b2/config`
3. Per-repo config: `.b2rc`
4. Environment variables (e.g., `B2_STEALTH_MODE`)

### Project Prefix Detection

**Library: `get-project-name`**
```bash
# Extract repo name from git remote URL
get_project_prefix() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # git@github.com:user/dotfiles.git → dotfiles
        # https://github.com/user/my-app.git → my-app
        git remote get-url origin 2>/dev/null | \
            sed -E 's#.*/([^/]+)(\.git)?$#\1#' | \
            sed 's/\.git$//'
    else
        echo ""  # No project prefix
    fi
}
```

### Hash Expansion

**Logic:**
```bash
expand_hash() {
    local arg="$1"
    local project=$(get_project_prefix)

    # Short hash: alphanumeric, no dash, 3-6 chars
    if [[ "$arg" =~ ^[a-z0-9]{3,6}$ ]] && [[ -n "$project" ]]; then
        echo "${project}-${arg}"
    else
        echo "$arg"  # Pass through unchanged
    fi
}
```

### Update Checking

**Mechanism:**
```bash
# Cache: ~/.cache/b2/last_update_check
# Format: timestamp|current_version|latest_version

check_updates() {
    # Skip if cache < 24hrs old
    # Get current: bd --version | awk '{print $3}'
    # Get latest: curl -s https://api.github.com/repos/steveyegge/beads/releases/latest \
    #             | grep '"tag_name"' | sed -E 's/.*"tag_name": "([^"]+)".*/\1/'
    # Compare versions (strip 'v' prefix)
    # Show warning if outdated
    # Update cache
}
```

**Pattern borrowed from beads/scripts/install.sh (lines 104-122)**

### BD Invocation

**Build command:**
```bash
BD_FLAGS=()

# Stealth mode (unless --no-stealth passed)
if [[ "$STEALTH_MODE" == "true" ]] && [[ ! " $* " =~ " --no-stealth " ]]; then
    BD_FLAGS+=(--stealth)
fi

# Always no-daemon
BD_FLAGS+=(--no-daemon)

# Point to shared location
BD_FLAGS+=(--db "${BEADS_LOCATION}/beads.db")

# Filter and expand args
filtered_args=()
for arg in "$@"; do
    case "$arg" in
        --no-stealth)
            # Consumed by b2, don't pass to bd
            ;;
        *)
            # Expand hashes and pass through
            expanded=$(expand_hash "$arg")
            filtered_args+=("$expanded")
            ;;
    esac
done

# Special handling: create in non-git repo
if [[ "$1" == "create" ]] && [[ -z "$(get_project_prefix)" ]]; then
    filtered_args+=(--label needs-project)
fi

# Execute
exec bd "${BD_FLAGS[@]}" "${filtered_args[@]}"
```

### Auto-Setup Flow

**First-run detection:**
```bash
first_run_setup() {
    local config_file="${HOME}/.config/b2/config"
    local beads_dir="${BEADS_LOCATION:-${HOME}/.local/share/b2}"
    local cache_dir="${HOME}/.cache/b2"

    # Already initialized?
    [[ -f "$config_file" ]] && return 0

    # Detect cloud/agent (no TTY)
    local is_cloud=false
    [[ ! -t 0 ]] && is_cloud=true

    # Create directories
    mkdir -p "$(dirname "$config_file")" "$beads_dir" "$cache_dir"

    # Create default config
    cat > "$config_file" <<EOF
BEADS_LOCATION="${beads_dir}"
STEALTH_MODE=true
CHECK_UPDATES=true
UPDATE_CHECK_INTERVAL=86400
BD_INSTALL_URL="https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh"
BD_REPO="steveyegge/beads"
DEFAULT_LABELS="needs-project"
EOF

    # Auto-install bd if missing
    if ! command -v bd &>/dev/null; then
        $is_cloud || echo "Installing bd..." >&2
        curl -fsSL "$BD_INSTALL_URL" | bash
    fi

    # Welcome message (skip for cloud)
    if ! $is_cloud; then
        cat >&2 <<EOF
✓ b2 initialized successfully!
  Config: $config_file
  Beads:  $beads_dir

Run 'b2 create "My first task"' to get started.
EOF
    fi
}
```

## Directory Structure

### Dotfiles Repo Layout
```
dotfiles/
├── bin/
│   └── .local/
│       └── dotfiles-bin/
│           ├── b2                    # Main wrapper
│           ├── get-project-name      # Shared library (task: dotfiles-ru8)
│           └── bd-cheatsheet         # Existing
└── docs/
    └── plans/
        └── 2025-12-21-b2-wrapper-design.md
```

### Stow Installation
```bash
# From dotfiles repo root
stow bin    # Links b2 → ~/.local/bin/b2
```

### Runtime Directories
```
~/.local/share/b2/           # Shared beads database
├── beads.db                 # SQLite database
├── issues.jsonl             # JSONL export
└── config.yaml              # bd config (auto-generated)

~/.config/b2/                # b2 configuration
└── config                   # User config (auto-created)

~/.cache/b2/                 # Ephemeral data
└── last_update_check        # Update check cache (timestamp|current|latest)
```

## PATH Requirements

Both paths must be in PATH (see `zsh/.config/zsh/env.zsh:39-40`):
```bash
export PATH="$PATH:$HOME/.local/dotfiles-bin"  # Direct repo execution
export PATH="$PATH:$HOME/.local/bin"           # Stowed scripts
```

## Dependencies

- **Required:** bash, bd (auto-installed if missing)
- **Optional:** curl or wget (for install/update checking), git (for project detection)

## Implementation Notes

### Reusing Beads Patterns

From `beads/scripts/install.sh`:
- Platform detection (darwin/linux, amd64/arm64)
- Install to `~/.local/bin`
- macOS code signing (avoid Gatekeeper delays)
- PATH checking and warnings
- GitHub API version checking (no jq dependency)

### Edge Cases

1. **No git repo:** Warn + create ticket + add `needs-project` label
2. **No remote:** Same as no git repo
3. **bd not installed:** Auto-install via official script
4. **First run:** Auto-setup with defaults
5. **Cloud/agent environment:** Silent initialization
6. **Ambiguous hash:** Only expand if unique within project

## Success Criteria

- [ ] Drop-in replacement for bd (all commands work)
- [ ] Short hashes work: `b2 close 8jk`
- [ ] Stealth mode by default (no git commits)
- [ ] `--no-stealth` enables git sync
- [ ] Auto-install bd if missing
- [ ] Auto-setup on first run
- [ ] Update checking with caching
- [ ] Works in cloud/agent environments
- [ ] Non-git repos handled gracefully
- [ ] Stow installable
- [ ] Config system works (global + per-repo)
- [ ] Shared library `get-project-name` reusable

## Future Enhancements

- Tab completion for short hashes
- `b2 update` command to upgrade bd
- `b2 doctor` to diagnose setup issues
- Cross-project search/view (meta-tool)
- Shell prompt integration (show open tasks)
- Integration with bv (beads_viewer) TUI

## References

- Task: dotfiles-ru8 (extract get-project-name library)
- Beads repo: ~/workspace/beads
- Install script: scripts/install.sh
- Version checking: scripts/check-versions.sh
- BD config: .beads/config.yaml
