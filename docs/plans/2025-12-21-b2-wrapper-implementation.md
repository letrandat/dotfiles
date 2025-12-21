# b2 Wrapper Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build b2, a stealth-first beads wrapper with auto-setup, hash expansion, and shared database for frictionless task tracking.

**Architecture:** Pure bash wrapper that loads config, detects environment, expands short hashes, and invokes bd with modified flags. Shared library extracts project names from git remotes.

**Tech Stack:** Bash 4+, bd (beads), git, curl/wget, stow

---

## Task 1: Create Shared Library - get-project-name

**Files:**
- Create: `bin/.local/dotfiles-bin/get-project-name`
- Test: Manual verification with various git repos

**Step 1: Write the get-project-name library**

Create executable bash library that extracts repo name from git remote URL.

```bash
#!/usr/bin/env bash
# get-project-name - Extract project name from git remote URL
# Usage: get-project-name [remote-name]
#   remote-name: Git remote to query (default: origin)
# Returns: Repository name (e.g., "dotfiles" from "github.com/user/dotfiles.git")
#          Empty string if not in git repo or remote not found

set -euo pipefail

get_project_name() {
    local remote="${1:-origin}"

    # Check if in git repo
    if ! git rev-parse --git-dir &>/dev/null; then
        return 0
    fi

    # Get remote URL
    local url
    url=$(git remote get-url "$remote" 2>/dev/null || echo "")

    if [[ -z "$url" ]]; then
        return 0
    fi

    # Extract repo name from various URL formats:
    # - git@github.com:user/dotfiles.git → dotfiles
    # - https://github.com/user/my-app.git → my-app
    # - https://github.com/user/repo → repo
    echo "$url" | sed -E 's#.*/([^/]+)(\.git)?$#\1#' | sed 's/\.git$//'
}

# If sourced, export function; if executed, run it
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    get_project_name "$@"
else
    export -f get_project_name
fi
```

**Step 2: Make executable**

```bash
chmod +x bin/.local/dotfiles-bin/get-project-name
```

**Step 3: Test with current repo**

```bash
# Should output "dotfiles"
bin/.local/dotfiles-bin/get-project-name
```

Expected output: `dotfiles`

**Step 4: Test outside git repo**

```bash
# Should output nothing
cd /tmp && /Users/dat/workspace/dotfiles/bin/.local/dotfiles-bin/get-project-name
```

Expected: Empty output, no errors

**Step 5: Test sourcing the library**

```bash
source bin/.local/dotfiles-bin/get-project-name
get_project_name
```

Expected output: `dotfiles`

**Step 6: Commit**

```bash
git add bin/.local/dotfiles-bin/get-project-name
git commit -m "feat: add get-project-name shared library

- Extract repo name from git remote URL
- Support various URL formats (git@, https://, etc.)
- Can be sourced or executed directly
- Returns empty string if not in git repo

Closes: dotfiles-ru8"
```

---

## Task 2: Create Main b2 Script - Skeleton

**Files:**
- Create: `bin/.local/dotfiles-bin/b2`

**Step 1: Write b2 script skeleton**

```bash
#!/usr/bin/env bash
# b2 - Beads wrapper with stealth mode, hash expansion, and auto-setup
# Usage: b2 [bd-commands...]
#
# Features:
# - Stealth mode by default (--no-stealth to enable git sync)
# - Short hash expansion (8jk → dotfiles-8jk)
# - Shared beads location (~/.local/share/b2)
# - Auto-install bd if missing
# - Auto-setup on first run
# - Update checking (24hr cache)

set -euo pipefail

# Version
B2_VERSION="0.1.0"

# Default configuration (overridden by config files and env vars)
BEADS_LOCATION="${B2_BEADS_LOCATION:-${HOME}/.local/share/b2}"
STEALTH_MODE="${B2_STEALTH_MODE:-true}"
CHECK_UPDATES="${B2_CHECK_UPDATES:-true}"
UPDATE_CHECK_INTERVAL="${B2_UPDATE_CHECK_INTERVAL:-86400}"  # 24 hours
BD_INSTALL_URL="${B2_BD_INSTALL_URL:-https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh}"
BD_REPO="${B2_BD_REPO:-steveyegge/beads}"
DEFAULT_LABELS="${B2_DEFAULT_LABELS:-needs-project}"

# Paths
CONFIG_DIR="${HOME}/.config/b2"
CONFIG_FILE="${CONFIG_DIR}/config"
CACHE_DIR="${HOME}/.cache/b2"
UPDATE_CACHE="${CACHE_DIR}/last_update_check"

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Logging functions
log_info() { echo -e "${BLUE}b2:${NC} $1" >&2; }
log_warn() { echo -e "${YELLOW}⚠️  $1${NC}" >&2; }
log_error() { echo -e "${RED}Error:${NC} $1" >&2; exit 1; }
log_success() { echo -e "${GREEN}✓${NC} $1" >&2; }

# Placeholder functions (to be implemented)
load_config() { :; }
first_run_setup() { :; }
check_updates() { :; }
get_project_prefix() { :; }
expand_hash() { echo "$1"; }

# Main entry point
main() {
    load_config
    first_run_setup
    [[ "$CHECK_UPDATES" == "true" ]] && check_updates

    # For now, just pass through to bd
    exec bd "$@"
}

main "$@"
```

**Step 2: Make executable**

```bash
chmod +x bin/.local/dotfiles-bin/b2
```

**Step 3: Test basic pass-through**

```bash
# Should show bd help
bin/.local/dotfiles-bin/b2 --help | head -5
```

Expected: BD help output starting with "Issues chained together like beads"

**Step 4: Commit**

```bash
git add bin/.local/dotfiles-bin/b2
git commit -m "feat: add b2 script skeleton

- Basic structure with logging functions
- Placeholder functions for features
- Pass-through to bd for now"
```

---

## Task 3: Implement Config Loading

**Files:**
- Modify: `bin/.local/dotfiles-bin/b2` (load_config function)

**Step 1: Implement load_config function**

Replace the placeholder `load_config() { :; }` with:

```bash
load_config() {
    # Load global config if exists
    if [[ -f "$CONFIG_FILE" ]]; then
        # shellcheck source=/dev/null
        source "$CONFIG_FILE"
    fi

    # Load per-repo config if exists
    if [[ -f ".b2rc" ]]; then
        # shellcheck source=/dev/null
        source ".b2rc"
    fi

    # Environment variables already override via ${VAR:-default} pattern
}
```

**Step 2: Test config loading**

```bash
# Create test config
mkdir -p ~/.config/b2
cat > ~/.config/b2/config <<EOF
STEALTH_MODE=false
CHECK_UPDATES=false
EOF

# Test that it loads (b2 should not error)
bin/.local/dotfiles-bin/b2 --help >/dev/null 2>&1 && echo "Config loaded successfully"
```

Expected: "Config loaded successfully"

**Step 3: Test per-repo config override**

```bash
# Create per-repo config
cat > .b2rc <<EOF
BEADS_LOCATION="/tmp/test-beads"
EOF

# Verify it loads (manual inspection in script if needed)
bin/.local/dotfiles-bin/b2 --help >/dev/null 2>&1 && echo "Per-repo config loaded"
```

Expected: "Per-repo config loaded"

**Step 4: Clean up test configs**

```bash
rm -f .b2rc
rm -rf ~/.config/b2
```

**Step 5: Commit**

```bash
git add bin/.local/dotfiles-bin/b2
git commit -m "feat: implement config loading

- Load global config from ~/.config/b2/config
- Load per-repo config from .b2rc
- Per-repo overrides global
- Environment variables override all"
```

---

## Task 4: Implement First-Run Auto-Setup

**Files:**
- Modify: `bin/.local/dotfiles-bin/b2` (first_run_setup function)

**Step 1: Implement first_run_setup function**

Replace the placeholder `first_run_setup() { :; }` with:

```bash
first_run_setup() {
    # Already initialized?
    [[ -f "$CONFIG_FILE" ]] && return 0

    # Detect cloud/agent environment (no TTY)
    local is_cloud=false
    [[ ! -t 0 ]] && is_cloud=true

    # Create directories
    mkdir -p "$CONFIG_DIR" "$BEADS_LOCATION" "$CACHE_DIR"

    # Create default config
    cat > "$CONFIG_FILE" <<EOF
# b2 configuration
# See: https://github.com/yourusername/dotfiles/blob/main/docs/plans/2025-12-21-b2-wrapper-design.md

BEADS_LOCATION="${BEADS_LOCATION}"
STEALTH_MODE=true
CHECK_UPDATES=true
UPDATE_CHECK_INTERVAL=86400
BD_INSTALL_URL="${BD_INSTALL_URL}"
BD_REPO="${BD_REPO}"
DEFAULT_LABELS="${DEFAULT_LABELS}"
EOF

    # Check for bd, install if missing
    if ! command -v bd &>/dev/null; then
        $is_cloud || log_info "bd not found, installing..."
        if command -v curl &>/dev/null; then
            curl -fsSL "$BD_INSTALL_URL" | bash
        else
            log_error "curl not found. Please install curl or bd manually."
        fi
    fi

    # Welcome message (unless cloud)
    if ! $is_cloud; then
        cat >&2 <<EOF

${GREEN}✓ b2 initialized successfully!${NC}
  Config: $CONFIG_FILE
  Beads:  $BEADS_LOCATION

Run 'b2 create "My first task"' to get started.

EOF
    fi
}
```

**Step 2: Test first-run setup**

```bash
# Remove config to simulate first run
rm -rf ~/.config/b2 ~/.local/share/b2 ~/.cache/b2

# Run b2 (should auto-setup)
bin/.local/dotfiles-bin/b2 --version
```

Expected: Welcome message + bd version output

**Step 3: Verify directories created**

```bash
ls -la ~/.config/b2/config
ls -ld ~/.local/share/b2
ls -ld ~/.cache/b2
```

Expected: All directories/files exist

**Step 4: Verify config content**

```bash
cat ~/.config/b2/config | grep "STEALTH_MODE=true"
```

Expected: Line containing STEALTH_MODE=true

**Step 5: Commit**

```bash
git add bin/.local/dotfiles-bin/b2
git commit -m "feat: implement first-run auto-setup

- Create config, beads, and cache directories
- Generate default config file
- Auto-install bd if missing
- Show welcome message (skip for cloud/agents)
- Detect cloud environment via TTY check"
```

---

## Task 5: Implement Update Checking

**Files:**
- Modify: `bin/.local/dotfiles-bin/b2` (check_updates function)

**Step 1: Implement check_updates function**

Replace the placeholder `check_updates() { :; }` with:

```bash
check_updates() {
    # Check cache age
    if [[ -f "$UPDATE_CACHE" ]]; then
        local cache_age=$(($(date +%s) - $(stat -f %m "$UPDATE_CACHE" 2>/dev/null || stat -c %Y "$UPDATE_CACHE" 2>/dev/null || echo 0)))
        [[ $cache_age -lt $UPDATE_CHECK_INTERVAL ]] && return 0
    fi

    # Get current version
    local current
    current=$(bd --version 2>/dev/null | awk '{print $3}' || echo "unknown")

    # Get latest version from GitHub API
    local latest
    if command -v curl &>/dev/null; then
        latest=$(curl -fsSL "https://api.github.com/repos/${BD_REPO}/releases/latest" 2>/dev/null | \
                 grep '"tag_name"' | sed -E 's/.*"tag_name": "([^"]+)".*/\1/' || echo "unknown")
    elif command -v wget &>/dev/null; then
        latest=$(wget -qO- "https://api.github.com/repos/${BD_REPO}/releases/latest" 2>/dev/null | \
                 grep '"tag_name"' | sed -E 's/.*"tag_name": "([^"]+)".*/\1/' || echo "unknown")
    else
        return 0  # Skip if no curl/wget
    fi

    # Strip 'v' prefix from latest
    latest="${latest#v}"

    # Update cache
    mkdir -p "$CACHE_DIR"
    echo "$(date +%s)|${current}|${latest}" > "$UPDATE_CACHE"

    # Compare versions (simple string comparison)
    if [[ "$current" != "unknown" ]] && [[ "$latest" != "unknown" ]] && [[ "$current" != "$latest" ]]; then
        log_warn "bd update available: ${current} → ${latest}"
        echo "  Run: curl -fsSL ${BD_INSTALL_URL} | bash" >&2
        echo "" >&2
    fi
}
```

**Step 2: Test update checking (force by removing cache)**

```bash
rm -f ~/.cache/b2/last_update_check

# Should check and cache result
bin/.local/dotfiles-bin/b2 --version
```

Expected: Possible update warning (if behind), then bd version

**Step 3: Verify cache created**

```bash
cat ~/.cache/b2/last_update_check
```

Expected: Line with format `timestamp|current_version|latest_version`

**Step 4: Test cache prevents re-checking**

```bash
# Run again immediately - should not re-check
bin/.local/dotfiles-bin/b2 --version 2>&1 | grep -q "update available" && echo "FAIL: Should use cache" || echo "PASS: Used cache"
```

Expected: "PASS: Used cache"

**Step 5: Commit**

```bash
git add bin/.local/dotfiles-bin/b2
git commit -m "feat: implement update checking

- Check bd version against GitHub releases API
- Cache results for 24 hours
- Show warning if update available
- Support both curl and wget
- Skip gracefully if no internet"
```

---

## Task 6: Implement Project Prefix Detection

**Files:**
- Modify: `bin/.local/dotfiles-bin/b2` (get_project_prefix function)

**Step 1: Implement get_project_prefix function**

Replace the placeholder `get_project_prefix() { :; }` with:

```bash
get_project_prefix() {
    # Use the shared library
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    if [[ -x "${script_dir}/get-project-name" ]]; then
        "${script_dir}/get-project-name"
    elif command -v get-project-name &>/dev/null; then
        get-project-name
    else
        # Fallback: inline implementation
        if git rev-parse --git-dir &>/dev/null; then
            git remote get-url origin 2>/dev/null | \
                sed -E 's#.*/([^/]+)(\.git)?$#\1#' | \
                sed 's/\.git$//'
        fi
    fi
}
```

**Step 2: Test project prefix detection**

```bash
# Should output "dotfiles"
bin/.local/dotfiles-bin/b2 --help >/dev/null 2>&1
PROJECT=$(cd /Users/dat/workspace/dotfiles && source bin/.local/dotfiles-bin/b2 && get_project_prefix)
echo "Project: $PROJECT"
```

Expected: "Project: dotfiles"

**Step 3: Test outside git repo**

```bash
cd /tmp
PROJECT=$(/Users/dat/workspace/dotfiles/bin/.local/dotfiles-bin/b2 --help >/dev/null 2>&1; echo "")
[[ -z "$PROJECT" ]] && echo "PASS: No project outside git" || echo "FAIL: Should be empty"
cd /Users/dat/workspace/dotfiles
```

Expected: "PASS: No project outside git"

**Step 4: Commit**

```bash
git add bin/.local/dotfiles-bin/b2
git commit -m "feat: implement project prefix detection

- Use get-project-name shared library
- Fallback to inline implementation if library not found
- Return empty string if not in git repo"
```

---

## Task 7: Implement Hash Expansion

**Files:**
- Modify: `bin/.local/dotfiles-bin/b2` (expand_hash function)

**Step 1: Implement expand_hash function**

Replace the placeholder `expand_hash() { echo "$1"; }` with:

```bash
expand_hash() {
    local arg="$1"
    local project
    project=$(get_project_prefix)

    # Short hash: alphanumeric, no dash, 3-6 chars
    if [[ "$arg" =~ ^[a-z0-9]{3,6}$ ]] && [[ -n "$project" ]]; then
        echo "${project}-${arg}"
    else
        echo "$arg"  # Pass through unchanged
    fi
}
```

**Step 2: Test hash expansion with mock**

```bash
# Test in dotfiles repo (project = "dotfiles")
source bin/.local/dotfiles-bin/b2
TEST_HASH=$(expand_hash "8jk")
[[ "$TEST_HASH" == "dotfiles-8jk" ]] && echo "PASS: Hash expanded" || echo "FAIL: Expected dotfiles-8jk, got $TEST_HASH"
```

Expected: "PASS: Hash expanded"

**Step 3: Test pass-through (non-hash)**

```bash
source bin/.local/dotfiles-bin/b2
TEST_FULL=$(expand_hash "dotfiles-8jk")
[[ "$TEST_FULL" == "dotfiles-8jk" ]] && echo "PASS: Full ID unchanged" || echo "FAIL: Should not expand"
```

Expected: "PASS: Full ID unchanged"

**Step 4: Test pass-through (too long)**

```bash
source bin/.local/dotfiles-bin/b2
TEST_LONG=$(expand_hash "toolong123")
[[ "$TEST_LONG" == "toolong123" ]] && echo "PASS: Long hash unchanged" || echo "FAIL: Should not expand"
```

Expected: "PASS: Long hash unchanged"

**Step 5: Commit**

```bash
git add bin/.local/dotfiles-bin/b2
git commit -m "feat: implement hash expansion

- Expand short hashes (3-6 chars) with project prefix
- Only expand alphanumeric without dash
- Pass through full IDs and other args unchanged"
```

---

## Task 8: Implement BD Invocation with Stealth Mode

**Files:**
- Modify: `bin/.local/dotfiles-bin/b2` (main function)

**Step 1: Update main function to build bd command properly**

Replace the `main()` function with:

```bash
main() {
    load_config
    first_run_setup
    [[ "$CHECK_UPDATES" == "true" ]] && check_updates

    # Build bd flags
    local bd_flags=()
    local filtered_args=()
    local no_stealth=false

    # Check for --no-stealth in args
    for arg in "$@"; do
        if [[ "$arg" == "--no-stealth" ]]; then
            no_stealth=true
        fi
    done

    # Add stealth mode (unless --no-stealth)
    if [[ "$STEALTH_MODE" == "true" ]] && [[ "$no_stealth" == "false" ]]; then
        bd_flags+=(--stealth)
    fi

    # Always add no-daemon
    bd_flags+=(--no-daemon)

    # Point to shared beads location
    bd_flags+=(--db "${BEADS_LOCATION}/beads.db")

    # Process arguments
    local is_create=false
    [[ "$1" == "create" ]] && is_create=true

    for arg in "$@"; do
        case "$arg" in
            --no-stealth)
                # Consumed by b2, don't pass to bd
                ;;
            *)
                # Expand hashes and add to filtered args
                filtered_args+=("$(expand_hash "$arg")")
                ;;
        esac
    done

    # Add needs-project label for create in non-git repo
    if [[ "$is_create" == "true" ]] && [[ -z "$(get_project_prefix)" ]]; then
        log_warn "Not in a git repo - creating ticket without project prefix"
        echo "   Add '${DEFAULT_LABELS}' label to update later" >&2
        filtered_args+=(--label "$DEFAULT_LABELS")
    fi

    # Execute bd
    exec bd "${bd_flags[@]}" "${filtered_args[@]}"
}
```

**Step 2: Test stealth mode by default**

```bash
# Create a test task
bin/.local/dotfiles-bin/b2 create "Test stealth mode" --json | jq -r '.id'
```

Expected: Task ID returned (e.g., "dotfiles-abc")

**Step 3: Verify no git changes**

```bash
git status --short | grep -q ".beads" && echo "FAIL: Should be stealth" || echo "PASS: Stealth mode working"
```

Expected: "PASS: Stealth mode working"

**Step 4: Test --no-stealth flag**

```bash
# This would enable git sync (skip for now since we're in stealth)
# Just verify flag is accepted
bin/.local/dotfiles-bin/b2 --no-stealth list --json >/dev/null && echo "PASS: --no-stealth accepted"
```

Expected: "PASS: --no-stealth accepted"

**Step 5: Test hash expansion in actual command**

```bash
# Get a task hash (last 3 chars of an existing task)
TASK_ID=$(bin/.local/dotfiles-bin/b2 list --json | jq -r '.[0].id' | grep -o '[a-z0-9]\{3\}$')
if [[ -n "$TASK_ID" ]]; then
    bin/.local/dotfiles-bin/b2 show "$TASK_ID" --json | jq -r '.id' | grep -q "dotfiles-$TASK_ID" && echo "PASS: Hash expanded in command"
else
    echo "SKIP: No tasks to test with"
fi
```

Expected: "PASS: Hash expanded in command" or "SKIP"

**Step 6: Test non-git repo warning**

```bash
cd /tmp
/Users/dat/workspace/dotfiles/bin/.local/dotfiles-bin/b2 create "Test non-git" 2>&1 | grep -q "Not in a git repo" && echo "PASS: Warning shown"
cd /Users/dat/workspace/dotfiles
```

Expected: "PASS: Warning shown"

**Step 7: Commit**

```bash
git add bin/.local/dotfiles-bin/b2
git commit -m "feat: implement bd invocation with stealth mode

- Add --stealth and --no-daemon by default
- Support --no-stealth flag to enable git sync
- Point to shared beads location
- Expand hashes in arguments
- Warn and add label for create in non-git repos"
```

---

## Task 9: Add Usage and Help

**Files:**
- Modify: `bin/.local/dotfiles-bin/b2` (add help handling)

**Step 1: Add help text at top of file**

After the shebang and before `set -euo pipefail`, add:

```bash
#!/usr/bin/env bash
# b2 - Beads wrapper with stealth mode, hash expansion, and auto-setup
#
# USAGE:
#   b2 [options] <bd-command> [args...]
#
# OPTIONS:
#   --no-stealth    Enable git sync (default: stealth mode)
#   --help          Show this help
#   --version       Show b2 version
#
# EXAMPLES:
#   b2 create "My task"              # Create task (stealth mode)
#   b2 list                          # List tasks
#   b2 close 8jk                     # Close task (hash expansion)
#   b2 --no-stealth sync             # Enable git sync for this command
#
# FEATURES:
#   - Stealth mode by default (no git commits)
#   - Short hash expansion (8jk → dotfiles-8jk)
#   - Shared beads location (~/.local/share/b2)
#   - Auto-install bd if missing
#   - Auto-setup on first run
#   - Update checking (24hr cache)
#
# CONFIG:
#   Global: ~/.config/b2/config
#   Per-repo: .b2rc (overrides global)
#   Environment: B2_* variables (overrides all)
#
# DESIGN:
#   See: docs/plans/2025-12-21-b2-wrapper-design.md

set -euo pipefail
```

**Step 2: Add version and help handling in main**

Before `main "$@"` at the bottom, add:

```bash
# Handle --help and --version before main
if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
    grep '^#' "$0" | grep -v '#!/usr/bin/env bash' | sed 's/^# \?//'
    exit 0
fi

if [[ "${1:-}" == "--version" ]] || [[ "${1:-}" == "-v" ]]; then
    echo "b2 version ${B2_VERSION}"
    bd --version 2>/dev/null || echo "  (bd not installed)"
    exit 0
fi

main "$@"
```

**Step 3: Test help output**

```bash
bin/.local/dotfiles-bin/b2 --help | head -10
```

Expected: Help text with USAGE, OPTIONS, etc.

**Step 4: Test version output**

```bash
bin/.local/dotfiles-bin/b2 --version
```

Expected: "b2 version 0.1.0" + bd version

**Step 5: Commit**

```bash
git add bin/.local/dotfiles-bin/b2
git commit -m "feat: add help and version output

- Add comprehensive help text in header
- Handle --help/-h flag
- Handle --version/-v flag
- Show b2 and bd versions"
```

---

## Task 10: Install via Stow and Test

**Files:**
- Test: Installation via stow

**Step 1: Stow the bin directory**

```bash
cd ~/workspace/dotfiles
stow bin
```

**Step 2: Verify symlinks created**

```bash
ls -la ~/.local/bin/b2
ls -la ~/.local/bin/get-project-name
```

Expected: Both are symlinks pointing to dotfiles-bin

**Step 3: Test b2 from PATH**

```bash
which b2
b2 --version
```

Expected: Shows path and version

**Step 4: Create a test task using installed b2**

```bash
b2 create "Test b2 installation" -t task -p 2 --json | jq -r '.id'
```

Expected: Task ID (e.g., "dotfiles-xyz")

**Step 5: Test hash expansion with real task**

```bash
HASH=$(b2 list --json | jq -r '.[0].id' | grep -o '[a-z0-9]\{3\}$')
b2 show "$HASH" --json | jq -r '.title'
```

Expected: Shows task title

**Step 6: Close the test task**

```bash
HASH=$(b2 list --json | jq -r '.[] | select(.title == "Test b2 installation") | .id' | grep -o '[a-z0-9]\{3\}$')
b2 close "$HASH" --reason "Installation test complete"
```

**Step 7: Commit installation verification**

```bash
git add -A
git commit -m "test: verify b2 installation via stow

- Stow bin directory successfully
- b2 and get-project-name available in PATH
- Hash expansion working
- Stealth mode confirmed
- All features operational"
```

---

## Task 11: Update bd Task (Close dotfiles-ru8)

**Files:**
- None (bd command only)

**Step 1: Close the library extraction task**

```bash
b2 close ru8 --reason "Completed: get-project-name library extracted and integrated into b2"
```

**Step 2: Create task for documentation**

```bash
b2 create "Add b2 wrapper to README/documentation" -t task -p 2 --description "Document b2 usage, features, and installation in main README or docs" --json
```

**Step 3: List open tasks to verify**

```bash
b2 list --status open --json | jq -r '.[] | "\(.id): \(.title)"'
```

---

## Task 12: Final Testing and Polish

**Files:**
- Test: End-to-end scenarios

**Step 1: Test config override (per-repo)**

```bash
# Create per-repo config
cat > .b2rc <<EOF
CHECK_UPDATES=false
EOF

# Verify it loads without update check
b2 list >/dev/null 2>&1
rm .b2rc
```

**Step 2: Test environment variable override**

```bash
B2_STEALTH_MODE=false b2 list >/dev/null 2>&1 && echo "PASS: Env var override works"
```

Expected: "PASS: Env var override works"

**Step 3: Test error handling (bd not in PATH)**

```bash
# Temporarily hide bd
PATH_BACKUP="$PATH"
export PATH="/usr/bin:/bin"
if command -v bd &>/dev/null; then
    echo "SKIP: bd still in PATH"
else
    b2 --version 2>&1 | grep -q "Installing" || echo "Auto-install would trigger"
fi
export PATH="$PATH_BACKUP"
```

**Step 4: Test in different repo**

```bash
cd ~/workspace/beads
b2 list --json | jq -r '.[0].id' | grep -q "^beads-" && echo "PASS: Project prefix changes per repo"
cd ~/workspace/dotfiles
```

Expected: "PASS: Project prefix changes per repo"

**Step 5: Run shellcheck for linting**

```bash
shellcheck bin/.local/dotfiles-bin/b2 bin/.local/dotfiles-bin/get-project-name || echo "Review shellcheck warnings"
```

**Step 6: Final commit**

```bash
git add -A
git commit -m "test: comprehensive end-to-end testing

- Config override (per-repo and env vars)
- Error handling verified
- Multi-repo support confirmed
- Shellcheck linting applied
- All features operational"
```

---

## Success Criteria Verification

After implementation, verify all design goals are met:

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

## Commands Reference

**Run all tests:**
```bash
cd ~/workspace/dotfiles
./bin/.local/dotfiles-bin/b2 --version
b2 create "Test task" --json
b2 list --json
```

**Reinstall via stow:**
```bash
stow -R bin
```

**Verify installation:**
```bash
which b2
which get-project-name
b2 --help
```

## Notes

- Each task is designed to be implemented in 5-10 minutes
- Commit after each task to maintain clean history
- Test thoroughly before moving to next task
- If tests fail, debug before proceeding
- Keep commits atomic and descriptive
- Use shellcheck to catch common bash errors
- Test in multiple repos to verify project detection
